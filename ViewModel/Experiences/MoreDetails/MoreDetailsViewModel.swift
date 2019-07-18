//
//  MoreDetailsViewModel.swift
//  ViewModel
//
//  Created by Maciek on 11/07/2019.
//  Copyright © 2019 mczarnik.com. All rights reserved.
//

import Combine
import View

public class MoreDetailsViewModel: MoreDetailsViewModelRepresenting, ViewBindableObject, SelfChangeSending {
    public var willChange = PassthroughSubject<MoreDetailsViewModel, Never>()
    public let moreDetails: String = "yo"
    
    public init() {}
}
