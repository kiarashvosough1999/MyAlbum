//
//  StoreScrollableLazyVStack.swift
//  MyAlbum
//
//  Created by Kiarash Vosough on 7/20/23.
//

import SwiftUI
import ComposableArchitecture

struct StoreScrollableLazyVStack<State, Action, Content, ID>: View
where State: Equatable, Content: View, ID: Hashable {

    typealias StoreRef = Store<IdentifiedArray<ID, State>, (ID, Action)>
    
    private let store: StoreRef
    private let content: (Store<State, Action>) -> Content
    
    init(store: StoreRef, @ViewBuilder content: @escaping (Store<State, Action>) -> Content) {
        self.store = store
        self.content = content
    }

    var body: some View {
        ScrollView {
            LazyVStack() {
                ForEachStore(store) { childStore in
                    content(childStore)
                }
            }
        }
    }
}
