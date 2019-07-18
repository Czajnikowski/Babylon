//
//  AlertPresentation.swift
//  View
//
//  Created by Maciek on 03/07/2019.
//  Copyright © 2019 mczarnik.com. All rights reserved.
//

import SwiftUI

struct AlertPresentation: ViewModifier {
    private let alertMessageController: AlertMessageControlling
    
    init(with alertMessageController: AlertMessageControlling) {
        self.alertMessageController = alertMessageController
    }
    
    func body(content: Content) -> some View {
        content
            .alert(isPresented: alertMessageController.alertPresentationBinding) {
                .errorAlert(withLocalizedMessage: alertMessageController.localizedAlertMessage)
            }
    }
}

extension View {
    func alertPresentation(using alertMessageController: AlertMessageControlling) -> Self.Modified<AlertPresentation> {
        Modified(
            content: self,
            modifier: AlertPresentation(with: alertMessageController)
        )
    }
}
