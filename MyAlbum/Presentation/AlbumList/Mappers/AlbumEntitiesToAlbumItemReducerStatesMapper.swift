//
//  AlbumEntitiesToAlbumItemReducerStatesMapper.swift
//  MyAlbum
//
//  Created by Kiarash Vosough on 7/14/23.
//

import ComposableArchitecture

struct AlbumEntitiesToAlbumItemReducerStatesMapper: MapperProtocol {

    typealias From = [AlbumEntity]
    typealias To = IdentifiedArrayOf<AlbumItemReducer.State>

    func map(_ result: [AlbumEntity], context: Void) -> IdentifiedArrayOf<AlbumItemReducer.State> {
        IdentifiedArrayOf(uniqueElements: result.map {
            AlbumItemReducer.State(albumId: $0.id, title: $0.title)
        })
    }
}
