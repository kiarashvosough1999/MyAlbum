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
                    AllAlbumListView(albums: viewStore.albumsToShow)
                        .equatable()
                } else {
                    SectionizedAlbumList(albums: viewStore.albumsGroupedByUserId)
                        .equatable()
                }
            }
            .navigationTitle("Albums")
            .searchable(text: viewStore.$filteredUserId, prompt: "Enter User ID")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Menu {
                        Button(viewStore.sectionByUsers ? "No Section" : "Section By Users") {
                            viewStore.send(.sectionByUsersChanged)
                        }
                    } label: {
                        Label("user", systemImage: "line.3.horizontal.decrease.circle")
                    }
                }
            }
            .onFirstAppear {
                viewStore.send(.onAppear)
            }
        }
    }
}

struct AlbumListView_Previews: PreviewProvider {
    static var previews: some View {
        AlbumListView(store: .init(initialState: AlbumListReducer.State(), reducer: AlbumListReducer()))
    }
}
