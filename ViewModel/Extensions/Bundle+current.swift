//
//  Bundle+current.swift
//  View
//
//  Created by Maciek on 04/07/2019.
//  Copyright © 2019 mczarnik.com. All rights reserved.
//

private class BundleIdentifyingDummy {
}

extension Bundle {
    static let current = Bundle(for: BundleIdentifyingDummy.self)
}
