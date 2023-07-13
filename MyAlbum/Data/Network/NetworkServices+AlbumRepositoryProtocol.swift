//
//  NetworkServices+AlbumRepositoryProtocol.swift
//  MyAlbum
//
//  Created by Kiarash Vosough on 7/13/23.
//

import Foundation

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
