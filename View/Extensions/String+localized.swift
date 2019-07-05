//
//  String+localized.swift
//  View
//
//  Created by Maciek on 04/07/2019.
//  Copyright © 2019 mczarnik.com. All rights reserved.
//

extension String {
    func localized(comment: String) -> String {
        NSLocalizedString(
            self,
            bundle: Bundle.current,
            value: self,
            comment: comment
        )
    }
    
    func localizedAsFormat(comment: String, _ arguments: CVarArg) -> String {
        let localizedFormat = self.localized(comment: comment)
        
        return .localizedStringWithFormat(localizedFormat, arguments)
    }
}
