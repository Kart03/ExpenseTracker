//
//  Sort.swift
//  ExpenseTracker
//
//  Created by Kartikay Singh on 18/05/24.
//

import Foundation


enum SortType: String, Identifiable, CaseIterable {
    var id: Self {self}
    
    case date, name, amount
    
    var systemNameIcon: String {
        switch self {
            case .date:
                return "calendar"
            case .name:
                return "a"
            case .amount:
                return "dollarsign.circle"
        }
    }
}

enum SortOrder: String, Identifiable, CaseIterable {
    
    var id: Self {self}
    case ascending, descending
    
    var systemNameIcon: String {
        switch self {
            case .ascending:
                return "arrow.up.circle"
            case .descending:
                return "arrow.down.circle"
        }
    }
}
