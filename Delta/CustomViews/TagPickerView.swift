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
    @Environment(Router.self) private var router
    
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
                        ForEach(selectedTags) { tag in
                            showTag(tag: tag)
                        }
                        
                        PlusButtonView {
                            router.presentModal(.tags(tags: $selectedTags))
                        }
                        .frame(width: 40)
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
    
    @ViewBuilder
    private func showTag(tag: Tag) -> some View {
        VStack(alignment: .center) {
            Text(tag.name)
                .font(.subheading1())
                .foregroundStyle(AppGradient.appWhite.value)
        }
        .padding()
        .frame(height: 40)
        .background(AppGradient.appBlack.value)
        .clipShape(Capsule())
    }
}

#Preview {
    TagPickerView(selectedTags: .constant(CategoryService().tags))
        .environment(CategoryService())
        .environment(Router.shared)
}
