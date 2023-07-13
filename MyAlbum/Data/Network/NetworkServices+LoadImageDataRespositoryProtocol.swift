//
//  NetworkServices+LoadImageDataRespositoryProtocol.swift
//  MyAlbum
//
//  Created by Kiarash Vosough on 7/13/23.
//

import Foundation
import Dependencies

extension NetworkServices: LoadImageRespositoryProtocol {

    func loadimageData(_ url: URL) async throws -> Data {
        let request = URLRequest(url: url, cachePolicy: .returnCacheDataElseLoad)
        return try await session.data(for: request).0
    }
}

// MARK: - Dependency

extension DependencyValues {
    
    var loadImageRespository: LoadImageRespositoryProtocol {
        get {
            self[Key.self]
        } set {
            self[Key.self] = newValue
        }
    }
    
    private enum Key: DependencyKey {
        static var liveValue: LoadImageRespositoryProtocol { NetworkServices.shared }
    }
}
