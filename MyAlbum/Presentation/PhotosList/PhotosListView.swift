//
//  PhotosListView.swift
//  MyAlbum
//
//  Created by Kiarash Vosough on 7/14/23.
//

import SwiftUI
import ComposableArchitecture

struct PhotosListView: View {

    private let store: StoreOf<PhotosListReducer>

    init(store: StoreOf<PhotosListReducer>) {
        self.store = store
    }

    var body: some View {
        WithViewStore(store) { viewStore in
            photoList(viewStore: viewStore)
                .onFirstAppear {
                    viewStore.send(.onAppear)
                }
                .navigationTitle("Photos")
        }
    }
    
    @ViewBuilder
    @MainActor
    private func photoList(viewStore: ViewStoreOf<PhotosListReducer>) -> some View {
        let store = store.scope(state: \.showingPhotos, action: PhotosListReducer.Action.photo(id:action:))
        StoreScrollableLazyVStack(store: store) { childStore in
            PhotoItemView(store: childStore)
        }
    }
}

#if DEBUG
struct PhotosGridView_Previews: PreviewProvider {
    static var previews: some View {
        PhotosListView(
            store: .init(
                initialState: PhotosListReducer.State(albumId: 4),
                reducer: PhotosListReducer()
            )
        )
    }
}
#endif
