//
//  ThumbnailURLCacheRespositoryPorotocol.swift
//  MyAlbum
//
//  Created by Kiarash Vosough on 7/21/23.
//

import Foundation

protocol ThumbnailURLCacheRespositoryPorotocol {
    func cache(albumId: Int, thumbnailUrl: URL) throws
    func retreiveThumbnailUrlForAlbum(with Id: Int) throws -> URL
}
