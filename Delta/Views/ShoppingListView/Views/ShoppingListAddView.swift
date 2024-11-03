//
//  ShoppingListAddView.swift
//  Delta
//
//  Created by Vladimir Dmitriev on 19.09.24.
//

import SwiftUI

struct ShoppingListAddView: View {
    @Binding var text: String
    var action: () -> Void
    
    @State private var inputText = ""
    @FocusState private var isFocused: Bool
    
    var body: some View {
        HStack {
            Image(systemName: "plus.circle.fill")
                .font(.title2)
                .foregroundColor(.appBlack)
            TextField("Add", text: $inputText)
                .onSubmit {
                    guard !inputText.isEmpty else { return }
                    withAnimation {
                        text = inputText
                        action()
                        inputText = ""
                    }
                }
                .onChange(of: inputText) { _, newValue in
                    text = newValue
                }
                .focused($isFocused)
                .onChange(of: isFocused) { _, focused in
                    if !focused {
                        inputText = ""
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
    
    ShoppingListAddView(text: .constant(""), action: {})
}
