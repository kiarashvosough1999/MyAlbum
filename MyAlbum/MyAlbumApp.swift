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
            // Prevent UI Startup On Unit Testing
            if !_XCTIsTesting {
                RootView(store: store)
            }
        }
    }
}
