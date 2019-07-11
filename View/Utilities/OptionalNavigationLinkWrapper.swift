//
//  OptionalNavigationLinkWrapper.swift
//  View
//
//  Created by Maciek on 11/07/2019.
//  Copyright © 2019 mczarnik.com. All rights reserved.
//

import SwiftUI

final class OptionalNavigationLinkWrapper {
    private let provideDestination: () -> AnyView?
    
    init(destinationProvidedBy provideDestination: @escaping () -> AnyView?) {
        self.provideDestination = provideDestination
    }
}

extension OptionalNavigationLinkWrapper: ViewWrapping {
    func wrapperView(wrapping wrappedView: AnyView) -> AnyView {
        guard let destination = provideDestination() else { return wrappedView }
        
        return NavigationLink(destination: destination) {
            wrappedView
        }
            .typeErased
    }
}
