//
//  NetworkServices+PhotosRepositoryProtocol.swift
//  MyAlbum
//
//  Created by Kiarash Vosough on 7/13/23.
//

import Dependencies

extension NetworkServices: PhotosRepositoryProtocol {
    
    func fetchPhotos(albumId: Int) async throws -> [PhotoEntity]{
        let result = try await session.data(for: PhotoRequest.photo)
        guard result.statusCode == .OK else { throw NetworkError.requestFailed }
        return try result.decode(to: [PhotoEntity].self)
    }
    func fetchPhoto(albumId: Int, photoId: Int) async throws -> PhotoEntity{
        let result = try await session.data(for: PhotoRequest.photoById(id: photoId, albumId: albumId))
        guard result.statusCode == .OK else { throw NetworkError.requestFailed }
        return try result.decode(to: PhotoEntity.self)
    }
}

// MARK: - Request

fileprivate enum PhotoRequest {
    case photo
    case photoById(id: Int, albumId: Int)
}

extension PhotoRequest: API {

    var gateway: GateWays { .base }
    var method: HTTPMethod { .get }
    var route: String { "photos" }

    var query: [String : Any]? {
        switch self {
        case let .photoById(id, albumId):
            KeyValue(value: id)
            KeyValue(key: "albumId", value: albumId)
        default:
            KeyValue.empty
        }
    }
}

// MARK: - Dependency

extension DependencyValues {
    
    var photosRepository: PhotosRepositoryProtocol {
        get {
            self[Key.self]
        } set {
            self[Key.self] = newValue
        }
    }
    
    private enum Key: DependencyKey {
        static var liveValue: PhotosRepositoryProtocol { NetworkServices.shared }
    }
}
