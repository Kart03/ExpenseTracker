    //
    //  SelecSortOrderVM.swift
    //  ExpenseTracker
    //
    //  Created by Kartikay Singh on 18/05/24.
    //

import SwiftUI

struct SelectSortOrderV: View {
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    
    @Binding var sortType: SortType
    
    @Binding var sortOrder: SortOrder
    
    private let sortTypes = SortType.allCases
    private let sortOrders = SortOrder.allCases
    
    var body: some View {
        HStack {
#if !os(macOS)
            Text("Sort By")
#endif
            
            Picker(selection: $sortType) {
                ForEach(sortTypes) { type in
                    if horizontalSizeClass == .compact {
                        Image (systemName: type.systemNameIcon)
                            .tag(type)
                    }
                    else {
                        Text(type.rawValue.capitalized)
                            .tag(type)
                    }
                }
            } label: {
                Text("Sort By")
            }
            .pickerStyle(SegmentedPickerStyle())
            
            #if !os(macOS)
            Text("Order By")
            #endif
            
            Picker(selection: $sortOrder) {
                ForEach(sortOrders) { order in
                    if horizontalSizeClass == .compact {
                        Image (systemName: order.systemNameIcon)
                            .tag(order)
                    }
                    else {
                        Text(order.rawValue.capitalized)
                            .tag(order)
                    }
                }
            } label: {
                Text("Order By")
            }
            .pickerStyle(SegmentedPickerStyle())
        }
        .padding()
        .frame(height: 64)
    }
}

#Preview {
    @State var vm = LogListVM()
    
    return SelectSortOrderV(sortType: $vm.sortType, sortOrder: $vm.sortOrder)
}
