//
//  AlbumWithImageEntityToSectionizedAlbumListViewModel.swift
//  MyAlbum
//
//  Created by Kiarash Vosough on 7/14/23.
//

import Foundation

struct AlbumWithImageEntityToSectionizedAlbumListViewModel: MapperProtocol {

    typealias From = AlbumWithImageEntity
    typealias To = SectionizedAlbumListViewModel
    
    func map(_ result: AlbumWithImageEntity, context: ()) -> SectionizedAlbumListViewModel {
        SectionizedAlbumListViewModel(
            userId: result.userId,
            item: AlbumItemViewModel(title: result.title, thumbnailUrl: result.thumbnailUrl)
        )
    }
}
