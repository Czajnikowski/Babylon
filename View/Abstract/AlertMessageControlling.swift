//
//  AlertMessageProviding.swift
//  View
//
//  Created by Maciek on 03/07/2019.
//  Copyright © 2019 mczarnik.com. All rights reserved.
//

import SwiftUI

//  It's my current attempt to solve the problem described here: http://bit.ly/2YwHLW5

public protocol AlertMessageControlling {
    var localizedAlertMessage: String? { get }
    
    func consumeAlertMessage()
}

extension AlertMessageControlling {
    var alertPresentationBinding: Binding<Bool> {
        Binding(
            getValue: {
                self.localizedAlertMessage != nil
            },
            setValue: {
                if !$0 { self.consumeAlertMessage() }
            }
        )
    }
}
