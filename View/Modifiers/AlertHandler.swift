//
//  AlertHandler.swift
//  View
//
//  Created by Maciek on 03/07/2019.
//  Copyright © 2019 mczarnik.com. All rights reserved.
//

import SwiftUI

struct AlertHandler: ViewModifier {
    private let alertController: AlertMessageControlling
    
    init(with alertController: AlertMessageControlling) {
        self.alertController = alertController
    }
    
    func body(content: Content) -> some View {
        content
            .presentation(alertController.alertPresentationBinding) {
                .errorAlert(withLocalizedMessage: alertController.localizedAlertMessage)
            }
    }
}

extension View {
    func handleAlert(with alertController: AlertMessageControlling) -> Self.Modified<AlertHandler> {
        Modified(
            content: self,
            modifier: AlertHandler(with: alertController)
        )
    }
}
