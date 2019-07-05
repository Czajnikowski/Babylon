//
//  SwiftUI+Convenience.swift
//  View
//
//  Created by Maciek on 03/07/2019.
//  Copyright © 2019 mczarnik.com. All rights reserved.
//

import SwiftUI

extension Alert {
    static func errorAlert(withLocalizedMessage localizedMessage: String?) -> Alert {
        Alert(
            title: Text(
                "Error"
                    .localized(comment: "Alert title")
            ),
            message: Text(
                localizedMessage ?? "Unknown error".localized(comment: "Alert message")
            )
        )
    }
}
