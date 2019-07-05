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
        final class FailingAPIStub: APIProviding {
            func postsDataPublisher() -> AnyPublisher<Data, URLError> {
                Publishers
                    .Fail(
                        outputType: Data.self,
                        failure: URLError(.appTransportSecurityRequiresSecureConnection)
                    )
                    .eraseToAnyPublisher()
            }
            
            func userDataPublisher(forUserWithId userId: Int) -> AnyPublisher<Data, URLError> {
                fatalError()
            }
            
            func commentDataPublisher(forPostWithId postId: Int) -> AnyPublisher<Data, URLError> {
                fatalError()
            }
            
            func repostsDataPublisher() -> AnyPublisher<Data, URLError> {
                Publishers.Empty<Data, URLError>().eraseToAnyPublisher()
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
        final class SinglePostAPIStub: APIProviding {
            func postsDataPublisher() -> AnyPublisher<Data, URLError> {
                Publishers
                    .Once<Data, URLError>(try! JSONEncoder().encode([PostDTO.dummy]))
                    .eraseToAnyPublisher()
            }
            
            func repostsDataPublisher() -> AnyPublisher<Data, URLError> {
                Publishers.Empty<Data, URLError>().eraseToAnyPublisher()
            }
            
            func userDataPublisher(forUserWithId userId: Int) -> AnyPublisher<Data, URLError> {
                fatalError()
            }
            
            func commentDataPublisher(forPostWithId postId: Int) -> AnyPublisher<Data, URLError> {
                fatalError()
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
