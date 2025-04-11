//
//  AvatarView.swift
//  ContactApp
//
//  Created by Ola Loevholm on 12/04/2025.
//

import SwiftUI

struct AvatarContactView : View {
    let contact: Contact
    var body: some View {
        if let avatarData = contact.avatar, let
            uiImage = UIImage(data: avatarData) {
            Image(uiImage: uiImage)
                .resizable()
                .scaledToFit()
                .frame(width: 50, height: 50)
                .clipShape(Circle())
                .overlay {
                    Circle().stroke( .gray, lineWidth: 1)
                }
        } else {
            Circle()
                .fill(.blue.opacity(0.2))
                .frame(width: 50, height: 50)
                .overlay {
                    Text(contact.fullName.prefix(1).uppercased())
                        .font(.largeTitle)
                        .foregroundStyle(.blue)
                        .bold()
                }.padding(.trailing, 10)

        }
    }
}

#Preview {
    AvatarContactView(contact: .init(
        firstName: "John", lastName: "Doe",
        email: "john.doe@example.com",
        phoneNumer: "123-123-7890",
        address: "123 Main St, Anytown, USA",
        avatar: nil
    )
   )
}
