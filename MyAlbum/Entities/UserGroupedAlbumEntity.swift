//
//  UserGroupedAlbumEntity.swift
//  MyAlbum
//
//  Created by Kiarash Vosough on 7/14/23.
//

import Foundation

struct UserGroupedAlbumEntity {
    let userId: Int
    let albums: [AlbumEntity]
}

extension UserGroupedAlbumEntity: Hashable {}
extension UserGroupedAlbumEntity: Identifiable {
    var id: Int { userId }
}
