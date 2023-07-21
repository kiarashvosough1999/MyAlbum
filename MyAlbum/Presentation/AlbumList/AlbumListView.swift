//
//  AlbumListView.swift
//  MyAlbum
//
//  Created by Kiarash Vosough on 7/13/23.
//

import SwiftUI
import ComposableArchitecture

struct AlbumListView: View {

    private let store: StoreOf<AlbumListReducer>
    
    init(store: StoreOf<AlbumListReducer>) {
        self.store = store
    }

    var body: some View {
        WithViewStore(store) { viewStore in
            Group {
                if viewStore.sectionByUsers == false {
                    buildUnSectionedView(viewStore: viewStore)
                } else {
                    buildSectionzedView(viewStore: viewStore)

                }
            }
            .navigationTitle("Albums")
            .toolbar {
                buildToolbar(viewStore: viewStore)
            }
            .onFirstAppear {
                viewStore.send(.onAppear)
            }
        }
    }

    @ViewBuilder
    private func buildUnSectionedView(viewStore: ViewStoreOf<AlbumListReducer>) -> some View {
        let store = store.scope(
            state: \.albumsStates,
            action: AlbumListReducer.Action.album(id:action:)
        )
        AllAlbumListView(store: store)
            .equatable()
    }

    @ViewBuilder
    private func buildSectionzedView(viewStore: ViewStoreOf<AlbumListReducer>) -> some View {
        let store = store.scope(
            state: \.sectionziedAlbumsStates,
            action: AlbumListReducer.Action.section(id:action:)
        )
        StoreScrollableLazyVStack(store: store) { childStore in
            SectionizedAlbumListView(store: childStore)
                .equatable()
        }
    }

    @ToolbarContentBuilder
    private func buildToolbar(viewStore: ViewStoreOf<AlbumListReducer>) -> some ToolbarContent {
        ToolbarItem(placement: .navigationBarTrailing) {
            Menu {
                Button(viewStore.sectionByUsers ? "No Section" : "Section By Users") {
                    viewStore.send(.sectionByUsersChanged)
                }
                Button("No User Id Filter") {
                    viewStore.send(.set(\.$filteredUserId, nil))
                }
                Menu("User IDs") {
                    ForEach(viewStore.userIds, id: \.self) { id in
                        Button("Filter By User Id \(id)") {
                            viewStore.send(.set(\.$filteredUserId, id))
                        }
                    }
                }
            } label: {
                Label("user", systemImage: "line.3.horizontal.decrease.circle")
            }
        }
    }
}

#if DEBUG
struct AlbumListView_Previews: PreviewProvider {
    static var previews: some View {
        AlbumListView(store: .init(initialState: AlbumListReducer.State(), reducer: AlbumListReducer()))
    }
}
#endif
