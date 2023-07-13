//
//  FetchPhotoUseCaseStub.swift
//  MyAlbumTests
//
//  Created by Kiarash Vosough on 7/14/23.
//

import Foundation
@testable import MyAlbum

final class FetchPhotoUseCaseStub {
    private let error: Error?
    private let delayInSeconds: UInt64
    private let photos: [MyAlbum.PhotoEntity]
    private let photo: MyAlbum.PhotoEntity?
    
    var albumId: Int?
    
    init(error: Error? = nil, delayInSeconds: UInt64 = 0, photos: [MyAlbum.PhotoEntity] = [], photo: MyAlbum.PhotoEntity? = nil) {
        self.error = error
        self.delayInSeconds = delayInSeconds
        self.photos = photos
        self.photo = photo
    }
}

extension FetchPhotoUseCaseStub: FetchPhotoUseCaseProtocol {
    
    func fetchPhotos(albumId: Int) async throws -> [MyAlbum.PhotoEntity] {
        self.albumId = albumId
        try await Task.sleep(nanoseconds: delayInSeconds * NSEC_PER_SEC)
        if let error { throw error }
        return photos
    }
    
    func fetchPhoto(albumId: Int) async throws -> MyAlbum.PhotoEntity {
        self.albumId = albumId
        try await Task.sleep(nanoseconds: delayInSeconds * NSEC_PER_SEC)
        if let error { throw error }
        return photo!
    }
}
