//
//  CustomShadowModifier.swift
//  Delta
//
//  Created by Vladimir Dmitriev on 29.08.24.
//

import SwiftUI

struct CustomShadowModifier: ViewModifier {
    @Environment(\.colorScheme) private var colorScheme
    
    func body(content: Content) -> some View {
        switch colorScheme {
        case .light:
            content.shadow(color: Color.gray.opacity(0.2), radius: 16)
        case .dark:
            content.shadow(color: Color.black.opacity(0.4), radius: 12)
        @unknown default:
            content.shadow(color: Color.black.opacity(0.2), radius: 12)
        }
    }
}

extension View {
    func shadow() -> some View {
        modifier(CustomShadowModifier())
    }
}
