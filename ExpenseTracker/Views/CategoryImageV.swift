//
//  CategoryImageV.swift
//  ExpenseTracker
//
//  Created by Kartikay Singh on 18/05/24.
//

import SwiftUI

struct CategoryImageV: View {
    
    let category: Category
    var body: some View {
        Image(systemName: category.systemNameIcon)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: 20, height: 20)
            .padding()
            .foregroundStyle(category.color)
            .background(category.color.opacity(0.1))
            .clipShape(.circle)
    }
}

#Preview {
    CategoryImageV(category: .utilities)
}
