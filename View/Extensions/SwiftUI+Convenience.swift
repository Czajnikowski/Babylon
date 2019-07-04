//
//  SwiftUI+Convenience.swift
//  View
//
//  Created by Maciek on 03/07/2019.
//  Copyright © 2019 mczarnik.com. All rights reserved.
//

import SwiftUI

extension Alert {
    static func errorAlert(withMessage message: String?) -> Alert {
        return Alert(
            title: Text("Error"),
            message: Text(message ?? "Unknown error")
        )
    }
}

extension View {
    public var wrappedInHostingController: UIHostingController<Self> {
        UIHostingController(rootView: self)
    }
}
