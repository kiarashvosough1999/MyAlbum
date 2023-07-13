//
//  RootReducer.swift
//  MyAlbum
//
//  Created by Kiarash Vosough on 7/13/23.
//

import ComposableArchitecture

struct RootReducer: ReducerProtocol {
    
    struct State {
        var path = StackState<Path.State>()
        var albumList: AlbumListReducer.State = .init()
    }
    
    enum Action {
        case path(StackAction<Path.State, Path.Action>)
        case albumList(action: AlbumListReducer.Action)
    }
    
    var body: some ReducerProtocolOf<Self> {
        Reduce { state, action in
            return .none
        }
        .forEach(\.path, action: /Action.path) {
            Path()
        }
        Scope(state: \.albumList, action: /Action.albumList) {
            AlbumListReducer()
        }
    }
}
