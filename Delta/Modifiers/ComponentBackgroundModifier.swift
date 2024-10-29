//
//  ComponentBackgroundModifier.swift
//  Delta
//
//  Created by Vladimir Dmitriev on 27.08.24.
//

import SwiftUI
import UISystem

struct ComponentBackgroundModifier: ViewModifier {
    let color: AppGradient
    let size: CGSize
    
    init(color: String, size: CGSize) {
        self.color = AppGradient.getColor(from: color) ?? .appWhite
        self.size = size
    }
    
    func body(content: Content) -> some View {
        content
            .frame(width: size.width, height: size.height)
            .background(color.value)
            .cornerRadius(16)
    }
}

extension View {
    func componentBackground(
        color: String,
        size: CGSize
    ) -> some View {
        modifier(ComponentBackgroundModifier(color: color, size: size))
    }
}
