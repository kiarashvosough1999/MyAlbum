//
//  PhotosRepositoryProtocol.swift
//  MyAlbum
//
//  Created by Kiarash Vosough on 7/13/23.
//

import Foundation

protocol PhotosRepositoryProtocol {
    func fetchPhotos(albumId: Int) async throws -> [PhotoEntity]
    func fetchPhoto(albumId: Int, photoId: Int) async throws -> PhotoEntity
}
