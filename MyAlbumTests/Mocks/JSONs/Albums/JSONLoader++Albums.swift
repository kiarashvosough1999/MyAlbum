//
//  JSONLoader++Albums.swift
//  MyAlbumTests
//
//  Created by Kiarash Vosough on 7/13/23.
//

@testable import MyAlbum

extension JSONLoader {
    
    func loadAlbums() throws -> [AlbumEntity] {
        try self.loadJSON(name: "albums", as: [AlbumEntity].self)
    }
}
