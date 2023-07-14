//
//  PhotosListReducer.swift
//  MyAlbum
//
//  Created by Kiarash Vosough on 7/14/23.
//

import ComposableArchitecture
import Dependencies

struct PhotosListReducer: ReducerProtocol {

    struct State: Equatable {
        var albumId: Int
        
        @BindingState var photos: [PhotoEntity] = []
        @BindingState var selectedPhoto: PhotoItemViewModel?
        
        var showingPhotos: [PhotoItemViewModel] {
            photos.map {
                PhotoItemViewModel(thumbnailImageUrl: $0.thumbnailUrl, originalImageUrl: $0.url, title: $0.title)
            }
        }
    }

    enum Action: BindableAction {
        case binding(BindingAction<State>)
        case onAppear
        case photosLoaded(photos: [PhotoEntity])
    }

    @Dependency(\.fetchPhotoUseCase) private var fetchPhotoUseCase
    
    var body: some ReducerProtocolOf<Self> {
        Reduce { state, action in
            switch action {
            case .onAppear:
                let albumId = state.albumId
                return .run { send in
                    let photos = try await fetchPhotoUseCase.fetchPhotos(albumId: albumId)
                    await send(.photosLoaded(photos: photos))
                }
            case .photosLoaded(let photos):
                state.photos = photos
            default:
                break
            }
            return .none
        }
        BindingReducer()
    }
}
