//
//  ScrollTagsView.swift
//  Delta
//
//  Created by Vladimir Dmitriev on 13.10.24.
//

import SwiftUI

struct ScrollTagsView: View {
    var tags: [String]
    @Binding var shoppingListModel: ShoppingListModel
    
    var body: some View {
        ForEach(tags, id: \.self) { tag in
            Button(action: {
                shoppingListModel.text = tag
                if let category = shoppingListModel.activeCategory {
                    shoppingListModel.addItem(for: category)
                }
                shoppingListModel.saveTags()
                hideKeyboard()
            }) {
                Text(tag)
                    .font(.metadata3())
                    .padding(.horizontal, 10)
                    .padding(.vertical, 5)
                    .foregroundColor(.appWhite)
                    .background(Capsule().fill(Color.appBlack))
            }
        }
    }
}

#Preview {
    @Previewable var shoppingListModel = ShoppingListModel()
    ScrollTagsView(tags: [], shoppingListModel: .constant(shoppingListModel))
}
