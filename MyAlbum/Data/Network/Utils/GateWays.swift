//
//  GateWays.swift
//  MyAlbum
//
//  Created by Kiarash Vosough on 7/13/23.
//

import Foundation

internal enum GateWays: String {
    case base = "https://jsonplaceholder.typicode.com"
}

extension GateWays {

    func get() throws -> URL {
        return try URL(gateway: self)
    }
}

fileprivate extension URL {

    init<G>(gateway: G) throws where G: RawRepresentable, G.RawValue == String {
        guard let url = URL(string: gateway.rawValue) else { throw NetworkError.apiURLException }
        self = url
    }
}
