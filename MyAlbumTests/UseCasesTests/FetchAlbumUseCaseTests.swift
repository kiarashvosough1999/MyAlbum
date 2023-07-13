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
        let photo = try loadPhotos().first!
        let albums = try loadAlbums()
        
        let fetchedAlbums = try await withDependencies { values in
            values.fetchPhotoUseCase = FetchPhotoUseCaseStub(photo: photo)
            values.albumRepository = AlbumRepositoryStub(albums: albums)
        } operation: {
            try await sut.fetchAlbums()
        }

        XCTAssertEqual(albums.map(\.id).sorted(), fetchedAlbums.map(\.id).sorted())
        XCTAssertEqual(albums.map(\.userId).sorted(), fetchedAlbums.map(\.userId).sorted())
        XCTAssertEqual(albums.map(\.title).sorted(), fetchedAlbums.map(\.title).sorted())
        XCTAssertEqual(Array(repeating: photo.thumbnailUrl, count: fetchedAlbums.count), fetchedAlbums.map(\.thumbnailUrl))
    }

    func testFetchingAlbumsUnSuccessful() async throws {
        try await withDependencies { values in
            values.albumRepository = AlbumRepositoryStub(error: ErrorStub.someError)
        } operation: {
            await XCTAssertThrowsError(try await sut.fetchAlbums())
        }
    }
}
