//
//  FillTextModifier.swift
//  MyAlbum
//
//  Created by Kiarash Vosough on 7/14/23.
//

import SwiftUI

extension View {
    func fillText() -> some View {
        modifier(FillTextModifier())
    }
}

private struct FillTextModifier: ViewModifier {

    func body(content: Content) -> some View {
        content
            .multilineTextAlignment(.leading)
            .frame(maxWidth: .infinity, alignment: .leading)
    }
}

struct FillTextModifier_Previews: PreviewProvider {
    static var previews: some View {
        Text("Hello, world!")
            .modifier(FillTextModifier())
    }
}
