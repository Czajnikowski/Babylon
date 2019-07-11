//
//  ViewWrapping.swift
//  ViewModel
//
//  Created by Maciek on 11/07/2019.
//  Copyright © 2019 mczarnik.com. All rights reserved.
//

import SwiftUI

protocol ViewWrapping {
    associatedtype WrapperView
    
    func wrapperView(wrapping wrappedView: AnyView) -> WrapperView
}
