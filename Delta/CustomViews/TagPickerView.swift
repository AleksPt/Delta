//
//  TagPickerView.swift
//  Delta
//
//  Created by Tatiana Lazarenko on 11/1/24.
//

import SwiftUI
import UISystem

struct TagPickerView: View {
    @Environment(CategoryService.self) private var categoryService
    @Binding var selectedTags: [Tag]
    
    var body: some View {
        ScrollViewReader { proxy in
            VStack(alignment: .leading) {
                Label("Tags", systemImage: "tag.fill")
                    .foregroundStyle(AppGradient.appBlack.value)
                    .safeAreaPadding(.horizontal)
                    .labelStyle(CustomLabel(spacing: 4))
                
                ScrollView(.horizontal) {
                    HStack(spacing: 10) {
                        ForEach(categoryService.tags) { tag in
                            TagCapsuleView(
                                tag: tag,
                                isSelected: selectedTags.contains(where: { $0.id == tag.id })
                            ) {
                                if selectedTags.contains(where: { $0.id == tag.id }) {
                                    selectedTags.removeAll(where: { $0.id == tag.id })
                                } else {
                                    selectedTags.append(tag)
                                }
                            }
                            .id(tag.id)
                        }
                    }
                }
                .scrollIndicators(.hidden)
                .safeAreaPadding(.horizontal)
                .padding(.top, -2)
            }
            .frame(height: 92)
            .background(AppGradient.appBackgroundMini.value)
            .cornerRadius(16)
        }
    }
}

#Preview {
    TagPickerView(selectedTags: .constant(CategoryService().tags))
        .environment(CategoryService())
}
