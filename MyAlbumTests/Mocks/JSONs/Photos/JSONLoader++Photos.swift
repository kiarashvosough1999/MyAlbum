//
//  JSONLoader++Photos.swift
//  MyAlbumTests
//
//  Created by Kiarash Vosough on 7/13/23.
//

@testable import MyAlbum

extension JSONLoader {
    
    func loadPhotos() throws -> [PhotoEntity] {
        try self.loadJSON(name: "photos", as: [PhotoEntity].self)
    }
}
