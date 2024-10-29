//
//  ShoppingListAmountRowView.swift
//  Delta
//
//  Created by Vladimir Dmitriev on 27.09.24.
//

import SwiftUI

struct ShoppingListAmountRowView: View {
    @Bindable var category: ShoppingListCategory
    
    var body: some View {
        HStack {
            Text("Amount for \(category.name)")
                .lineLimit(1)
                .layoutPriority(1)
            Spacer()
            TextField("0 p.", text: $category.amount)
                .multilineTextAlignment(.trailing)
                .keyboardType(.decimalPad)
        }
    }
}

//#Preview {
//    ShoppingListAmountRowView(category: )
//}
