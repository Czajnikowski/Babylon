//
//  Publishers+Fail.swift
//  Networking
//
//  Created by Maciek on 18/07/2019.
//  Copyright © 2019 mczarnik.com. All rights reserved.
//

import Combine

extension Publishers {
    struct Fail<Output, Failure>: Publisher where Failure: Error {
        private let failure: Failure
        
        init(outputType: Output.Type, failure: Failure) {
            self.failure = failure
        }

        func receive<S>(subscriber: S) where S: Subscriber, Failure == S.Failure, Output == S.Input {
            subscriber.receive(subscription: Subscriptions.empty)
            DispatchQueue.main.async {
                subscriber.receive(completion: .failure(self.failure))
            }
        }
    }
}
