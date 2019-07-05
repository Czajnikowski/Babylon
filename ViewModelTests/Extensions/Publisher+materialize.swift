//
//  Publisher+materialize.swift
//  ViewModelTests
//
//  Created by Maciek on 05/07/2019.
//  Copyright © 2019 mczarnik.com. All rights reserved.
//

import Combine
import XCTest

extension Publisher {
    func materializeOutput(triggeredBy trigger: () -> Void) -> Output? {
        let semaphore = DispatchSemaphore(value: 0)
        var output: Output?
        
        let subscription = self.sink(
            receiveCompletion: { _ in
                semaphore.signal()
            },
            receiveValue: {
                output = $0
                semaphore.signal()
            }
        )
        
        trigger()
        semaphore.wait()
        
        subscription.cancel()
        
        return output
    }

}
