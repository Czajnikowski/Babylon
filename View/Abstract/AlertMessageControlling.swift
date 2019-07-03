//
//  AlertMessageProviding.swift
//  View
//
//  Created by Maciek on 03/07/2019.
//  Copyright © 2019 mczarnik.com. All rights reserved.
//

import SwiftUI

public protocol AlertMessageControlling {
    var alertMessage: String? { get }
    
    func consumeAlertMessage()
}

extension AlertMessageControlling {
    var alertPresentationBinding: Binding<Bool> {
        return Binding(
            getValue: {
                return self.alertMessage != nil
            },
            setValue: {
                if !$0 { self.consumeAlertMessage() }
            }
        )
    }
}
