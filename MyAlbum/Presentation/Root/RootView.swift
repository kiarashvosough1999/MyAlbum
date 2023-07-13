//
//  RootView.swift
//  MyAlbum
//
//  Created by Kiarash Vosough on 7/13/23.
//

import SwiftUI
import ComposableArchitecture

struct RootView: View {

    private let store: StoreOf<RootReducer>

    init(store: StoreOf<RootReducer>) {
        self.store = store
    }

    var body: some View {
        NavigationStackStore(store.scope(state: \.path, action: { .path($0) })) {
            AlbumListView(store: store.scope(state: \.albumList, action: RootReducer.Action.albumList(action:)))
        } destination: { state in
//            switch state {
//            case .showPhotos:
//                CaseLet(
//                  state: /RootReducer.Path.State.showPhotos,
//                  action: RootReducer.Path.Action.showPhotos,
//                  then: PhotosView.init(store:)
//                )
//            }
        }
    }
}
