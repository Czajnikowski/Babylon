//
//  SnapshotTests.swift
//  SnapshotTests
//
//  Created by Maciek on 01/07/2019.
//  Copyright © 2019 mczarnik.com. All rights reserved.
//

import FBSnapshotTestCase
import XCTest
@testable import View
import SwiftUI

class SnapshotTests: FBSnapshotTestCase {
    override func setUp() {
        super.setUp()
        
        recordMode = true
    }
    
    func testX() {
        let viewController = PostListExperienceBuilder.buildMockedViewController()
        let v = viewController.view!
        
        v.frame = CGRect(
            origin: CGPoint.zero,
            size: CGSize(width: 300, height: 500)
        )
        
        //  TODO: https://github.com/uber/ios-snapshot-test-case/issues/97
        FBSnapshotVerifyView(v)
    }
}
