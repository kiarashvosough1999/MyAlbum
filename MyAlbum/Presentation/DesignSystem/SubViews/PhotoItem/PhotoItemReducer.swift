//
//  PhotoItemReducer.swift
//  MyAlbum
//
//  Created by Kiarash Vosough on 7/21/23.
//

import ComposableArchitecture
import Foundation

struct PhotoItemReducer: ReducerProtocol {

    struct State: Hashable, Identifiable {

        @BindingState var enlarge = false

        let id: Int
        let thumbnailImageUrl: URL
        let originalImageUrl: URL
        let title: String
    }

    enum Action: BindableAction {
        case binding(BindingAction<State>)
        case toggle
    }
    
    var body: some ReducerProtocolOf<Self> {
        Reduce { state, action in
            switch action {
            case .toggle:
                state.enlarge.toggle()
            default:
                return .none
            }
            return .none
        }
        BindingReducer()
    }
}
