//
//  FilterPickerView.swift
//  ContactApp
//
//  Created by Ola Loevholm on 12/04/2025.
//

import SwiftUI

struct FilterPickerView: View {
    @Binding var selectedFilter: Filter
    var body: some View {
        Picker("Filter by",
               selection: $selectedFilter) {
            Text("Domain")
                .tag(Filter.exampleDomain)
            
            Text("Has Phone Number")
                .tag(Filter.withPhoneNumber)
            
            Text("Starts with 'A'")
                .tag(Filter.startingWithA)
        }.pickerStyle(SegmentedPickerStyle()).padding()
    }
        
}

#Preview {
    FilterPickerView(selectedFilter: .constant(.exampleDomain))
}
