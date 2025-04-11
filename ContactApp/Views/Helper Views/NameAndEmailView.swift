//
//  PhoneAndAdressView.swift
//  ContactApp
//
//  Created by Ola Loevholm on 12/04/2025.
//

import SwiftUI

struct NameAndEmailView: View {
    let contact: Contact
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text(contact.fullName)
                .font(.headline)
                .foregroundStyle(.primary)
            
            Text(contact.email)
                .font(.subheadline)
                .foregroundStyle(.secondary)
        }
    }
}

#Preview {
    NameAndEmailView(contact: .init(
        firstName: "John", lastName: "Doe",
        email: "john.doe@example.com",
        phoneNumer: "123-123-7890",
        address: "123 Main St, Anytown, USA",
        avatar: nil
    )
    )
}
