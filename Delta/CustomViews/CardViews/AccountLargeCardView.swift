//
//  AccountLargeCardView.swift
//  Delta
//
//  Created by Tatiana Lazarenko on 9/11/24.
//

import SwiftUI
import UISystem

struct AccountLargeCardView: View {
    @Environment(\.colorScheme) private var colorScheme
    
    let title: String
    let currency: Currency
    let amount: String
    let image: String
    let color: String
    let size: CGSize
    
    var body: some View {
        VStack(alignment: .trailing) {
            HStack {
                VStack(alignment: .leading) {
                    Text(title)
                        .font(.heading2())
                        .padding(.bottom, 2)
                    
                    Text(Double(amount)?.formattedAmount(for: currency) ?? "1000")
                        .font(.subheading2())
                }
                .foregroundStyle(color == AppGradient.appBlack.name ? .appWhite : .black)
                
                Spacer(minLength: 0)
            }
            Spacer(minLength: 0)
            
            Image(systemName: image)
                .font(.heading2())
                .foregroundStyle(color == AppGradient.appBlack.name ? .appWhite : .black)
        }
        .padding()
        .frame(width: size.width, height: size.height)
        .background(AppGradient.getColor(from: color)?.value)
        .cornerRadius(24)
        .shadow(color: colorScheme == .light ? Color.gray.opacity(0.4) : Color.black.opacity(0.4), radius: 6, x: 2, y: 4)
    }
}

#Preview {
    AccountLargeCardView(
        title: "title",
        currency: .rub,
        amount: "15533",
        image: "creditcard",
        color: "appRed",
        size: CGSize(width: Constants.widthThree, height: Constants.heightSix)
    )
}
