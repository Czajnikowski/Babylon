//
//  View+wrapped.swift
//  View
//
//  Created by Maciek on 11/07/2019.
//  Copyright © 2019 mczarnik.com. All rights reserved.
//

import SwiftUI

extension View {
    func wrapped<Wrapper>(using wrapper: Wrapper) -> Wrapper.WrapperView where Wrapper: ViewWrapping {
        return wrapper.wrapperView(wrapping: self.typeErased)
    }
}
