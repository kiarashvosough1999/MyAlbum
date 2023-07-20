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

    typealias StoreRef = Store<SectionizedAlbumListReducer.State, SectionizedAlbumListReducer.Action>

    private let store: StoreRef

    init(store: StoreRef) {
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
                StoreScrollableLazyVStack(store: store) { childState in
                    AlbumItemView(store: childState)
                        .equatable()
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

//struct SectionizedAlbumList_Previews: PreviewProvider {
//    static var previews: some View {
//        SectionizedAlbumList(albums: [])
//    }
//}
