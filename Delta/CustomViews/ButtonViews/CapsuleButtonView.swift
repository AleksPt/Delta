//
//  CapsuleButtonView.swift
//  Delta
//
//  Created by Vladimir Dmitriev on 30.08.24.
//

import SwiftUI

struct CapsuleButtonView: View {
    let categoryType: CategoryType
    let animation: Namespace.ID
    @Binding var activeTab: CategoryType
    
    var body: some View {
        Button(action: {
            withAnimation(.snappy) {
                activeTab = categoryType
            }
        }) {
            Text(categoryType.rawValue)
                .font(.metadata3())
                .padding()
                .frame(height: 32)
                .foregroundStyle(activeTab == categoryType ? .appWhite : .appBlack)
                .background(
                    ZStack {
                        if activeTab == categoryType {
                            Capsule()
                                .fill(Color.appBlack)
                                .matchedGeometryEffect(id: "background", in: animation)
                        } else {
                            Capsule()
                                .fill(Color.appWhite)
                        }
                    }
                )
        }
        .buttonStyle(.plain)
    }
}

#Preview {
    struct CapsuleButtonPreview: View {
        @State var activeTab = CategoryType.expense
        @Namespace private var animation
        
        var body: some View {
            CapsuleButtonView(categoryType: .expense, animation: animation, activeTab: $activeTab)
        }
    }
    
    return CapsuleButtonPreview()
}
