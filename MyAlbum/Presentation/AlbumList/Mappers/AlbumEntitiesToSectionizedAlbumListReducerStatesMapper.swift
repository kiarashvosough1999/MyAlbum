//
//  AlbumEntitiesToSectionizedAlbumListReducerStatesMapper.swift
//  MyAlbum
//
//  Created by Kiarash Vosough on 7/14/23.
//

import ComposableArchitecture


struct AlbumEntitiesToSectionizedAlbumListReducerStatesMapper: MapperProtocol {

    struct Context {
        let childMapper: any MapperProtocol<[AlbumEntity], IdentifiedArrayOf<AlbumItemReducer.State>, Void>
    }
    
    typealias From = [UserGroupedAlbumEntity]
    typealias To = IdentifiedArrayOf<SectionizedAlbumListReducer.State>
    
    func map(
        _ result: [UserGroupedAlbumEntity],
        context: Context
    ) -> IdentifiedArrayOf<SectionizedAlbumListReducer.State> {
        IdentifiedArrayOf<SectionizedAlbumListReducer.State>(
            uniqueElements: result.map {
                SectionizedAlbumListReducer.State(
                    userId: $0.userId,
                    albumsStates: context.childMapper.map($0.albums, context: ())
                )
            }
        )
    }
}
