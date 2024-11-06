//
//  ChevronButtonView.swift
//  Delta
//
//  Created by Vladimir Dmitriev on 30.08.24.
//

import SwiftUI

struct ChevronButtonView: View {
    let image: String
    let title: String
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
        Label(title, systemImage: image)
            .font(.bodyText2())
            .labelStyle(IconTrailingLabelStyle())
            .foregroundStyle(.appBlack)
        }
    }
}

struct IconTrailingLabelStyle: LabelStyle {
    func makeBody(configuration: Configuration) -> some View {
        HStack {
            configuration.title
            configuration.icon
        }
    }
}

#Preview {
    ChevronButtonView(image: "chevron.right.circle.fill", title: "See all", action: {})
}
