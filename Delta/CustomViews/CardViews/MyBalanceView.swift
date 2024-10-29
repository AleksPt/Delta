//
//  MyBalanceView.swift
//  Delta
//
//  Created by Vladimir Dmitriev on 20.07.24.
//

import SwiftUI
import UISystem

struct MyBalanceView: View {
    let totalBalance: Double
    let myBalance: Double
    let currency: Currency
    let image: String
    
    @State private var isSelected: Bool = true
    @Namespace private var animation
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                HStack(spacing: 12) {
                    Button(action: {
                        isSelected = true
                    }) {
                        Text("Total balance")
                            .foregroundStyle(isSelected ? .appBlack : .gray)
                    }
                    Button(action: {
                        isSelected = false
                    }) {
                        Text("My balance")
                            .foregroundStyle(!isSelected ? .appBlack : .gray)
                    }
                }
                .font(.metadata3())
                
                Spacer(minLength: 0)
                
                Text(
                    isSelected
                    ? totalBalance.formattedAmount(for: currency)
                    : myBalance.formattedAmount(for: currency)
                )
                    .font(.heading1())
            }
            .animation(.default, value: isSelected)
            
            Spacer()
            
            Image(image)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .clipShape(.circle)
        }
        .padding()
        .componentBackground(
            color: AppGradient.appBackgroundMini.name,
            size: CGSize(width: Constants.widthFive, height: Constants.heightOne)
        )
    }
}

#Preview {
    MyBalanceView(
        totalBalance: 1234843,
        myBalance: 24353,
        currency: .gel,
        image: "person"
    )
}
