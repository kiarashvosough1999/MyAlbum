//
//  FetchAlbumUseCaseStub.swift
//  MyAlbumTests
//
//  Created by Kiarash Vosough on 7/14/23.
//

import Foundation
@testable import MyAlbum

final class FetchAlbumUseCaseStub {
    private let error: Error?
    private let delayInSeconds: UInt64
    private let albums: [MyAlbum.AlbumEntity]
    
    init(
        error: Error? = nil,
        delayInSeconds: UInt64 = 0,
        albums: [MyAlbum.AlbumEntity] = []
    ) {
        self.error = error
        self.delayInSeconds = delayInSeconds
        self.albums = albums
    }
}

extension FetchAlbumUseCaseStub: FetchAlbumUseCaseProtocol {
    func fetchAlbums() async throws -> [MyAlbum.AlbumEntity] {
        try await Task.sleep(nanoseconds: delayInSeconds * NSEC_PER_SEC)
        if let error { throw error }
        return albums
    }
}
