//
//  AlbumListReducerTests.swift
//  MyAlbumTests
//
//  Created by Kiarash Vosough on 7/14/23.
//

import Dependencies
import ComposableArchitecture
import XCTest
@testable import MyAlbum

typealias TestStoreOf<R: ReducerProtocol> = TestStore<R.State, R.Action, R.State, R.Action, ()>

final class AlbumListReducerTests: XCTestCase, JSONLoader {

    private var store: TestStoreOf<AlbumListReducer>!

    override func setUpWithError() throws {
        store = TestStore(initialState: AlbumListReducer.State()) {
            AlbumListReducer()
        }
        store.exhaustivity = .off
    }

    override func tearDownWithError() throws {
        store = nil
    }
    
    @MainActor
    func testOnAppear() async throws {
        let albums = try loadAlbums()
        let userIds = Array(Set(albums.map(\.userId))).sorted()
        let photo = try loadPhotos().first!
        let url = photo.thumbnailUrl

        let albumEntityToAlbumWithImageEntityMapper = AlbumEntityToAlbumWithImageEntityMapper()
        let context = AlbumEntityToAlbumWithImageEntityMapper.Context(thumbnailUrl: url)
        let albumsWithImage = albums.map { albumEntityToAlbumWithImageEntityMapper.map($0, context: context) }
        
        let albumWithImageEntityToAllAlbumListViewModelMapper = AlbumWithImageEntityToAllAlbumListViewModelMapper()
        let viewmodel = albumsWithImage.map { albumWithImageEntityToAllAlbumListViewModelMapper.map($0) }
        
        await store.withDependencies { values in
            values.fetchAlbumUseCase = FetchAlbumUseCaseStub(albums: albumsWithImage)
            values.fetchPhotoUseCase = FetchPhotoUseCaseStub(photo: photo)
        } operation: {
            await store.send(.onAppear)
            await store.finish(timeout: 10*NSEC_PER_SEC)
            await store.receive(/AlbumListReducer.Action.albumLoaded(albums:))
            XCTAssertEqual(store.state.unGroupedAlbums, viewmodel)
            XCTAssertEqual(store.state.userIds, userIds)
        }
    }

    @MainActor
    func testFilterByUserId() async throws {
        let albums = try loadAlbums()
        let photo = try loadPhotos().first!
        let url = photo.thumbnailUrl
        let userId = Array(Set(albums.map(\.userId))).first!

        let mapper = AlbumEntityToAlbumWithImageEntityMapper()
        let context = AlbumEntityToAlbumWithImageEntityMapper.Context(thumbnailUrl: url)
        let albumsWithImage = albums.map { mapper.map($0, context: context) }
        let filteredAlbumsWithImage = albumsWithImage.filter { $0.userId == userId }
        
        let albumWithImageEntityToAllAlbumListViewModelMapper = AlbumWithImageEntityToAllAlbumListViewModelMapper()
        let viewmodel = filteredAlbumsWithImage.map { albumWithImageEntityToAllAlbumListViewModelMapper.map($0) }

        await store.withDependencies { values in
            values.fetchAlbumUseCase = FetchAlbumUseCaseStub(albums: albumsWithImage)
            values.fetchPhotoUseCase = FetchPhotoUseCaseStub(photo: photo)
        } operation: {
            await store.send(.onAppear)
            await store.send(.set(\.$filteredUserId, userId))
            await store.finish(timeout: 10*NSEC_PER_SEC)
            XCTAssertEqual(store.state.unGroupedAlbums, viewmodel)
        }
    }

    @MainActor
    func testSectionByUsersTrue() async throws {
        let sectionByUsers = true

        await store.send(.sectionByUsersChanged)
        await store.finish(timeout: 10*NSEC_PER_SEC)

        XCTAssertEqual(store.state.sectionByUsers, sectionByUsers)
    }
    
    @MainActor
    func testSectionByUsersFalse() async throws {
        let sectionByUsers = false

        await store.finish(timeout: 10*NSEC_PER_SEC)

        XCTAssertEqual(store.state.sectionByUsers, sectionByUsers)
    }
}
