//
//  AlbumRepositoryProtocol.swift
//  MyAlbum
//
//  Created by Kiarash Vosough on 7/13/23.
//

import Foundation

protocol AlbumRepositoryProtocol {
    func fetchAlbums() async throws -> [AlbumEntity]
}
