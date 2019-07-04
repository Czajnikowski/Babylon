//
//  SelfChangeSending.swift
//  ViewModel
//
//  Created by Maciek on 04/07/2019.
//  Copyright © 2019 mczarnik.com. All rights reserved.
//

import Combine

protocol SelfChangeSending {
    associatedtype SubjectType: Subject
        where SubjectType.Output == Self, SubjectType.Failure == Never
    
    var didChange: SubjectType { get }
}

extension SelfChangeSending {
    func sendChange() {
        didChange.send(self)
    }
}
