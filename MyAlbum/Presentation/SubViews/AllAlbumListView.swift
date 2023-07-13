//
//  AllAlbumListView.swift
//  MyAlbum
//
//  Created by Kiarash Vosough on 7/13/23.
//

import SwiftUI

struct AllAlbumListView: View {

    private let albums: [AlbumEntity]
    
    init(albums: [AlbumEntity]) {
        self.albums = albums
    }
    
    var body: some View {
        List {
            ForEach(albums) { album in
                Text(album.title)
            }
        }
    }
}

struct AllAlbumListView_Preview: PreviewProvider {
    static var previews: some View {
        AllAlbumListView(albums: [])
    }
}
