//
//  ContactRowItemView.swift
//  ContactApp
//
//  Created by Ola Loevholm on 12/04/2025.
//

import SwiftUI



struct ContactRowItemView: View {
    let contact: Contact
    let showMore: Bool
    
    var showAdressPhoneButton: Bool {
        !contact.phoneNumber.isEmpty || !contact.address.isEmpty
    }
    
    var body: some View {
        VStack(
            alignment: .leading,
            spacing: 8
        ) {
            HStack {
                // Avatar or placeholder
                
                AvatarContactView(contact: contact)
                NameAndEmailView(contact: contact)
                
            }.frame(maxWidth: .infinity, alignment: .leading)
            
            if showMore {
                VStack(alignment: .leading, spacing: 10) {
                    if !contact.phoneNumber.isEmpty {
                        HStack {
                            Image(systemName: "phone.fill")
                                .foregroundStyle(.blue)
                            Text(contact.phoneNumber)
                                .foregroundStyle(.primary)
                        }
                    }
                    
                    if !contact.address.isEmpty {
                        HStack {
                            Image(systemName: "house.fill")
                                .foregroundStyle(.blue)
                                .padding(.top, 2)
                            Text(contact.address)
                                .foregroundStyle(.primary)
                                .lineLimit(3)
                        }
                    }
                    
                    
                }
            }
        }
    }
}

#Preview {
    ContactRowItemView(
        contact: .init(
            firstName: "John", lastName: "Doe",
            email: "john.doe@example.com",
            phoneNumer: "123-123-7890",
            address: "123 Main St, Anytown, USA",
            avatar: nil
        ),
        showMore: true
    )
    .padding()
}
