//
//  PhotoItemView.swift
//  MyAlbum
//
//  Created by Kiarash Vosough on 7/14/23.
//

import SwiftUI
import Dependencies

// MARK: ViewModel

struct PhotoItemViewModel {
    let thumbnailImageUrl: URL
    let originalImageUrl: URL
    let title: String
}

extension PhotoItemViewModel: Hashable {}
extension PhotoItemViewModel: Identifiable {
    var id: Int { hashValue }
}

// MARK: View

struct PhotoItemView: View {

    @State private var enlarge = false
    private let model: PhotoItemViewModel
    
    init(model: PhotoItemViewModel) {
        self.model = model
    }

    var body: some View {
        ZStack {
            if enlarge {
                enLargedView
            }
            HStack {
                AsyncLoadingImage(url: model.thumbnailImageUrl, width: 60, height: 60)
                    .equatable()
                Text(model.title)
                    .fillText()
            }
            .onTapGesture{
                withAnimation {
                    self.enlarge.toggle()
                }
            }
            .blur(radius: self.enlarge ? 7 : 0)
            .offset(y: 1)
        }
        .roundedView()
        .padding(.all, 8)
    }

    private var enLargedView: some View {
        AsyncLoadingImage(url: model.originalImageUrl)
            .equatable()
            .enLarge(value: $enlarge)
    }
}

// MARK: - Equatable

extension PhotoItemView: Equatable {

    static func == (lhs: PhotoItemView, rhs: PhotoItemView) -> Bool {
        lhs.model == rhs.model
    }
}
