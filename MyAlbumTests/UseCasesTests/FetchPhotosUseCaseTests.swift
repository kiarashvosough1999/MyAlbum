//
//  FetchPhotosUseCaseTests.swift
//  MyAlbumTests
//
//  Created by Kiarash Vosough on 7/13/23.
//

import XCTest
import Dependencies
@testable import MyAlbum

final class FetchPhotosUseCaseTests: XCTestCase, JSONLoader {

    private var sut: FetchPhotoUseCaseProtocol!
    
    override func setUpWithError() throws {
        sut = FetchPhotoUseCase()
    }

    override func tearDownWithError() throws {
        sut = nil
    }

    func testFetchingPhotosSuccessful() async throws {
        let albumId = 2
        let photos = try loadPhotos().filter { $0.albumId == albumId }
        let photosRepository = PhotosRepositoryStub(photos: photos)
        
        let fetchedPhotos = try await withDependencies { values in
            values.photosRepository = photosRepository
        } operation: {
            try await sut.fetchPhotos(albumId: albumId)
        }

        XCTAssertNotNil(photosRepository.albumId)
        XCTAssertEqual(photosRepository.albumId, albumId)
        XCTAssertEqual(photos, fetchedPhotos)
    }

    func testFetchingPhotosUnSuccessful() async throws {
        let albumId = 1
        let photosRepository = PhotosRepositoryStub(error: ErrorStub.someError)
        
        try await withDependencies { values in
            values.photosRepository = photosRepository
        } operation: {
            await XCTAssertThrowsError(try await sut.fetchPhotos(albumId: albumId))
        }
        XCTAssertNotNil(photosRepository.albumId)
        XCTAssertEqual(photosRepository.albumId, albumId)
    }
    
    func testFetchingPhotoSuccessful() async throws {
        let albumId = 1
        let photoId = 1
        let photo = try loadPhotos().first!
        let photosRepository = PhotosRepositoryStub(photo: photo)

        let fetchedPhoto = try await withDependencies { values in
            values.photosRepository = photosRepository
        } operation: {
            try await sut.fetchRandomPhoto(albumId: albumId)
        }

        XCTAssertNotNil(photosRepository.albumId)
        XCTAssertNotNil(photosRepository.photoId)
        XCTAssertEqual(photosRepository.albumId, albumId)
        XCTAssertEqual(photo, fetchedPhoto)
    }

    func testFetchingPhotoUnSuccessful() async throws {
        let albumId = 1
        let photoId = 1
        let photosRepository = PhotosRepositoryStub(error: ErrorStub.someError)

        try await withDependencies { values in
            values.photosRepository = photosRepository
        } operation: {
            await XCTAssertThrowsError(try await sut.fetchRandomPhoto(albumId: albumId))
        }
        XCTAssertNotNil(photosRepository.albumId)
        XCTAssertNotNil(photosRepository.photoId)
        XCTAssertEqual(photosRepository.albumId, albumId)
    }
}
