//
//  SectionizedAlbumList.swift
//  MyAlbum
//
//  Created by Kiarash Vosough on 7/13/23.
//

import SwiftUI

// MARK: - ViewModel

struct SectionizedAlbumListViewModel {
    let userId: Int
    let item: AlbumItemViewModel
}

extension SectionizedAlbumListViewModel: Hashable {}
extension SectionizedAlbumListViewModel: Identifiable {
    var id: Int { hashValue }
}

// MARK: - View

struct SectionizedAlbumList: View {

    private let albums: [[SectionizedAlbumListViewModel]]
    
    init(albums: [[SectionizedAlbumListViewModel]]) {
        self.albums = albums
    }
    
    var body: some View {
        List {
            ForEach(albums, id: \.self) { albumByUserId in
                if let userId = albumByUserId.first?.userId {
                    Section("User Id: \(userId)") {
                        ForEach(albumByUserId) { album in
                            AlbumItemView(model: album.item)
                                .equatable()
                        }
                    }
                }
            }
        }
    }
}

// MARK: - Equatable

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
