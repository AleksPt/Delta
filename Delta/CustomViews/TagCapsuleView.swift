//
//  TagCapsuleView.swift
//  Delta
//
//  Created by Tatiana Lazarenko on 11/1/24.
//

import SwiftUI
import UISystem

struct TagCapsuleView: View {
    let tag: Tag
    let isSelected: Bool
    let onSelect: () -> Void
    
    var body: some View {
        VStack(alignment: .center) {
            HStack {
                Text(tag.name)
                    .font(.subheading1())
                
                Image(systemName: isSelected ? "checkmark.circle.fill" : "circle")
                    .font(.title2)
                    .contentShape(.rect)
            }
            .foregroundStyle(AppGradient.appWhite.value)
        }
        .padding()
        .frame(height: 40)
        .background(AppGradient.appBlack.value)
        .clipShape(Capsule())
        .simultaneousGesture(
            TapGesture().onEnded {
                withAnimation(.interactiveSpring) {
                    onSelect()
                }
            }
        )
    }
}

#Preview {
    TagCapsuleView(tag: CategoryService().tags.first!, isSelected: true, onSelect: {})
}
