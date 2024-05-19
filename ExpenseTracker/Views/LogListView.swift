//
//  LogListView.swift
//  ExpenseTracker
//
//  Created by Kartikay Singh on 18/05/24.
//

import SwiftUI
import FirebaseFirestore

struct LogListView: View {
    
    @Binding var vm: LogListVM
    @FirestoreQuery(collectionPath: "logs",
                    predicates: [.order(by: SortType.date.rawValue, descending: true)])
    private var logs: [ExpenseLog]
    
    
    var body: some View {
        listView
            .sheet(item: $vm.logToEdit, onDismiss: { vm.logToEdit = nil}) { log in
                LogFormV(vm: FormVM(logToEdit: log))
            }
            .overlay {
                if logs.isEmpty {
                    Text("No expense data\nPlease add your expenses using the add button")
                        .multilineTextAlignment(.center)
                        .font(.headline)
                        .padding(.horizontal)
                }
            }
            .onChange(of: vm.sortType) { updateFirestoreQuery() }
            .onChange(of: vm.sortOrder) { updateFirestoreQuery() }
            .onChange(of: vm.selectedCategories) { updateFirestoreQuery() }
    }
    
    var listView: some View {
        #if os(iOS)
        List {
            ForEach(logs) { log in
                LogItemView(log: log)
                    .contentShape(Rectangle())
                    .onTapGesture {
                        vm.logToEdit = log
                    }
                    .padding(.vertical, 4)
            }
            .onDelete(perform: self.onDelete)
        }
        .listStyle(.plain)
        #else
        
        ZStack {
            ScrollView {
                ForEach(logs) { log in
                    VStack {
                        LogItemView(log: log)
                        Divider()
                    }
                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                    .contentShape(Rectangle())
                    .padding(.horizontal)
                    .contextMenu{
                        Button("Edit") {self.vm.logToEdit = log}
                        Button("Delete") { self.vm.db.delete(log: log)}
                    }
                }
            }
            .contentMargins(.vertical, 8, for: .scrollContent)
            
        }
        
        #endif
    }
    
    func updateFirestoreQuery() {
        $logs.predicates = vm.predicates
    }
    
    private func onDelete(with indexSet: IndexSet) {
        indexSet.forEach { index in
            let log = logs[index]
            vm.db.delete(log: log)
        }
    }
}

#Preview {
    @State var vm = LogListVM()
    
    return LogListView(vm: $vm)
    #if os(macOS)
        .frame(width: 700)
    #endif
}
