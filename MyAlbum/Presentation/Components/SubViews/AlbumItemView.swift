//
//  AlbumItemView.swift
//  MyAlbum
//
//  Created by Kiarash Vosough on 7/14/23.
//

import SwiftUI
import Dependencies

struct AlbumItemView: View {

    @Dependency(\.loadImageRespository) private var loadImageRespository
    
    private let model: AlbumWithImageEntity
    @State private var data: Data?
    
    init(model: AlbumWithImageEntity) {
        self.model = model
    }

    var body: some View {
        HStack(spacing: 16) {
            image
            titleText
        }
        .animation(.easeInOut, value: data)
        .roundedView()
        .task(id: model) {
            guard data == nil else { return }
            data = try? await loadImageRespository.loadimageData(model.thumbnailUrl)
        }
        .padding(.all, 8)
    }

    @ViewBuilder
    private var image: some View {
        if let data, let image = UIImage(data: data) {
            Image(uiImage: image)
                .resizable()
                .frame(width: 50, height: 50)
        }
    }

    private var titleText: some View {
        Text(model.title)
            .multilineTextAlignment(.leading)
            .frame(maxWidth: .infinity, alignment: .leading)
    }
}

// MARK: - Equatable

extension AlbumItemView: Equatable {

    static func == (lhs: AlbumItemView, rhs: AlbumItemView) -> Bool {
        lhs.model == rhs.model && lhs.data == rhs.data
    }
}

// MARK: - Preview

struct AlbumItemView_Previews: PreviewProvider {
    static var previews: some View {
        AlbumItemView(
            model: AlbumWithImageEntity(
                id: 0,
                userId: 0,
                title: "",
                thumbnailUrl: URL.applicationDirectory
            )
        )
    }
}
