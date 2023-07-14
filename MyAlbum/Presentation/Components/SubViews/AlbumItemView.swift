//
//  AlbumItemView.swift
//  MyAlbum
//
//  Created by Kiarash Vosough on 7/14/23.
//

import SwiftUI
import Dependencies

// MARK: - ViewModel

struct AlbumItemViewModel {
    let title: String
    let thumbnailUrl: URL
}

extension AlbumItemViewModel: Hashable {}
extension AlbumItemViewModel: Identifiable {
    var id: Int { hashValue }
}

// MARK: - View

struct AlbumItemView: View {

    private let model: AlbumItemViewModel

    init(model: AlbumItemViewModel) {
        self.model = model
    }

    var body: some View {
        HStack(spacing: 16) {
            AsyncLoadingImage(url: model.thumbnailUrl, width: 50, height: 50, padding: 0)
            Text(model.title)
                .fillText()
        }
        .animation(.easeInOut, value: model)
    }
}

// MARK: - Equatable

extension AlbumItemView: Equatable {

    static func == (lhs: AlbumItemView, rhs: AlbumItemView) -> Bool {
        lhs.model == rhs.model
    }
}
