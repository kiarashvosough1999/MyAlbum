//
//  AlbumListReducer.swift
//  MyAlbum
//
//  Created by Kiarash Vosough on 7/13/23.
//

import ComposableArchitecture
import Dependencies
import Foundation

struct AlbumListReducer: ReducerProtocol {

    struct State: Equatable {
        @BindingState fileprivate var albums: [AlbumEntity] = []
        @BindingState var filteredUserId: Int?
        var sectionByUsers: Bool = false

        // child states
        var albumsStates: IdentifiedArrayOf<AlbumItemReducer.State> = .init()
        var sectionziedAlbumsStates: IdentifiedArrayOf<SectionizedAlbumListReducer.State> = .init()

        // MARK: - DataSources

        private var filteredAlbums: [AlbumEntity] {
            guard let filteredUserId else { return albums }
            return albums
                .lazy
                .filter { $0.userId == filteredUserId }
                .sorted { $0.userId < $1.userId }
        }
        
        /// Data Source used for ungrouped albums
        fileprivate var unGroupedAlbums: [AlbumEntity] {
            return filteredAlbums
        }
        
        /// Data Source used for grouped albums based on userId
        fileprivate var groupedAlbumsByUserId: [UserGroupedAlbumEntity] {
            Dictionary(grouping: filteredAlbums, by: \.userId)
                .lazy
                .sorted(by: { $0.key < $1.key })
                .map { (key, value) in
                    UserGroupedAlbumEntity(userId: key, albums: value)
                }
        }

        /// Data Source used for filtering based on userId
        var userIds: [Int] {
            Array(Set(albums.map(\.userId))).sorted()
        }
    }

    enum Action: BindableAction {
        case binding(BindingAction<State>)
        case onAppear
        case albumLoaded(albums: [AlbumEntity])
        case sectionByUsersChanged
        case album(id: AlbumItemReducer.State.ID, action: AlbumItemReducer.Action)
        case section(id: SectionizedAlbumListReducer.State.ID, action: SectionizedAlbumListReducer.Action)
    }

    // MARK: - Dependencies

    @Dependency(\.fetchAlbumUseCase) private var fetchAlbumUseCase
    
    // MARK: - Mappers

    private var albumStateMapper: AlbumEntitiesToAlbumItemReducerStatesMapper {
        AlbumEntitiesToAlbumItemReducerStatesMapper()
    }

    private var sectionedAlbumStateMapper: AlbumEntitiesToSectionizedAlbumListReducerStatesMapper {
        AlbumEntitiesToSectionizedAlbumListReducerStatesMapper()
    }

    // MARK: - Reducer

    var body: some ReducerProtocolOf<Self> {
        Reduce { state, action in
            switch action {
            case .onAppear:
                return .run { send in
                    let albums = try await fetchAlbumUseCase.fetchAlbums()
                    await send(.albumLoaded(albums: albums))
                }
            case .albumLoaded(let albums):
                state.albums = albums
                state.albumsStates = albumStateMapper.map(state.unGroupedAlbums)
            case .sectionByUsersChanged:
                state.sectionByUsers.toggle()

                /*
                 
                 - For better performance we should empty these states as one of them won't be needed and the other will be updated in next lines.
                 
                 - But due to the problem of TCA which send action and there is no state for them in the stateArray which is empty, it create warning in debugger, no crash happen.
                 
                 state.sectionziedAlbumsStates = .init()
                 state.albumsStates = .init()
                 */

                if state.sectionByUsers {
                    let context = AlbumEntitiesToSectionizedAlbumListReducerStatesMapper.Context(
                        childMapper: albumStateMapper
                    )
                    state.sectionziedAlbumsStates = sectionedAlbumStateMapper.map(
                        state.groupedAlbumsByUserId,
                        context: context
                    )
                } else {
                    state.albumsStates = albumStateMapper.map(state.unGroupedAlbums)
                }
            default:
                break
            }
            return .none
        }
        .forEach(\.albumsStates, action: /Action.album) {
            AlbumItemReducer()
        }
        .forEach(\.sectionziedAlbumsStates, action: /Action.section) {
            SectionizedAlbumListReducer()
        }
        BindingReducer()
    }
}
