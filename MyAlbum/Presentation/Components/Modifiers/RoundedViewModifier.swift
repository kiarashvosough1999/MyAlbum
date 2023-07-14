//
//  RoundedViewModifier.swift
//  MyAlbum
//
//  Created by Kiarash Vosough on 7/14/23.
//

import SwiftUI

extension View {

    public func roundedView() -> some View {
        modifier(RoundedViewModifier())
    }
}

private struct RoundedViewModifier: ViewModifier {

    func body(content: Content) -> some View {
        content
            .padding(.all, 16)
            .clipShape(RoundedRectangle(cornerRadius: 16))
            .background {
                RoundedRectangle(cornerRadius: 16)
                    .foregroundColor(.secondary.opacity(0.3))
            }
    }
}
