//
//  SwiftUI+UIKit.swift
//  View
//
//  Created by Maciek on 04/07/2019.
//  Copyright © 2019 mczarnik.com. All rights reserved.
//

import SwiftUI

extension View {
    public var wrappedInHostingController: UIHostingController<Self> {
        UIHostingController(rootView: self)
    }
}
