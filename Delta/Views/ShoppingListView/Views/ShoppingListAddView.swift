//
//  ShoppingListAddView.swift
//  Delta
//
//  Created by Vladimir Dmitriev on 19.09.24.
//

import SwiftUI

struct ShoppingListAddView: View {
    @State private var text: String = ""
    @Bindable var category: ShoppingListCategory
    
    var body: some View {
        HStack {
            Image(systemName: "plus.circle.fill")
                .font(.title2)
                .foregroundColor(.black)
            TextField("Add", text: $text)
                .onSubmit {
                    guard !text.isEmpty else { return }
                    withAnimation {
                        let newItem = ShoppingListItem(name: text)
                        category.items.append(newItem)
                        text = ""
                    }
                }
        }
    }
}

#Preview {
    @Previewable var category = ShoppingListCategory(
        name: "home",
        items: [ShoppingListItem(name: "Table", isCompleted: false)]
    )
    
    return ShoppingListAddView(category: category)
}
