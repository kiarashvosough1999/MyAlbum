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
        let albumId: Int

        @BindingState fileprivate var photos: [PhotoEntity] = []
        var showingPhotos: IdentifiedArrayOf<PhotoItemReducer.State> = .init()
    }

    enum Action: BindableAction {
        case binding(BindingAction<State>)
        case onAppear
        case photosLoaded(photos: [PhotoEntity])
        case photo(id: PhotoItemReducer.State.ID, action: PhotoItemReducer.Action)
    }

    // MARK: - Depedency

    @Dependency(\.fetchPhotoUseCase) private var fetchPhotoUseCase

    // MARK: - Mapper
    
    private var photoEntityStatesMaper: PhotoEntityToPhotoItemReducerStatesMapper {
        PhotoEntityToPhotoItemReducerStatesMapper()
    }
    
    // MARK: - Reducer

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
                state.showingPhotos = photoEntityStatesMaper.map(photos)
            default:
                break
            }
            return .none
        }
        .forEach(\.showingPhotos, action: /Action.photo) {
            PhotoItemReducer()
        }
        BindingReducer()
    }
}
