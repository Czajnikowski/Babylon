//
//  BabylonError.swift
//  Babylon
//
//  Created by Maciek on 27/06/2019.
//  Copyright © 2019 mczarnik.com. All rights reserved.
//

public enum BabylonError: Error {
    case
    networking,
    parsing
}

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
