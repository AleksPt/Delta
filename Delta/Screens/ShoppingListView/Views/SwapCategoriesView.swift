//
//  SwapCategoriesView.swift
//  Delta
//
//  Created by Алексей on 03.11.2024.
//

import Foundation

import SwiftUI

struct SwapCategoriesView: View {
    @Binding var categories: [Expense]
    @State private var editMode: EditMode = .active
    @Environment(\.dismiss) var dismiss

    var body: some View {
        NavigationStack {
            List {
                ForEach(categories, id: \.self) {
                    Text($0.title.capitalized)
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
