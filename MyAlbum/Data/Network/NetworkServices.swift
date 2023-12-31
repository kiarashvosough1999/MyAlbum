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
        // Use cache if specified on request, specificly for images
        self.cache = URLCache(
            memoryCapacity: NetworkServices.cacheMemoryCapacity,
            diskCapacity: NetworkServices.cacheDiskCapacity
        )
        // Set cache for shared configuration, So that API work with it also use cache.
        session.configuration.urlCache = self.cache
    }
}
