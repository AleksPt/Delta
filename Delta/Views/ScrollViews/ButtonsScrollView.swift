//
//  ButtonsScrollView.swift
//  Delta
//
//  Created by Vladimir Dmitriev on 09.09.24.
//

import SwiftUI

struct ButtonsScrollView: View {
    let categoryTypes: [CategoryType]
    @Binding var activeTab: CategoryType
    @Namespace private var animation

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 16) {
                ForEach(categoryTypes, id: \.self) { categoryType in
                    CapsuleButtonView(categoryType: categoryType, animation: animation, activeTab: $activeTab)
                }
            }
        }
        .shadow()
    }
}

#Preview {
    struct ButtonsScrollViewPreview: View {
        @State var activeTab = CategoryType.expense
        
        var body: some View {
            ButtonsScrollView(categoryTypes: CategoryType.getCategoryTypes(), activeTab: $activeTab)
        }
    }

    return ButtonsScrollViewPreview()
}
