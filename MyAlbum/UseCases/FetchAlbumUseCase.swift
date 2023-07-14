//
//  FetchAlbumUseCase.swift
//  MyAlbum
//
//  Created by Kiarash Vosough on 7/13/23.
//

import Dependencies

// MARK: - Abstraction

protocol FetchAlbumUseCaseProtocol {
    func fetchAlbums() async throws -> [AlbumWithImageEntity]
}

// MARK: - Implementation

struct FetchAlbumUseCase {
    @Dependency(\.albumRepository) private var albumRepository
    @Dependency(\.fetchPhotoUseCase) private var fetchPhotoUseCase
}

extension FetchAlbumUseCase: FetchAlbumUseCaseProtocol {

    func fetchAlbums() async throws -> [AlbumWithImageEntity] {
        let albums = try await albumRepository.fetchAlbums()
        /// Aggregate the thumbnailUrl with each Album
        /// thumbnailUrl is selected from Photos whthin the album
        return try await withThrowingTaskGroup(of: AlbumWithImageEntity.self, returning: [AlbumWithImageEntity].self) { group in
            let mapper = AlbumEntityToAlbumWithImageEntityMapper()
            for album in albums {
                group.addTask {
                    let photo = try await fetchPhotoUseCase.fetchPhoto(albumId: album.id)
                    let context = AlbumEntityToAlbumWithImageEntityMapper.Context(thumbnailUrl: photo.thumbnailUrl)
                    return mapper.map(album, context: context)
                }
            }
            
            var result: [AlbumWithImageEntity] = []
            for try await album in group {
                result.append(album)
            }
            return result
        }
    }
}

// MARK: - Dependency

extension DependencyValues {
    
    var fetchAlbumUseCase: FetchAlbumUseCaseProtocol {
        get {
            self[Key.self]
        } set {
            self[Key.self] = newValue
        }
    }
    
    private enum Key: DependencyKey {
        static var liveValue: FetchAlbumUseCaseProtocol { FetchAlbumUseCase() }
    }
}
