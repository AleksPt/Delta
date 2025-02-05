//
//  ShoppingListItemView.swift
//  Delta
//
//  Created by Vladimir Dmitriev on 19.09.24.
//

import SwiftUI

struct ShoppingListItemView: View {
    @Bindable var item: ShoppingListItem
    
    var body: some View {
        HStack {
            Image(systemName: item.isCompleted ? "checkmark.circle.fill" : "circle")
                .font(.title2)
                .contentShape(.rect)
                .foregroundStyle(.appBlack)
                .simultaneousGesture(
                    TapGesture().onEnded { complete() }
                )
            TextField(item.name, text: $item.name)
        }
    }
    
    func complete() {
        withAnimation {
            item.isCompleted.toggle()
        }
    }
}

#Preview {
    @Previewable var item = ShoppingListItem(name: "Bread", isCompleted: false)
    return ShoppingListItemView(item: item)
}
