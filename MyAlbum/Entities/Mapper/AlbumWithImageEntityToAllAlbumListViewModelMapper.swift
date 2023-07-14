//
//  AlbumWithImageEntityToAllAlbumListViewModelMapper.swift
//  MyAlbum
//
//  Created by Kiarash Vosough on 7/14/23.
//

import Foundation

struct AlbumWithImageEntityToAllAlbumListViewModelMapper: MapperProtocol {

    typealias From = AlbumWithImageEntity
    typealias To = AllAlbumListViewModel
    
    func map(_ result: AlbumWithImageEntity, context: ()) -> AllAlbumListViewModel {
        AllAlbumListViewModel(
            id: result.id,
            item: AlbumItemViewModel(title: result.title, thumbnailUrl: result.thumbnailUrl)
        )
    }
}
