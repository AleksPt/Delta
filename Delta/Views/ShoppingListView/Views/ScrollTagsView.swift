//
//  ScrollTagsView.swift
//  Delta
//
//  Created by Vladimir Dmitriev on 13.10.24.
//

import SwiftUI

struct ScrollTagsView: View {
    @Environment(CategoryService.self) private var categoryService
    
    var tags: [Tag]
    
    @Binding var text: String
    @Binding var activeCategory: Expense?
    
    var body: some View {
        ForEach(tags, id: \.self) { tag in
            Button(action: {
                text = tag.name
                if let category = activeCategory {
                    categoryService.addItem(for: category, text: text)
                }
                categoryService.saveTags(text: text)
                text = ""
                hideKeyboard()
            }) {
                Text(tag.name)
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
    ScrollTagsView(tags: [], text: .constant(""), activeCategory: .constant(nil))
        .environment(CategoryService())
}
