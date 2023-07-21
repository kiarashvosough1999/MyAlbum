//
//  AppUserDefaults+ThumbnailURLCacheRespositoryPorotocol.swift
//  MyAlbum
//
//  Created by Kiarash Vosough on 7/21/23.
//

import Foundation
import Dependencies

extension AppUserDefaults: ThumbnailURLCacheRespositoryPorotocol {

    func cache(albumId: Int, thumbnailUrl: URL) throws {
        userDefaults.set(thumbnailUrl, forKey: "\(albumId)")
    }

    func retreiveThumbnailUrlForAlbum(with Id: Int) throws -> URL {
        guard let url = userDefaults.url(forKey: "\(Id)") else {
            throw InternalError.didNotFindValue
        }
        return url
    }
}

// MARK: - Dependency

extension DependencyValues {
    
    var thumbnailURLCacheRespository: ThumbnailURLCacheRespositoryPorotocol {
        get {
            self[Key.self]
        } set {
            self[Key.self] = newValue
        }
    }
    
    private enum Key: DependencyKey {
        static var liveValue: ThumbnailURLCacheRespositoryPorotocol { AppUserDefaults() }
    }
}
