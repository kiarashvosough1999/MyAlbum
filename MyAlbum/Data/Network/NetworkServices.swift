//
//  NetworkServices.swift
//  MyAlbum
//
//  Created by Kiarash Vosough on 7/13/23.
//

import Foundation

final class NetworkServices {

    static let shared = NetworkServices()
    
    private static var cacheMemoryCapacity: Int { Int(1.5e+7) }
    private static var cacheDiskCapacity: Int { Int(1e+8) }
    
    let session: URLSession
    let cache: URLCache
    
    init(session: URLSession = URLSession.shared) {
        self.session = session
        self.cache = URLCache(
            memoryCapacity: NetworkServices.cacheMemoryCapacity,
            diskCapacity: NetworkServices.cacheDiskCapacity
        )
        session.configuration.urlCache = self.cache
    }
}
