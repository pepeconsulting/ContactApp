//
//  ContactAppApp.swift
//  ContactApp
//
//  Created by Ola Loevholm on 11/04/2025.
//

import SwiftUI

@main
struct ContactAppApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .modelContainer(for: Contact.self)
        }
    }
}
