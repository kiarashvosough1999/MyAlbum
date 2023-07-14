//
//  HTTPMethod.swift
//  MyAlbum
//
//  Created by Kiarash Vosough on 7/13/23.
//

enum HTTPMethod: String, Equatable, Hashable {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
    case patch = "PATCH"
}
