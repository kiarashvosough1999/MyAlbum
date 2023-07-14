//
//  AllAlbumListView.swift
//  MyAlbum
//
//  Created by Kiarash Vosough on 7/13/23.
//

import SwiftUI
import ComposableArchitecture

// MARK: - ViewModel

struct AllAlbumListViewModel: Identifiable {
    let id: Int
    let item: AlbumItemViewModel
}

extension AllAlbumListViewModel: Hashable {}

// MARK: - View

struct AllAlbumListView: View {

    private let albums: [AllAlbumListViewModel]
    
    init(albums: [AllAlbumListViewModel]) {
        self.albums = albums
    }
    
    var body: some View {
        ScrollableLazyVStack(dataSource: albums) { album in
            let state = Path.State.showPhotos(
                photos: PhotosListReducer.State.init(albumId: album.id)
            )
            NavigationLink(state: state) {
                AlbumItemView(model: album.item)
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
        lhs.albums == rhs.albums
    }
}

struct AllAlbumListView_Preview: PreviewProvider {
    static var previews: some View {
        AllAlbumListView(albums: [])
    }
}
