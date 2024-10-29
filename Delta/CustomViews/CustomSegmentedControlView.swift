//
//  CustomSegmentedControlView.swift
//  Delta
//
//  Created by Tatiana Lazarenko on 10/3/24.
//

import SwiftUI
import UISystem

struct CustomSegmentedControlView: View {
    @Binding var selection: RepeatingType
    
    var body: some View {
        HStack(spacing: 0) {
            ForEach(RepeatingType.allCases) { type in
                ZStack {
                    Rectangle()
                        .fill(AppGradient.appBackgroundMini.value)
                    
                    Rectangle()
                        .fill(AppGradient.appBlack.value)
                        .cornerRadius(12)
                        .padding(2)
                        .opacity(selection == type ? 1 : 0.01)
                        .onTapGesture {
                            withAnimation(.snappy) {
                                selection = type
                            }
                        }
                }
                .overlay(
                    Text(type.rawValue)
                        .foregroundStyle(selection == type ? .appWhite : .appBlack)
                )
            }
        }
        .frame(height: 50)
        .cornerRadius(12)
    }
}

#Preview {
    CustomSegmentedControlView(selection: .constant(.certain))
}
