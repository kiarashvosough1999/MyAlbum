//
//  ScrollableLazyVStack.swift
//  MyAlbum
//
//  Created by Kiarash Vosough on 7/14/23.
//

import SwiftUI

struct ScrollableLazyVStack<C, Content, ID>: View
where C: RandomAccessCollection, Content: View, ID: Hashable {

    private let dataSource: C
    private let content: (C.Element) -> Content
    private let idKeyPath: KeyPath<C.Element, ID>
    
    init(dataSource: C, @ViewBuilder content: @escaping (C.Element) -> Content) where C.Element: Identifiable, C.Element.ID == ID {
        self.dataSource = dataSource
        self.content = content
        self.idKeyPath = \.id
    }

    init(dataSource: C, id: KeyPath<C.Element, ID>, @ViewBuilder content: @escaping (C.Element) -> Content) {
        self.dataSource = dataSource
        self.content = content
        self.idKeyPath = id
    }

    var body: some View {
        ScrollView {
            LazyVStack() {
                ForEach(dataSource, id: idKeyPath) { item in
                    content(item)
                }
            }
        }
    }
}
