//
//  LogListContainerV.swift
//  ExpenseTracker
//
//  Created by Kartikay Singh on 18/05/24.
//

import SwiftUI

struct LogListContainerV: View {
    @Binding var vm: LogListVM
    
    var body: some View {
        VStack(spacing: 0) {
            FilterCategoriesV(selectedCategories: $vm.selectedCategories)
            Divider()
            SelectSortOrderV(sortType: $vm.sortType, sortOrder: $vm.sortOrder)
            Divider()
            LogListView(vm: $vm)
        }
        .sheet(isPresented: $vm.isLogFormPresented) {
            LogFormV(vm: .init())
        }
        .toolbar {
            ToolbarItem {
                Button {
                    vm.isLogFormPresented = true
                } label: {
                    #if os(macOS)
                    HStack {
                        Image(systemName: "plus")
                            .symbolRenderingMode(.monochrome)
                            .tint(.accentColor)
                        Text("Add Expense Log")
                    }
                    #else
                    Text("Add")
                    #endif
                }
            }
        }
        #if !os(macOS)
        .navigationBarTitle("Expense Tracker", displayMode: .inline)
        #endif
    }
}

#Preview {
    @State var vm = LogListVM()
    return NavigationStack {
        LogListContainerV(vm: $vm)
    }
}
