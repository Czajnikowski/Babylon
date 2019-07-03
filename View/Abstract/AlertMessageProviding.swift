//
//  AlertMessageProviding.swift
//  View
//
//  Created by Maciek on 03/07/2019.
//  Copyright © 2019 mczarnik.com. All rights reserved.
//

import SwiftUI

public protocol AlertMessageControlling: class {
    var alertMessage: String? { get set }
}

extension AlertMessageControlling {
    var alertPresentationBinding: Binding<Bool> {
        return Binding(
            getValue: { self.alertMessage != nil },
            setValue: { if $0 == false { self.alertMessage = nil } }
        )
    }
}
