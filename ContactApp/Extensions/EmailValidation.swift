//
//  EmailExtension.swift
//  ContactApp
//
//  Created by Ola Loevholm on 12/04/2025.
//

import Foundation

extension String {
    func isValidEmail() -> Bool {
        let regex = try! NSRegularExpression(
            pattern:
                "^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}$",
            options: .caseInsensitive
            )
        
        return regex.firstMatch(
            in: self, options: [], range: NSRange(location: 0, length: count)) != nil
    }
}
