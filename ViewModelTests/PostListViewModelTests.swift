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
                return Publishers
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
                return Publishers.Empty<Data, URLError>().eraseToAnyPublisher()
            }
        }
        
        let viewModel = PostListViewModel(
            api: FailingAPIStub(),
            didChangeDispatchQueue: .testQueue
        )
        
        let expectation = XCTestExpectation(description: "ViewModel should send change")
        let subscription = viewModel.didChange.sink { _ in
            expectation.fulfill()
        }
        
        viewModel.loadData()
        
        XCTAssertEqual(XCTWaiter().wait(for: [expectation], timeout: 0.1), .completed)
        XCTAssertEqual(viewModel.error, BabylonError.networking)
        
        subscription.cancel()
    }
    
    func testReloadData_From_SinglePostAPI_Generates_RowModel() {
        final class SinglePostAPIStub: APIProviding {
            func postsDataPublisher() -> AnyPublisher<Data, URLError> {
                return Publishers
                    //force!
                    .Just(try! JSONEncoder().encode([PostDTO.dummy]))
                    .mapError { _ in URLError(.badURL) }
                    .eraseToAnyPublisher()
            }
            
            func repostsDataPublisher() -> AnyPublisher<Data, URLError> {
                return Publishers.Empty<Data, URLError>().eraseToAnyPublisher()
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
        
        let expectation = XCTestExpectation(description: "ViewModel should have row model")
        let subscription = viewModel.didChange.sink { _ in
            expectation.fulfill()
        }
        
        viewModel.loadData()
        
        XCTAssertEqual(XCTWaiter().wait(for: [expectation], timeout: 0.1), .completed)
        XCTAssertEqual(viewModel.postRowModels, [PostRowModel(with: .dummy)])
        
        subscription.cancel()
    }
}
