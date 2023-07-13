//
//  API.swift
//  MyAlbum
//
//  Created by Kiarash Vosough on 7/13/23.
//

import Foundation

protocol API {
    
    var method: HTTPMethod { get }
    var gateway: GateWays { get }
    var route: String { get }
    var headerParams: [String: Any] { get }
    var useCache: Bool { get }

    @BodyBuilder
    var body: [String: Any]? { get }
    
    @BodyBuilder
    var query: [String: Any]? { get }

    var encodableBody: Encodable? { get }
    
    func asURLRequest() async throws -> URLRequest
}

extension API {

    var headerParams: [String: Any] { [:] }
    var useCache: Bool { false }

    var encodableBody: Encodable? { nil }
    var body: [String: Any]? { nil }
    var query: [String: Any]? { nil }
    
    func asURLRequest() async throws -> URLRequest {
        let gateway = try gateway.get()

        var url = gateway.appending(path: route)
        updateURL(baseURL: &url)

        var urlRequest = URLRequest(url: url, cachePolicy: useCache ? .returnCacheDataElseLoad : .useProtocolCachePolicy)
        urlRequest.httpMethod = method.rawValue
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.setValue("application/json", forHTTPHeaderField: "Accept")

        try updateBody(urlRequest: &urlRequest)
        updateHeaders(urlRequest: &urlRequest)

        return urlRequest
    }

    private func updateURL(baseURL: inout URL) {
        if let query, query.isEmpty == false {
            
            // for those url parameter like id which has no key and come after `/`
            query
                .filter { $0.key.isEmpty }
                .map(\.value)
                .forEach { value in
                    baseURL.append(path: "\(value)")
                }

            // for those url parameter which has key.
            let namedQueries = query.filter { $0.key.isEmpty == false }
            if namedQueries.isEmpty == false,
               var components = URLComponents(url: baseURL, resolvingAgainstBaseURL: false)
            {
                components.queryItems = namedQueries
                    .map { URLQueryItem(name: $0, value: "\($1)") }
                if let newURL = components.url {
                    baseURL = newURL
                }
            }
        }
    }

    private func updateBody(urlRequest: inout URLRequest) throws {
        if method == .post || method == .patch {
            if let body,
               body.isEmpty == false,
               let jsonData = try? JSONSerialization.data(withJSONObject: body)
            {
                urlRequest.httpBody = jsonData
            } else if let encodableBody {
                urlRequest.httpBody = try JSONEncoder().encode(encodableBody)
            }
        }
    }

    private func updateHeaders(urlRequest: inout URLRequest) {
        headerParams.forEach { param in
            urlRequest.setValue("\(param.value)", forHTTPHeaderField: param.key)
        }
    }
}

internal struct KeyValue {

    static let empty = KeyValue()
    
    fileprivate let key: String
    fileprivate let value: Any
    fileprivate let isEmpty: Bool

    internal init(key: String = "", value: Any) {
        self.key = key
        self.value = value
        self.isEmpty = false
    }
    
    private init() {
        self.key = ""
        self.value = ""
        self.isEmpty = true
    }
}

@resultBuilder
struct BodyBuilder {
    
    static func buildBlock(_ components: KeyValue...) -> [String: Any]? {
        components
            .filter { $0.isEmpty == false }
            .reduce(into: [String: Any]()) { partialResult, keyValue in
                partialResult[keyValue.key] = keyValue.value
            }
    }

    static func buildBlock(_ components: [String: Any]?...) -> [String: Any]? {
        Dictionary(
            uniqueKeysWithValues: components
                .compactMap { $0 }
                .flatMap { $0 }
                .map { ($0.key, $0.value) }
        )
    }
    
    static func buildEither(first component: [String : Any]?) -> [String : Any]? {
        component
    }

    static func buildEither(second component: [String : Any]?) -> [String : Any]? {
        component
    }
}
