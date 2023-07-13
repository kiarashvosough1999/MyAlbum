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
        @BindingState fileprivate var albums: [AlbumEntity] = [
            AlbumEntity(id: 1, userId: 1, title: "hi"),
            AlbumEntity(id: 2, userId: 1, title: "hi"),
            AlbumEntity(id: 3, userId: 1, title: "hi"),
            AlbumEntity(id: 4, userId: 13, title: "hi"),
        ]
        @BindingState var filteredUserId: String = ""
        var sectionByUsers: Bool = false
    
        var albumsToShow: [AlbumEntity] {
            guard filteredUserId.isEmpty == false, let userId = Int(filteredUserId) else { return albums }
            return albums
                .filter { $0.userId == userId }
                .sorted { $0.userId < $1.userId }
        }
        
        var albumsGroupedByUserId: [[AlbumEntity]] {
            return Dictionary(grouping: albumsToShow, by: \.userId)
                .sorted(by: { $0.key < $1.key })
                .map { $0.value }
        }
    }

    enum Action: BindableAction {
        case binding(BindingAction<State>)
        case onAppear
        case albumLoaded([AlbumEntity])
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
