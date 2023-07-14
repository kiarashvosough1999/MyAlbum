//
//  EnLargeViewModifier.swift
//  MyAlbum
//
//  Created by Kiarash Vosough on 7/14/23.
//

import SwiftUI

extension View {
    func enLarge(value: Binding<Bool>) -> some View {
        modifier(EnLargeViewModifier(enlarge: value))
    }
}

private struct EnLargeViewModifier: ViewModifier {

    @Binding private var enlarge: Bool

    init(enlarge: Binding<Bool>) {
        self._enlarge = enlarge
    }

    func body(content: Content) -> some View {
        ZStack {
            content
        }
        .frame(width: 200, height: 200)
        .background(Color.black.opacity(0.2))
        .foregroundColor(Color.clear)
        .cornerRadius(20)
        .transition(.slide)
        .opacity(self.enlarge ? 1 : 0)
        .zIndex(2)
        .onTapGesture{
            withAnimation {
                self.enlarge.toggle()
            }
        }
    }
}
