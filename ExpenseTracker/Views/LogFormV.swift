//
//  LogFormV.swift
//  ExpenseTracker
//
//  Created by Kartikay Singh on 18/05/24.
//

import SwiftUI

struct LogFormV: View {
    @State var vm: FormVM
    @Environment(\.dismiss) var dismiss
    
    #if !os(macOS)
    var title: String {
        (vm.logToEdit == nil ? "Create": "Edit") + " Expense Log"
    }
    
    var body: some View {
        NavigationStack {
            formView
                .toolbar {
                    ToolbarItem(placement: .confirmationAction) {
                        Button("Save") {
                            self.onSave()
                        }
                        .disabled(vm.isSaveButtonDisabled)
                    }
                    
                    ToolbarItem(placement: .cancellationAction) {
                        Button("Cancel") {
                            self.onCancelTapped()
                        }
                    }
                }
                .navigationTitle(title)
                .navigationBarTitleDisplayMode(.inline)
        }
    }
    #else
    var body: some View {
        VStack {
            formView.padding()
            HStack {
                Button("Cancel") {
                    self.onCancelTapped()
                }
                Button ("Save") {
                    self.onSave()
                }
                .buttonStyle(BorderedProminentButtonStyle())
                .disabled(vm.isSaveButtonDisabled)
            }
        }
    }
    
    #endif
    
    
    private var formView: some View {
        Form {
            TextField("Name", text: $vm.name)
                .autocorrectionDisabled()
            TextField("Amount", value: $vm.amount, formatter: vm.numberFormatter)
            #if !os(macOS)
                .keyboardType(.decimalPad)
            #endif
            
            Picker(selection: $vm.category) {
                ForEach(Category.allCases) {
                    category in
                    Text(category.rawValue.capitalized)
                        .tag(category)
                }
            } label: {
                Text("Category")
            }
            
            DatePicker(selection: $vm.date, displayedComponents: [.date, .hourAndMinute]) {
                Text("Date")
            }
        }
    }
    
    private func onCancelTapped() {
        self.dismiss()
    }
    
    private func onSave() {
        #if !os(macOS)
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
        #endif
        vm.save()
        self.dismiss()
    }
}

#Preview {
    LogFormV(vm: .init())
}
