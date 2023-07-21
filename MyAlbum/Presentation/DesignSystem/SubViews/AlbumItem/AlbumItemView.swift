//
//  AlbumItemView.swift
//  MyAlbum
//
//  Created by Kiarash Vosough on 7/14/23.
//

import SwiftUI
import ComposableArchitecture

// MARK: - View

struct AlbumItemView: View {

    private let store: StoreOf<AlbumItemReducer>

    init(store: StoreOf<AlbumItemReducer>) {
        self.store = store
    }

    var body: some View {
        WithViewStore(store) { viewStore in
            HStack(spacing: 16) {
                if let url = viewStore.thumbnailUrl {
                    AsyncLoadingImage(url: url, width: 50, height: 50, padding: 0)
                        .transition(.slide)
                }
                Text(viewStore.title)
                    .fillText()
            }
            .animation(.easeInOut, value: viewStore.thumbnailUrl)
            .onAppear {
                viewStore.send(.onAppeared)
            }
            .onDisappear {
                viewStore.send(.onDisAppeared)
            }
        }
    }
}

// MARK: - Equatable

extension AlbumItemView: Equatable {

    static func == (lhs: AlbumItemView, rhs: AlbumItemView) -> Bool {
        lhs.store.withState(\.id) == rhs.store.withState(\.id)
    }
}

#if DEBUG
struct AlbumItemView_Previews: PreviewProvider {
    static var previews: some View {
        AlbumItemView(
            store: StoreOf<AlbumItemReducer>(
                initialState: AlbumItemReducer.State(albumId: 1, title: "Some Title"),
                reducer: AlbumItemReducer()
            )
        )
    }
}
#endif
