//
//  MyAlbumApp.swift
//  MyAlbum
//
//  Created by Kiarash Vosough on 7/13/23.
//

import SwiftUI
import ComposableArchitecture
import XCTestDynamicOverlay

@main
struct MyAlbumApp: App {

    private let store = StoreOf<RootReducer>(initialState: RootReducer.State(), reducer: RootReducer())

    var body: some Scene {
        WindowGroup {
            if !_XCTIsTesting {
                RootView(store: store)
            }
        }
    }
}
