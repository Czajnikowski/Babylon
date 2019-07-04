//
//  View+EricaSadun.swift
//  View
//
//  Created by Maciek on 03/07/2019.
//  Copyright © 2019 mczarnik.com. All rights reserved.
//

import SwiftUI

//  Source: https://ericasadun.com/2019/06/23/swiftui-modified-content-type-erasure-and-type-debugging/

extension View {
    var typeErased: AnyView { AnyView(self) }

    func passthrough(applying closure: (_ instance: Self) -> ()) -> Self {
        closure(self)
        return self
    }
}
