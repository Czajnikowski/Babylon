//
//  PostListViewModelBuilder.swift
//  ViewModel
//
//  Created by Maciek on 28/06/2019.
//  Copyright © 2019 mczarnik.com. All rights reserved.
//

import View

public final class PostListViewModelBuilder {
    public static func buildViewModel(
        api: APIProviding
        ) -> some ChangeReporting & PostListViewModelRepresenting {
        
        return PostListViewModel(api: api)
    }
}
