//
//  Publisher+Babylon.swift
//  ViewModel
//
//  Created by Maciek on 08/07/2019.
//  Copyright © 2019 mczarnik.com. All rights reserved.
//

import Combine

extension Publisher where Output == Data, Failure == URLError {
    func transform<Output>(to type: Output.Type, on dispatchQueue: DispatchQueue) -> AnyPublisher<Output, BabylonError>
        where Output: Decodable {
            
            self
                .mapError { $0.toBabylonError(.networking) }
                .decode(type: type, decoder: JSONDecoder())
                .mapError { $0.toBabylonError(.parsing) }
                .receive(on: dispatchQueue)
                .eraseToAnyPublisher()
    }
}
