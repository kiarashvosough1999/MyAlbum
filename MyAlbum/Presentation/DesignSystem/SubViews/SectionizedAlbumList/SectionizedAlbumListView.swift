//
//  SectionizedAlbumListView.swift
//  MyAlbum
//
//  Created by Kiarash Vosough on 7/13/23.
//

import SwiftUI
import ComposableArchitecture

// MARK: - View

struct SectionizedAlbumListView: View {

    private let store: StoreOf<SectionizedAlbumListReducer>

    init(store: StoreOf<SectionizedAlbumListReducer>) {
        self.store = store
    }

    var body: some View {
        WithViewStore(store) { viewStore in
            let store = store.scope(
                state: \.albumsStates,
                action: SectionizedAlbumListReducer.Action.album(id:action:)
            )

            VStack {
                Text("User Id: \(viewStore.userId)")
                    .fillText()
                StoreScrollableLazyVStack(store: store) { childStore in
                    let state = Path.State.showPhotos(
                        photos: PhotosListReducer.State(albumId: childStore.withState(\.albumId))
                    )
                    NavigationLink(state: state) {
                        AlbumItemView(store: childStore)
                            .equatable()
                    }
                }
            }
            .roundedView()
            .padding()
        }
    }
}

// MARK: - Equatable

extension SectionizedAlbumListView: Equatable {
    static func == (lhs: SectionizedAlbumListView, rhs: SectionizedAlbumListView) -> Bool {
        lhs.store.withState(\.id) == rhs.store.withState(\.id)
    }
}

#if DEBUG
struct SectionizedAlbumList_Previews: PreviewProvider {
    static var previews: some View {
        SectionizedAlbumListView(
            store: StoreOf<SectionizedAlbumListReducer>(
                initialState: SectionizedAlbumListReducer.State(
                    userId: 1,
                    albumsStates: IdentifiedArrayOf<AlbumItemReducer.State>()),
                reducer: SectionizedAlbumListReducer()
            )
        )
    }
}
#endif
