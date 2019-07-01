//
//  ViewModelTests.swift
//  ViewModelTests
//
//  Created by Maciek on 28/06/2019.
//  Copyright © 2019 mczarnik.com. All rights reserved.
//

import Combine
import View
@testable import ViewModel
import XCTest

class PostListViewModelTests: XCTestCase {
    func testReloadData_From_FailingAPI_Generates_Error() {
        class FailingAPIStub: APIProviding {
            func postsDataPublisher() -> AnyPublisher<Data, URLError> {
                return Publishers
                    .Fail(
                        outputType: Data.self,
                        failure: URLError(.appTransportSecurityRequiresSecureConnection)
                    )
                    .eraseToAnyPublisher()
            }
        }
        
        let viewModel = PostListViewModel(
            api: FailingAPIStub(),
            didChangeReceivingQueue: DispatchQueue(label: "didChangeReceivingQueue")
        )
        
        let expectation = XCTestExpectation(description: "ViewModel should send change")
        let subscription = viewModel.didChange.sink { _ in
            expectation.fulfill()
        }
        
        viewModel.reloadData()
        
        XCTAssertEqual(XCTWaiter().wait(for: [expectation], timeout: 0.1), .completed)
        XCTAssertEqual(viewModel.error, BabylonError.networking)
        
        subscription.cancel()
    }
    
    func testReloadData_From_SinglePostAPI_Generates_RowModel() {
        class SinglePostAPIStub: APIProviding {
            func postsDataPublisher() -> AnyPublisher<Data, URLError> {
                return Publishers
                    //force!
                    .Just(try! JSONEncoder().encode([postDTO]))
                    .mapError { _ in URLError(.badURL) }
                    .eraseToAnyPublisher()
            }
        }
        
        let viewModel = PostListViewModel(
            api: SinglePostAPIStub(),
            didChangeReceivingQueue: DispatchQueue(label: "didChangeReceivingQueue")
        )
        
        let expectation = XCTestExpectation(description: "ViewModel should have row model")
        let subscription = viewModel.didChange.sink { _ in
            expectation.fulfill()
        }
        
        viewModel.reloadData()
        
        XCTAssertEqual(XCTWaiter().wait(for: [expectation], timeout: 0.1), .completed)
        XCTAssertEqual(viewModel.rowModels, [PostRowModel(with: postDTO)])
        
        subscription.cancel()
    }
}


let postDTO = PostDTO(id: 1, title: "Title")
