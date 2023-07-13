//
//  FetchPhotoUseCase.swift
//  MyAlbum
//
//  Created by Kiarash Vosough on 7/13/23.
//

import Dependencies

// MARK: - Abstraction

protocol FetchPhotoUseCaseProtocol {
    func fetchPhotos(albumId: Int) async throws -> [PhotoEntity]
    func fetchPhoto(albumId: Int) async throws -> PhotoEntity
}

// MARK: - Implementation

struct FetchPhotoUseCase {
    @Dependency(\.photosRepository) private var photosRepository
    
    private var photosInAlbumCount: Int { 50 }
}

extension FetchPhotoUseCase: FetchPhotoUseCaseProtocol {

    func fetchPhotos(albumId: Int) async throws -> [PhotoEntity] {
        try await photosRepository
            .fetchPhotos(albumId: albumId)
    }

    func fetchPhoto(albumId: Int) async throws -> PhotoEntity {
        let photoId = photosInAlbumCount * (albumId - 1) + 1
        return try await photosRepository.fetchPhoto(albumId: albumId, photoId: photoId)
    }
}

// MARK: - Dependency

extension DependencyValues {
    
    var fetchPhotoUseCase: FetchPhotoUseCaseProtocol {
        get {
            self[Key.self]
        } set {
            self[Key.self] = newValue
        }
    }
    
    private enum Key: DependencyKey {
        static var liveValue: FetchPhotoUseCaseProtocol { FetchPhotoUseCase() }
    }
}
