//
//  AlbumEntityToAlbumWithImageEntityMapper.swift
//  MyAlbum
//
//  Created by Kiarash Vosough on 7/14/23.
//

import Foundation

struct AlbumEntityToAlbumWithImageEntityMapper: MapperProtocol {
    
    typealias From = AlbumEntity
    typealias To = AlbumWithImageEntity

    struct Context {
        let thumbnailUrl: URL
    }
    
    func map(_ result: AlbumEntity, context: Context) -> AlbumWithImageEntity {
        AlbumWithImageEntity(
            id: result.id,
            userId: result.userId,
            title: result.title,
            thumbnailUrl: context.thumbnailUrl
        )
    }
}
