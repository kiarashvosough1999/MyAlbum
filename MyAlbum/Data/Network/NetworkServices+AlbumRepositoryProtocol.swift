//
//  NetworkServices+AlbumRepositoryProtocol.swift
//  MyAlbum
//
//  Created by Kiarash Vosough on 7/13/23.
//

import Foundation
import Dependencies

extension NetworkServices: AlbumRepositoryProtocol {

    func fetchAlbums() async throws -> [AlbumEntity] {
        let result = try await session.data(for: AlbumRequest.allAlbums)
        guard result.statusCode == .OK else { throw NetworkError.requestFailed }
        return try result.decode(to: [AlbumEntity].self)
    }
}

// MARK: - Request

fileprivate enum AlbumRequest {
    case allAlbums
}

extension AlbumRequest: API {

    var gateway: GateWays { .base }
    var method: HTTPMethod { .get }
    var route: String { "albums" }
}

// MARK: - Dependency

extension DependencyValues {
    
    var albumRepository: AlbumRepositoryProtocol {
        get {
            self[Key.self]
        } set {
            self[Key.self] = newValue
        }
    }
    
    private enum Key: DependencyKey {
        static var liveValue: AlbumRepositoryProtocol { NetworkServices.shared }
    }
}
