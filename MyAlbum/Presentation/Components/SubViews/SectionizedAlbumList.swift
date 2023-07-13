//
//  SectionizedAlbumList.swift
//  MyAlbum
//
//  Created by Kiarash Vosough on 7/13/23.
//

import SwiftUI

struct SectionizedAlbumList: View {

    private let albums: [[AlbumWithImageEntity]]
    
    init(albums: [[AlbumWithImageEntity]]) {
        self.albums = albums
    }
    
    var body: some View {
        List {
            ForEach(albums, id: \.self) { albumByUserId in
                if let userId = albumByUserId.first?.userId {
                    Section("User Id: \(userId)") {
                        ForEach(albumByUserId) { album in
                            AlbumItemView(model: album)
                                .equatable()
                        }
                    }
                }
            }
        }
    }
}

extension SectionizedAlbumList: Equatable {
    static func == (lhs: SectionizedAlbumList, rhs: SectionizedAlbumList) -> Bool {
        lhs.albums == rhs.albums
    }
}

struct SectionizedAlbumList_Previews: PreviewProvider {
    static var previews: some View {
        SectionizedAlbumList(albums: [])
    }
}
