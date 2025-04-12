//
//  ContactListView.swift
//  ContactApp
//
//  Created by Ola Loevholm on 11/04/2025.
//

import SwiftUI
import SwiftData



struct ContactListView: View {
    @Environment(\.modelContext) private var modelContext
    
    // Queries
    // First name
    @Query(
        sort: \Contact.firstName,
        order: .forward
    )
    private var contactsByFirstName: [Contact]
    // Last name
    @Query(
        sort: \Contact.lastName,
        order: .forward
    )
    private var contactsByLastName: [Contact]
    
    // Phone number
    @Query(
        sort: \Contact.phoneNumber,
        order: .forward
    )
    private var contactsByPhoneNumber: [Contact]
    
    
    // State variables
    @State private var searchText: String = ""
    @State private var selectedSortOrder: SortOrder = .firstName
    @State private var isSortOrderInversed: Bool = true
    @State private var isAdvanceShown: Bool = false
    @State private var showMore: Bool = false
    @State private var currentContact: Contact = Contact()
    @State private var isShowingAddContactSheet : Bool = false
    @State private var selectedFilters: Filter = .none
    
    // Sorted contacts
    var sortedContacts: [Contact] {
        let baseContacts: [Contact]
        switch selectedSortOrder {
        case .firstName:
            baseContacts = contactsByFirstName
        case .lastName:
            baseContacts = contactsByLastName
        case .phoneNumber:
            baseContacts = contactsByPhoneNumber
        }
         return isSortOrderInversed ? baseContacts.reversed() :
            baseContacts
    }
    
    // Filter and predicate - Advance queries
    
    @Query(filter: #Predicate<Contact> {
        $0.email.contains("@example.com")
    }) private var contactsWithExampleDomain: [Contact]
    
    @Query(filter: #Predicate<Contact> {
        !$0.phoneNumber.isEmpty
    }) private var contactsWithPhoneNumbers: [Contact]
    
    @Query(filter: #Predicate<Contact> {
        $0.lastName.starts(with: "A")
    }) private var contactsStartingWithA: [Contact]
    
    // Filter contacts
    // TODO: implement filtered contacts
    var filteredContacts: [Contact] {
        let baseContacts: [Contact]
        switch selectedSortOrder {
        case .firstName:
            baseContacts = contactsByFirstName
        case .lastName:
            baseContacts = contactsByLastName
        case .phoneNumber:
            baseContacts = contactsByPhoneNumber
        }
        
        let theFilteredContacts: [Contact]
        switch selectedFilters {
        case .none:
            theFilteredContacts = baseContacts
        case .exampleDomain:
            theFilteredContacts = contactsWithExampleDomain
        case .withPhoneNumber:
            theFilteredContacts = contactsWithPhoneNumbers
        case .startingWithA:
            theFilteredContacts = contactsStartingWithA
        }
        
        if searchText.isEmpty {
            return theFilteredContacts
        } else {
            return theFilteredContacts.filter { contact in
                contact.firstName
                    .localizedCaseInsensitiveContains(searchText) ||
                contact.lastName
                    .localizedCaseInsensitiveContains(searchText) ||
                contact.phoneNumber
                    .localizedCaseInsensitiveContains(searchText) ||
                contact.email
                    .localizedCaseInsensitiveContains(searchText)
            }
        }
        
        
    }
    
    
    var body: some View {
        NavigationStack {
            VStack {
                TextField("Search Contacts", text: $searchText)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                
                SortAndToggleView(
                    selectedSortOrder: $selectedSortOrder,
                    isSortOrderInversed: $isSortOrderInversed
                )
                
                if isAdvanceShown {
                    FilterPickerView(selectedFilter: $selectedFilters)
                }
                
                if filteredContacts.isEmpty {
                    ContentUnavailableView("Enter a new contact",
                    systemImage: "person.crop.circle.badge.xmark")
                } else {
                    List {
                        ForEach(filteredContacts) { contact in
                            ContactRowItemView(contact: contact, showMore: showMore)
                                .onTapGesture {
                                    currentContact = contact
                                    isShowingAddContactSheet.toggle()
                                }
                        }.onDelete { indexSet in
                            indexSet.forEach {index in
                                    modelContext.delete(filteredContacts[index])
                            }
                            
                            do {
                                try modelContext.save()
                            } catch {
                                print("Failed to save context after deletion: \(error)")
                            }
                        }
      
                    }
                }
                
                Spacer()
                
                
            }
            .sheet(isPresented: $isShowingAddContactSheet, content: {
                ContactFormView(contact: $currentContact) {
                    newContact in
                    modelContext.insert(currentContact)
                    try? modelContext.save()
                    
                    isShowingAddContactSheet.toggle()
                }
            })
            .navigationTitle("Contacts")
                .toolbar {
                    ToolbarItem(placement: .topBarLeading) {
                        Button {
                            showMore.toggle()
                        } label : {
                            Label("Advance", systemImage: showMore ? "text.book.closed" : "book")
                        }
                    }
                    ToolbarItemGroup(placement: .topBarTrailing) {
                        Button {
                            isAdvanceShown.toggle()
                            if !isAdvanceShown {
                                selectedSortOrder = .firstName
                                selectedFilters = .none
                            }
                        } label: {
                            Label(
                                "Advanced",
                                systemImage: isAdvanceShown ? "wand.and.stars" : "wand.and.stars.inverse"
                            )
                        }
                        // Add
                        Button {
                            currentContact = Contact()
                            isShowingAddContactSheet.toggle()
                        } label: {
                            Label(
                                "Add contact",
                                systemImage: "plus"
                            )
                            
                        }
                        
                    }
                }
        }
        
    }
}

#Preview {
    ContactListView()
        .modelContainer(for: Contact.self)
}
