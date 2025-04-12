//
//  Contact.swift
//  ContactApp
//
//  Created by Ola Loevholm on 11/04/2025.
//

import Foundation
import SwiftData

@Model
class Contact: Identifiable {
    // required fields
    var firstName : String
    var lastName : String
    var email : String
    
    // Optional fields
    var phoneNumber : String = ""
    var address: String = ""
    
    // Optional Image
    @Attribute(.externalStorage)
    var avatar: Data?
    
    // Full name
    var fullName: String {
        "\(firstName) \(lastName)"
    }
    
    // Check if all input strings are empty
    func isEmpty() -> Bool {
        firstName.isEmpty &&
        lastName.isEmpty &&
        email.isEmpty &&
        phoneNumber.isEmpty &&
        address.isEmpty
    }
    
    init(firstName: String = "",
         lastName: String = "",
         email: String = "",
         phoneNumber: String = "",
         address: String = "",
         avatar: Data? = nil)
    {
        self.firstName = firstName
        self.lastName = lastName
        self.email = email
        self.phoneNumber = phoneNumber
        self.address = address
        self.avatar = avatar
    }
    
}
