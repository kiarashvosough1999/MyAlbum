//
//  ScrollableLazyVStack.swift
//  MyAlbum
//
//  Created by Kiarash Vosough on 7/14/23.
//

import SwiftUI

struct ScrollableLazyVStack<C, Content>: View
where C: RandomAccessCollection, C.Element: Identifiable, Content: View {

    private let dataSource: C
    private let content: (C.Element) -> Content
    
    init(dataSource: C, @ViewBuilder content: @escaping (C.Element) -> Content) {
        self.dataSource = dataSource
        self.content = content
    }
    
    var body: some View {
        ScrollView {
            LazyVStack() {
                ForEach(dataSource) { item in
                    content(item)
                }
            }
        }
    }
}
