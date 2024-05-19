//
//  ListFormVM.swift
//  ExpenseTracker
//
//  Created by Kartikay Singh on 18/05/24.
//

import Foundation
import Observation

@Observable
class FormVM {
    var logToEdit: ExpenseLog?
    
    let db = DatabaseManager.shared
    
    var name = ""
    var amount: Double = 0
    var category = Category.utilities
    var date = Date()
    
    
    var isSaveButtonDisabled: Bool {
        name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
    
    let numberFormatter: NumberFormatter = {
        var formatter = NumberFormatter()
        formatter.isLenient = true
        formatter.numberStyle = .currency
        formatter.minimumFractionDigits = 0
        formatter.currencyCode = "USD"
        return formatter
    }()
    
    init(logToEdit: ExpenseLog? = nil) {
        self.logToEdit = logToEdit
        
        if let logToEdit {
            self.name = logToEdit.name
            self.amount = logToEdit.amount
            self.category = logToEdit.categoryEnum
            self.date = logToEdit.date
            self.numberFormatter.currencyCode = logToEdit.currency
        }
    }
    
    func save() {
        var log: ExpenseLog
        if let logToEdit {
            log = logToEdit
        }
        else {
            log = ExpenseLog(id: UUID().uuidString, name: "", category: "", amount: 0, currency: "USD", date: .now)
        }
        
        log.name = self.name.trimmingCharacters(in: .whitespacesAndNewlines)
        log.amount = amount
        log.category = self.category.rawValue
        log.date = self.date
        
        if self.logToEdit == nil {
            try? db.add(log: log)
        }
        else {
            db.update(log: log)
        }
        
    }
    
    func delete(log: ExpenseLog) {
        db.delete(log: log)
    }
    
}
