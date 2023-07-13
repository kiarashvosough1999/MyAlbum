//
//  FetchImageRepository.swift
//  MyAlbum
//
//  Created by Kiarash Vosough on 7/14/23.
//

import Foundation

protocol LoadImageRespositoryProtocol {
    func loadimageData(_ url: URL) async throws -> Data
}
