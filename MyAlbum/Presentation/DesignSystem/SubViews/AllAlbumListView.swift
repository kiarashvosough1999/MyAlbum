//
//  AllAlbumListView.swift
//  MyAlbum
//
//  Created by Kiarash Vosough on 7/13/23.
//

import SwiftUI
import ComposableArchitecture

// MARK: - View

struct AllAlbumListView: View {

    typealias StoreRef = Store<IdentifiedArray<Int, AlbumItemReducer.State>, (Int, AlbumItemReducer.Action)>
    
    private let store: StoreRef
    
    init(store: StoreRef) {
        self.store = store
    }

    var body: some View {
        StoreScrollableLazyVStack(store: store) { childStore in
            let state = Path.State.showPhotos(
                photos: PhotosListReducer.State(albumId: childStore.withState(\.albumId))
            )
            NavigationLink(state: state) {
                AlbumItemView(store: childStore)
                    .equatable()
                    .roundedView()
                    .padding(.horizontal, 16)
            }
        }
    }
}

// MARK: - Equatable

extension AllAlbumListView: Equatable {
    static func == (lhs: AllAlbumListView, rhs: AllAlbumListView) -> Bool {
        lhs.store.withState(\.id) == rhs.store.withState(\.id)
    }
}
