//
//  PhotosRepositoryStub.swift
//  MyAlbumTests
//
//  Created by Kiarash Vosough on 7/13/23.
//

import Foundation
@testable import MyAlbum

final class PhotosRepositoryStub {
    private let error: Error?
    private let delayInSeconds: UInt64
    private let photos: [MyAlbum.PhotoEntity]
    private let photo: MyAlbum.PhotoEntity?
    
    var albumId: Int?
    var photoId: Int?
    
    init(error: Error? = nil, delayInSeconds: UInt64 = 0, photos: [MyAlbum.PhotoEntity] = [], photo: MyAlbum.PhotoEntity? = nil) {
        self.error = error
        self.delayInSeconds = delayInSeconds
        self.photos = photos
        self.photo = photo
    }
}

extension PhotosRepositoryStub: PhotosRepositoryProtocol {
    
    func fetchPhotos(albumId: Int) async throws -> [MyAlbum.PhotoEntity] {
        self.albumId = albumId
        try await Task.sleep(nanoseconds: delayInSeconds * NSEC_PER_SEC)
        if let error { throw error }
        return photos
    }
    
    func fetchPhoto(albumId: Int, photoId: Int) async throws -> MyAlbum.PhotoEntity {
        self.albumId = albumId
        self.photoId = photoId
        try await Task.sleep(nanoseconds: delayInSeconds * NSEC_PER_SEC)
        if let error { throw error }
        return photo!
    }
}
