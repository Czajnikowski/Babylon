//
//  ViewForPostWithIdBuilding.swift
//  View
//
//  Created by Maciek on 02/07/2019.
//  Copyright © 2019 mczarnik.com. All rights reserved.
//

import SwiftUI

protocol ViewForPostWithIdBuilding {
    func build(forPostWithId postId: Int) -> AnyView?
}
