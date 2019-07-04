//
//  Model+DTO.swift
//  ViewModel
//
//  Created by Maciek on 25/06/2019.
//  Copyright © 2019 mczarnik.com. All rights reserved.
//

import View

extension PostRowModel {
    init(with post: PostDTO) {
        self.init(id: post.id, title: post.title)
    }
}
