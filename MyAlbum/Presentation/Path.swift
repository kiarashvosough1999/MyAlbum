//
//  Path.swift
//  MyAlbum
//
//  Created by Kiarash Vosough on 7/13/23.
//

import ComposableArchitecture

struct Path: ReducerProtocol {
    enum State {
        case showPhotos(AlbumListReducer.State)
    }
    enum Action {
        case showPhotos(AlbumListReducer.Action)
    }
    var body: some ReducerProtocolOf<Self> {
        Scope(state: /State.showPhotos, action: /Action.showPhotos) {
            AlbumListReducer()
        }
    }
}
