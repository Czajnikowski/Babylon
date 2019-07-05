//
//  BabylonError+AlertMessageProviding.swift
//  ViewModel
//
//  Created by Maciek on 01/07/2019.
//  Copyright © 2019 mczarnik.com. All rights reserved.
//

import View

extension BabylonError {
    var localizedAlertMessage: String {
        switch self {
        case .networking:
            return "Unable to download data".localized(comment: "Error message")
        case .parsing:
            return "Unable to parse data".localized(comment: "Error message")
        }
    }
}
