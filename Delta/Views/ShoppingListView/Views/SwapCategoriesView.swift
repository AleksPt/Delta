//
//  SwapCategoriesView.swift
//  Delta
//
//  Created by Алексей on 28.10.2024.
//

import SwiftUI

struct SwapCategoriesView: View {
    @Binding var categories: [ShoppingListCategory]
    @State private var editMode: EditMode = .active
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(categories, id: \.self) {
                    Text($0.name.capitalized)
                }
                .onMove(perform: moveSection)
            }
            .toolbar(content: {
                Button("Close") {
                    dismiss()
                }
            })
            .environment(\.editMode, $editMode)
        }
    }
    
    private func moveSection(from source: IndexSet, to destination: Int) {
        categories.move(fromOffsets: source, toOffset: destination)
    }
}

#Preview {
//    SwapCategoriesView()
}
