//
//  ChangeSending.swift
//  View
//
//  Created by Maciek on 01/07/2019.
//  Copyright © 2019 mczarnik.com. All rights reserved.
//

import Combine

public protocol ChangeSending {
    var sendChange: PassthroughSubject<Void, Never> { get }
}
