//
//  AlertMessageConsuming.swift
//  View
//
//  Created by Maciek on 03/07/2019.
//  Copyright © 2019 mczarnik.com. All rights reserved.
//

protocol AlertMessageConsuming: class {
    var alertMessage: String? { get set }
}

extension AlertMessageConsuming where Self: AnyObject {
    func consumeAlertMessage() {
        alertMessage = nil
    }
}
