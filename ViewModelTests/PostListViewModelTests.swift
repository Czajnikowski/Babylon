//
//  PostListViewModelTests.swift
//  ViewModelTests
//
//  Created by Maciek on 28/06/2019.
//  Copyright © 2019 mczarnik.com. All rights reserved.
//

import Combine
import View
@testable import ViewModel
import XCTest

final class PostListViewModelTests: XCTestCase {
    func testReloadData_From_FailingAPI_Generates_Error() {
        final class FailingAPIStub: PostsDataPublishing {
            func postsDataPublisher() -> AnyPublisher<Data, URLError> {
                Publishers
                    .Fail(
                        outputType: Data.self,
                        failure: URLError(.appTransportSecurityRequiresSecureConnection)
                    )
                    .eraseToAnyPublisher()
            }
        }
        
        let viewModel = PostListViewModel(
            api: FailingAPIStub(),
            didChangeDispatchQueue: .testQueue
        )
        
        XCTAssertEqual(
            viewModel.didChange.materializeOutput(triggeredBy: viewModel.loadData)?.error,
            BabylonError.networking
        )
    }
    
    func testReloadData_From_SinglePostAPI_Generates_RowModel() {
        final class SinglePostAPIStub: PostsDataPublishing {
            func postsDataPublisher() -> AnyPublisher<Data, URLError> {
                let postData = try? JSONEncoder().encode([PostDTO.dummy])
                
                return Publishers
                    .Once<Data, URLError>(postData ?? Data())
                    .eraseToAnyPublisher()
            }
        }
        
        let viewModel = PostListViewModel(
            api: SinglePostAPIStub(),
            didChangeDispatchQueue: .testQueue
        )
        
        XCTAssertEqual(
            viewModel.didChange.materializeOutput(triggeredBy: viewModel.loadData)?.postRowStates,
            [PostRowState(with: .dummy)]
        )
    }
}
