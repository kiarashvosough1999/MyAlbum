//
//  AllAlbumListView.swift
//  MyAlbum
//
//  Created by Kiarash Vosough on 7/13/23.
//

import SwiftUI

struct AllAlbumListView: View {

    private let albums: [AlbumWithImageEntity]
    
    init(albums: [AlbumWithImageEntity]) {
        self.albums = albums
    }
    
    var body: some View {
        ScrollView {
            LazyVStack {
                ForEach(albums) { album in
                    AlbumItemView(model: album)
                        .equatable()
                }
            }
        }
    }
}

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
