//
//  AlbumListReducer.swift
//  MyAlbum
//
//  Created by Kiarash Vosough on 7/13/23.
//

import ComposableArchitecture
import Dependencies

struct AlbumListReducer: ReducerProtocol {

    struct State: Equatable {
        @BindingState fileprivate var albums: [AlbumWithImageEntity] = []
        @BindingState var filteredUserId: Int?
        var sectionByUsers: Bool = false

        var filteredAlbums: [AlbumWithImageEntity] {
            guard let filteredUserId else { return albums }
            return albums
                .lazy
                .filter { $0.userId == filteredUserId }
                .sorted { $0.userId < $1.userId }
        }
        
        var albumsGroupedByUserId: [[AlbumWithImageEntity]] {
            return Dictionary(grouping: filteredAlbums, by: \.userId)
                .lazy
                .sorted(by: { $0.key < $1.key })
                .map { $0.value }
        }

        var userIds: [Int] {
            Array(Set(albums.map(\.userId))).sorted()
        }
    }

    enum Action: BindableAction {
        case binding(BindingAction<State>)
        case onAppear
        case albumLoaded([AlbumWithImageEntity])
        case sectionByUsersChanged
    }

    @Dependency(\.fetchAlbumUseCase) private var fetchAlbumUseCase
    
    var body: some ReducerProtocolOf<Self> {
        Reduce { state, action in
            switch action {
            case .onAppear:
                return .run { send in
                    let albums = try await fetchAlbumUseCase.fetchAlbums()
                    await send(.albumLoaded(albums))
                }
            case .albumLoaded(let albums):
                state.albums = albums
            case .sectionByUsersChanged:
                state.sectionByUsers.toggle()
            default:
                break
            }
            return .none
        }
        BindingReducer()
    }
}
