//
//  CircularProgressView.swift
//  Delta
//
//  Created by Tatiana Lazarenko on 9/4/24.
//

import SwiftUI

struct CircularProgressView: View {
    var progress: CGFloat
    
    var body: some View {
        ZStack {
            Circle()
                .stroke(lineWidth: 4)
                .foregroundStyle(.gray.opacity(0.3))
            
            Circle()
                .trim(from: 0, to: progress)
                .stroke(style: StrokeStyle(lineWidth: 4, lineCap: .round))
                .foregroundStyle(.appBlack)
                .rotationEffect(.degrees(-90))
            
            
            Text(String(format: "%.0f%%", progress * 100))
                .font(.metadata2())
                .foregroundStyle(.textGray)
            
        }
        .frame(width: 38, height: 38)
    }
}

#Preview {
    CircularProgressView(progress: 0.80)
}
