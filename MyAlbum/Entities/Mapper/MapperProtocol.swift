//
//  MapperProtocol.swift
//  MyAlbum
//
//  Created by Kiarash Vosough on 7/14/23.
//

protocol MapperProtocol {
    
    associatedtype From
    associatedtype To
    associatedtype Context = Void
    
    func map(_ result: From, context: Context) -> To
    func map(_ result: To, context: Context) -> From
}
extension MapperProtocol {
    func map(_ result: From, context: Context) -> To { fatalError("Not Implemented")}
    func map(_ result: To, context: Context) -> From { fatalError("Not Implemented")}
}
