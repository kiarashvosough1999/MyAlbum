//
//  PhotoItemView.swift
//  MyAlbum
//
//  Created by Kiarash Vosough on 7/14/23.
//

import SwiftUI
import ComposableArchitecture

// MARK: View

struct PhotoItemView: View {

    typealias ViewStoreRef = ViewStoreOf<PhotoItemReducer>

    private let store: StoreOf<PhotoItemReducer>

    init(store: StoreOf<PhotoItemReducer>) {
        self.store = store
    }

    var body: some View {
        WithViewStore(store) { viewStore in
            ZStack {
                if viewStore.enlarge {
                    enLargedView(viewStore: viewStore)
                }
                HStack {
                    AsyncLoadingImage(url: viewStore.thumbnailImageUrl, width: 60, height: 60)
                        .equatable()
                    Text(viewStore.title)
                        .fillText()
                }
                .onTapGesture{
                    viewStore.send(.toggle, animation: .easeInOut)
                }
                .blur(radius: viewStore.enlarge ? 7 : 0)
                .offset(y: 1)
            }
            .roundedView()
            .padding(.all, 8)
        }
        EmptyView()
    }

    @MainActor
    private func enLargedView(viewStore: ViewStoreRef) -> some View {
        AsyncLoadingImage(url: viewStore.originalImageUrl)
            .equatable()
            .enLarge(value: viewStore.$enlarge)
    }
}

// MARK: - Equatable

extension PhotoItemView: Equatable {

    static func == (lhs: PhotoItemView, rhs: PhotoItemView) -> Bool {
        lhs.store.withState(\.originalImageUrl) == rhs.store.withState(\.originalImageUrl) &&
        lhs.store.withState(\.thumbnailImageUrl) == rhs.store.withState(\.thumbnailImageUrl) &&
        lhs.store.withState(\.enlarge) == rhs.store.withState(\.enlarge) &&
        lhs.store.withState(\.title) == rhs.store.withState(\.title)
    }
}

#if DEBUG
struct PhotoItemView_Previews: PreviewProvider {
    static var previews: some View {
        PhotoItemView(
            store: StoreOf<PhotoItemReducer>(
                initialState: PhotoItemReducer.State(
                    id: 1,
                    thumbnailImageUrl: URL(string: "https://via.placeholder.com/600/771796")!,
                    originalImageUrl: URL(string: "https://via.placeholder.com/600/771796")!,
                    title: "Some Title"
                ),
                reducer: PhotoItemReducer()
            )
        )
    }
}
#endif
