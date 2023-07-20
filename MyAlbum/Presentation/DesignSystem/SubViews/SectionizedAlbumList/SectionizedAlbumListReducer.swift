//
//  SectionizedAlbumListReducer.swift
//  MyAlbum
//
//  Created by Kiarash Vosough on 7/20/23.
//

import ComposableArchitecture
import Dependencies

struct SectionizedAlbumListReducer: ReducerProtocol {

    struct State: Equatable, Identifiable {
        var id: Int {
            userId
        }
        let userId: Int
        var albumsStates: IdentifiedArrayOf<AlbumItemReducer.State>
    }

    enum Action {
        case album(id: AlbumItemReducer.State.ID, action: AlbumItemReducer.Action)
    }
    
    var body: some ReducerProtocolOf<Self> {
        Reduce { state, action in
            return .none
        }
        .forEach(\.albumsStates, action: /Action.album) {
            AlbumItemReducer()
        }
    }
}
