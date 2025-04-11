//
//  SortAndToggleView.swift
//  ContactApp
//
//  Created by Ola Loevholm on 12/04/2025.
//

import SwiftUI

struct SortAndToggleView: View {
    @Binding var selectedSortOrder: SortOrder
    @Binding var isSortOrderInversed: Bool
    
    var degrees: CGFloat {
        isSortOrderInversed ? 180 : 0
    }
    
    
    var body: some View {
        HStack {
            Picker("Sort by", selection: $selectedSortOrder)
                {
                Text("First Name")
                        .tag(SortOrder.firstName)
                Text("Last Name")
                        .tag(SortOrder.lastName)
                Text("Phone Number")
                        .tag(SortOrder.phoneNumber)
                }
                .pickerStyle(SegmentedPickerStyle())
            
            Image(systemName: "arrowshape.down.fill")
                .foregroundStyle(.blue)
                .rotationEffect(.degrees(degrees))
                .animation(.spring, value: isSortOrderInversed)
                .onTapGesture {
                    isSortOrderInversed.toggle()
                }
        }
        .padding()
    }
}

#Preview {
    SortAndToggleView(
        selectedSortOrder: .constant(.firstName),
        isSortOrderInversed: .constant(true)
    )
}
