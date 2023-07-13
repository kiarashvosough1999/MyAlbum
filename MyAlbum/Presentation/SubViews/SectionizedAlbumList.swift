//
//  SectionizedAlbumList.swift
//  MyAlbum
//
//  Created by Kiarash Vosough on 7/13/23.
//

import SwiftUI

struct SectionizedAlbumList: View {

    private let albums: [[AlbumEntity]]
    
    init(albums: [[AlbumEntity]]) {
        self.albums = albums
    }
    
    var body: some View {
        List {
            ForEach(albums, id: \.self) { albumByUserId in
                if let userId = albumByUserId.first?.userId {
                    Section("User Id: \(userId)") {
                        ForEach(albumByUserId) { album in
                            Text(album.title)
                        }
                    }
                }
            }
        }
    }
}

struct SectionizedAlbumList_Previews: PreviewProvider {
    static var previews: some View {
        SectionizedAlbumList(albums: [])
    }
}
