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

    private var sut: TestStoreOf<AlbumListReducer>!

    override func setUpWithError() throws {
        sut = TestStore(initialState: AlbumListReducer.State()) {
            AlbumListReducer()
        }
        sut.exhaustivity = .off
    }

    override func tearDownWithError() throws {
        sut = nil
    }
    
    @MainActor
    func testOnAppear() async throws {
        let albums = try loadAlbums()
        let userIds = Array(Set(albums.map(\.userId))).sorted()
        let albumStatesMapper = AlbumEntitiesToAlbumItemReducerStatesMapper()
        
        await sut.withDependencies { values in
            values.fetchAlbumUseCase = FetchAlbumUseCaseStub(albums: albums)
        } operation: {
            await sut.send(.onAppear)
            await sut.finish(timeout: 10*NSEC_PER_SEC)
            await sut.receive(/AlbumListReducer.Action.albumLoaded(albums:))
            XCTAssertEqual(sut.state.albumsStates, albumStatesMapper.map(albums))
            XCTAssertEqual(sut.state.userIds, userIds)
        }
    }

    @MainActor
    func testFilterByUserId() async throws {
        let albums = try loadAlbums()
        let photo = try loadPhotos().first!
        let url = photo.thumbnailUrl
        let userId = Array(Set(albums.map(\.userId))).first!

        let albumStatesMapper = AlbumEntitiesToAlbumItemReducerStatesMapper()
        let filteredAlbums = albums.filter { $0.userId == userId }

        await sut.withDependencies { values in
            values.fetchAlbumUseCase = FetchAlbumUseCaseStub(albums: filteredAlbums)
        } operation: {
            await sut.send(.onAppear)
            await sut.send(.set(\.$filteredUserId, userId))
            await sut.finish(timeout: 10*NSEC_PER_SEC)
            XCTAssertEqual(sut.state.albumsStates, albumStatesMapper.map(filteredAlbums))
        }
    }

    @MainActor
    func testSectionByUsersTrue() async throws {
        let sectionByUsers = true

        await sut.send(.sectionByUsersChanged)
        await sut.finish(timeout: 10*NSEC_PER_SEC)

        XCTAssertEqual(sut.state.sectionByUsers, sectionByUsers)
    }
    
    @MainActor
    func testSectionByUsersFalse() async throws {
        let sectionByUsers = false

        await sut.finish(timeout: 10*NSEC_PER_SEC)

        XCTAssertEqual(sut.state.sectionByUsers, sectionByUsers)
    }
}
