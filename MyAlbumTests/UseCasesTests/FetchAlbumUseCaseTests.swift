//
//  FetchAlbumUseCaseTests.swift
//  MyAlbumTests
//
//  Created by Kiarash Vosough on 7/13/23.
//

import XCTest
import Dependencies
@testable import MyAlbum

final class FetchAlbumUseCaseTests: XCTestCase, JSONLoader {

    private var sut: FetchAlbumUseCaseProtocol!
    
    override func setUpWithError() throws {
        sut = FetchAlbumUseCase()
    }

    override func tearDownWithError() throws {
        sut = nil
    }

    func testFetchingAlbumsSuccessful() async throws {
        let albums = try loadAlbums()
        
        let fetchedAlbums = try await withDependencies { values in
            values.albumRepository = AlbumRepositoryStub(albums: albums)
        } operation: {
            try await sut.fetchAlbums()
        }

        XCTAssertEqual(albums, fetchedAlbums)
    }

    func testFetchingAlbumsUnSuccessful() async throws {
        let albums = try loadAlbums()
        
        try await withDependencies { values in
            values.albumRepository = AlbumRepositoryStub(albums: albums)
        } operation: {
            await XCTAssertThrowsError(try await sut.fetchAlbums())
        }
    }
}
