//
//  DispatchQueue+didChange.swift
//  ViewModelTests
//
//  Created by Maciek on 29/06/2019.
//  Copyright © 2019 mczarnik.com. All rights reserved.
//

import Foundation

extension DispatchQueue {
    static var testQueue: DispatchQueue { DispatchQueue(label: "didChangeDispatchQueue") }
}
