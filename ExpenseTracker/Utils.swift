//
//  Utils.swift
//  ExpenseTracker
//
//  Created by Kartikay Singh on 18/05/24.
//

import Foundation

struct Utils {
    static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM"
        return formatter
    }()
    
    static let amountFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.isLenient = true
        formatter.numberStyle = .currency
        
        return formatter
    }()
    
    
}
