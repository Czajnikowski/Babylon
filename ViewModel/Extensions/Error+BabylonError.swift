//
//  Error+BabylonError.swift
//  ViewModel
//
//  Created by Maciek on 28/06/2019.
//  Copyright © 2019 mczarnik.com. All rights reserved.
//

extension Error {
    func toBabylonError(_ targetError: BabylonError) -> BabylonError {
        return (self as? BabylonError) ?? targetError
    }
}
