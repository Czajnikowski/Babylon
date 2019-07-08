//
//  PostDTO+dummy.swift
//  ViewModelTests
//
//  Created by Maciek on 28/06/2019.
//  Copyright © 2019 mczarnik.com. All rights reserved.
//

@testable import ViewModel

extension PostDTO {
    static let dummy = PostDTO(id: 1, userId: 1, title: "Title", body: "Description")
}
