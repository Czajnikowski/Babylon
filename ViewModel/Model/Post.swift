//
//  Post.swift
//  Babylon
//
//  Created by Maciek on 25/06/2019.
//  Copyright © 2019 mczarnik.com. All rights reserved.
//

public struct PostDTO: Codable {
    let id: Int
    let userId: Int
    let title: String
    let body: String
}
