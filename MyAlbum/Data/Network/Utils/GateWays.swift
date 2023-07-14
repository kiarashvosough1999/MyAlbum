//
//  GateWays.swift
//  MyAlbum
//
//  Created by Kiarash Vosough on 7/13/23.
//

import Foundation

/// Gateways of application to send and receive data
internal enum GateWays: String {
    case base = "https://jsonplaceholder.typicode.com"
}

extension GateWays {

    func get() throws -> URL {
        guard let url = URL(string: rawValue) else { throw NetworkError.apiURLException }
        return url
    }
}
