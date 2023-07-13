//
//  FirstAppear.swift
//  MyAlbum
//
//  Created by Kiarash Vosough on 7/13/23.
//

import SwiftUI

extension View {

    public func onFirstAppear(_ action: @escaping () -> Void) -> some View {
        modifier(FirstAppear(action: action))
    }
}

private struct FirstAppear: ViewModifier {

    private let action: () -> ()

    fileprivate init(action: @escaping () -> Void) {
        self.action = action
    }

    @State private var hasAppeared = false

    func body(content: Content) -> some View {
        // And then, track it here
        content.onAppear {
            guard !hasAppeared else { return }
            hasAppeared = true
            action()
        }
    }
}
