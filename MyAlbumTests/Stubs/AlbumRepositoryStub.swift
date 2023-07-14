//
//  AlbumRepositoryStub.swift
//  MyAlbumTests
//
//  Created by Kiarash Vosough on 7/13/23.
//

import Foundation
@testable import MyAlbum

final class AlbumRepositoryStub {
    private let error: Error?
    private let delayInSeconds: UInt64
    private let albums: [MyAlbum.AlbumEntity]

    init(delayInSeconds: UInt64 = 0, error: Error? = nil, albums: [MyAlbum.AlbumEntity] = []) {
        self.delayInSeconds = delayInSeconds
        self.error = error
        self.albums = albums
    }
}

extension AlbumRepositoryStub: AlbumRepositoryProtocol {

    func fetchAlbums() async throws -> [MyAlbum.AlbumEntity] {
        try await Task.sleep(nanoseconds: delayInSeconds * NSEC_PER_SEC)
        if let error { throw error }
        return albums
    }
}
