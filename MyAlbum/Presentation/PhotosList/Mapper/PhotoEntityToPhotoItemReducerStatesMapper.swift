//
//  PhotoEntityToPhotoItemReducerStatesMapper.swift
//  MyAlbum
//
//  Created by Kiarash Vosough on 7/21/23.
//

import ComposableArchitecture

struct PhotoEntityToPhotoItemReducerStatesMapper: MapperProtocol {

    typealias From = [PhotoEntity]
    typealias To = IdentifiedArrayOf<PhotoItemReducer.State>

    func map(_ result: [PhotoEntity], context: Void) -> IdentifiedArrayOf<PhotoItemReducer.State> {
        IdentifiedArrayOf(uniqueElements: result.map {
            PhotoItemReducer.State(
                id: $0.id,
                thumbnailImageUrl: $0.thumbnailUrl,
                originalImageUrl: $0.url,
                title: $0.title
            )
        })
    }
}
