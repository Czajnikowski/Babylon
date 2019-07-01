//
//  BabylonError+alertMessage.swift
//  View
//
//  Created by Maciek on 01/07/2019.
//  Copyright © 2019 mczarnik.com. All rights reserved.
//

extension BabylonError {
    var alertMessage: String {
        switch self {
        case .networking:
            return "Unable to download data"
        case .parsing:
            return "Unable to parse data"
        }
    }
}
