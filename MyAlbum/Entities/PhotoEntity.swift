//
//  PhotoEntity.swift
//  MyAlbum
//
//  Created by Kiarash Vosough on 7/13/23.
//

import Foundation

struct PhotoEntity: Identifiable {
    let id: Int
    let albumId: Int
    let title: String
    let url: String
    let thumbnailUrl: URL
}

extension PhotoEntity: Hashable {}
extension PhotoEntity: Decodable {}
