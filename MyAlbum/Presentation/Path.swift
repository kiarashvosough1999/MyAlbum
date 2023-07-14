//
//  Path.swift
//  MyAlbum
//
//  Created by Kiarash Vosough on 7/13/23.
//

import ComposableArchitecture

/// This Reducer Act as a Router in Navigation System
struct Path: ReducerProtocol {
    enum State {
        case showPhotos(photos: PhotosListReducer.State)
    }
    enum Action {
        case showPhotos(photos: PhotosListReducer.Action)
    }
    var body: some ReducerProtocolOf<Self> {
        Scope(state: /State.showPhotos, action: /Action.showPhotos) {
            PhotosListReducer()
        }
    }
}
