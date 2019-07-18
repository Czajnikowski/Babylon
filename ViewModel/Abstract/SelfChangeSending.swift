//
//  SelfChangeSending.swift
//  ViewModel
//
//  Created by Maciek on 04/07/2019.
//  Copyright © 2019 mczarnik.com. All rights reserved.
//

import Combine

protocol SelfChangeSending {
    associatedtype WillChangeSubject: Subject
        where WillChangeSubject.Output == Self, WillChangeSubject.Failure == Never
    
    var willChange: WillChangeSubject { get }
}

extension SelfChangeSending {
    func willChange() {
        willChange.send(self)
    }
}
