//
//  AvatarView.swift
//  ContactApp
//
//  Created by Ola Loevholm on 12/04/2025.
//

import SwiftUI

struct AvatarView: View {
    let avatarImage : Image?
    let name: String
    var body: some View {
        if let avatarImage {
            avatarImage
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
                    Text(name.prefix(1).uppercased())
                        .font(.largeTitle)
                        .foregroundStyle(.blue)
                        .bold()
                }.padding(.trailing, 10)

        }
    }
}

