//
//  AppUserDefaults.swift
//  Shopreme-Products
//
//  Created by Kiarash Vosough on 7/18/23.
//

import Foundation
import Combine

final class AppUserDefaults {

    enum InternalError: Swift.Error {
        case didNotFindValue
    }
    
    let userDefaults: UserDefaults

    init(userDefaults: UserDefaults = .standard) {
        self.userDefaults = userDefaults
    }
}

