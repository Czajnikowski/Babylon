//
//  AlertMessageErrorConsuming.swift
//  ViewModel
//
//  Created by Maciek on 03/07/2019.
//  Copyright © 2019 mczarnik.com. All rights reserved.
//

protocol AlertMessageErrorConsuming: class {
    var error: BabylonError? { get set }
}

extension AlertMessageErrorConsuming {
    public func consumeAlertMessage() {
        error = nil
    }
}
