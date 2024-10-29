//
//  ShowHistoryView.swift
//  Delta
//
//  Created by Tatiana Lazarenko on 9/13/24.
//

import SwiftUI
import UISystem

struct ShowHistoryView: View {
    let title: String
    let buttonTitle: String
    let action: () -> Void
    let size: CGSize
    
    var body: some View {
        HStack {
            Text(title)
            
            Button(action: action, label: {
                Label(buttonTitle, systemImage: "chevron.forward")
                    .labelStyle(CustomLabelStyle())
            })
            .tint(.gray)
            .frame(maxWidth: .infinity, alignment: .trailing)
        }
        .padding()
        .componentBackground(
            color: AppGradient.appBackgroundMini.name,
            size: CGSize(width: size.width, height: size.height)
        )
    }
}

struct CustomLabelStyle: LabelStyle {
    func makeBody(configuration: Configuration) -> some View {
        HStack(alignment: .center, spacing: 8) {
            configuration.title
            configuration.icon
        }
    }
}

#Preview {
    ShowHistoryView(title: "History",
                    buttonTitle: "Show",
                    action: {},
                    size: CGSize(width: Constants.widthFive, height: Constants.heightFive))
}
