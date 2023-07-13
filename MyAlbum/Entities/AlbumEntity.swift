//
//  AlbumEntity.swift
//  MyAlbum
//
//  Created by Kiarash Vosough on 7/13/23.
//

struct AlbumEntity: Identifiable {
    let id: Int
    let userID: Int
    let title: String
}

extension AlbumEntity: Hashable {}
extension AlbumEntity: Decodable {}
