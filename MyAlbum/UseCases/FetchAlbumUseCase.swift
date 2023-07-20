//
//  FetchAlbumUseCase.swift
//  MyAlbum
//
//  Created by Kiarash Vosough on 7/13/23.
//

import Dependencies

// MARK: - Abstraction

protocol FetchAlbumUseCaseProtocol {
    func fetchAlbums() async throws -> [AlbumEntity]
}

// MARK: - Implementation

struct FetchAlbumUseCase {
    @Dependency(\.albumRepository) private var albumRepository
}

extension FetchAlbumUseCase: FetchAlbumUseCaseProtocol {

    func fetchAlbums() async throws -> [AlbumEntity] {
        try await albumRepository.fetchAlbums()
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
