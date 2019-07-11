//
//  ViewForDependencyBuilder.swift
//  View
//
//  Created by Maciek on 02/07/2019.
//  Copyright © 2019 mczarnik.com. All rights reserved.
//

import SwiftUI

public class ViewForDependencyBuilder<Dependency> {
    init() {}
    
    func buildView(for dependency: Dependency) -> AnyView? {
        nil
    }
}

public final class NoViewForDependencyBuilder<Dependency>: ViewForDependencyBuilder<Dependency> {
    override public init() {}
}
