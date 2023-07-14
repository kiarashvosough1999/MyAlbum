//
//  RootView.swift
//  MyAlbum
//
//  Created by Kiarash Vosough on 7/13/23.
//

import SwiftUI
import ComposableArchitecture

/// Serve as a entry point and constrcut Navigation System
struct RootView: View {

    private let store: StoreOf<RootReducer>

    init(store: StoreOf<RootReducer>) {
        self.store = store
    }

    var body: some View {
        NavigationStackStore(store.scope(state: \.path, action: RootReducer.Action.path(path:))) {
            AlbumListView(store: store.scope(state: \.albumList, action: RootReducer.Action.albumList(action:)))
        } destination: { (state: Path.State) in
            switch state {
            case .showPhotos:
                CaseLet(
                    /Path.State.showPhotos(photos:), action: Path.Action.showPhotos(photos:)
                ) { loggedInStore in
                    PhotosListView(store: loggedInStore)
                }
            }
        }
    }
}
