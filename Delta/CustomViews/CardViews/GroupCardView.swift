//
//  GroupCardView.swift
//  Delta
//
//  Created by Vladimir Dmitriev on 04.10.24.
//

import SwiftUI
import UISystem

struct GroupCardView: View {
    let group: GroupOfAccounts
    let size: CGSize
    
    var backgroundColor: LinearGradient {
        AppGradient.getColor(from: group.color)?.value ?? AppGradient.appWhite.value
    }
    
    var body: some View {
        ZStack{
            backgroundColor.brightness(-0.1)
                .frame(width: Constants.widthTwo - 32, height: Constants.heightThree)
                .cornerRadius(16)
                .offset(y: -8)
            
            backgroundColor.brightness(-0.07)
                .frame(width: Constants.widthTwo - 16, height: Constants.heightThree)
                .cornerRadius(16)
                .offset(y: -4)
            
            VStack(alignment: .trailing) {
                HStack {
                    VStack(alignment: .leading) {
                        Text(group.title)
                            .font(.subheading1())
                        Spacer(minLength: 0)
                        
                        Text(group.amount.formattedAmount(for: group.currency))
                            .font(.metadata3())
                    }
                    Spacer(minLength: 0)
                }
                Spacer(minLength: 0)
                
                Image(systemName: group.image)
                    .font(.bodyText2())
            }
            .foregroundStyle(group.color == AppGradient.appBlack.name ? .appWhite : .black)
            .padding()
            .componentBackground(
                color: group.color,
                size: CGSize(width: size.width, height: size.height)
            )
        }
    }
}

#Preview {
    let group = DataStore.shared.groupsOfAccounts.first!
    return GroupCardView(
        group: group,
        size: CGSize(width: Constants.widthTwo, height: Constants.heightThree)
    )
}
