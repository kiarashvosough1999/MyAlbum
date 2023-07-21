//
//  AlbumWithImageEntity.swift
//  MyAlbum
//
//  Created by Kiarash Vosough on 7/14/23.
//

import Foundation

struct AlbumWithImageEntity: Identifiable {
    let id: Int
    let userId: Int
    let title: String
    let thumbnailUrl: URL
}

extension AlbumWithImageEntity: Hashable {}
