//
//  AlbumItemReducer.swift
//  MyAlbum
//
//  Created by Kiarash Vosough on 7/20/23.
//

import ComposableArchitecture
import Foundation
import Dependencies

struct AlbumItemReducer: ReducerProtocol {

    struct State: Equatable, Identifiable {
        var id: Int {
            albumId
        }

        var albumId: Int
        var title: String
        var thumbnailUrl: URL?
    }

    enum Action {
        case onAppeared
        case onDisAppeared
        case thumbnailLoaded(URL)
    }

    enum Cancellables {
        case thumbnailLoading
    }
    
    @Dependency(\.fetchPhotoUseCase) private var fetchPhotoUseCase
    
    var body: some ReducerProtocolOf<Self> {
        Reduce { state, action in
            switch action {
            case .onAppeared:
                // to persist the thumbnailUrl which wasd fetched before, not fetch again
                if state.thumbnailUrl == nil {
                    let albumId = state.albumId
                    return .run { send in
                        let url = try await fetchPhotoUseCase.fetchRandomPhoto(albumId: albumId)
                        guard Task.isCancelled == false else { return }
                        await send(.thumbnailLoaded(url.thumbnailUrl))
                    } catch: { _, _ in }
                    .cancellable(id: Cancellables.thumbnailLoading)
                }
            case .onDisAppeared:
                return .cancel(id: Cancellables.thumbnailLoading)
            case .thumbnailLoaded(let thumbnailUrl):
                state.thumbnailUrl = thumbnailUrl
            }
            
            return .none
        }
    }
}
