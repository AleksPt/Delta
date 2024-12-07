//
//  GroupCapsuleView.swift
//  Delta
//
//  Created by Vladimir Dmitriev on 26.09.24.
//

import SwiftUI
import UISystem

struct GroupCapsuleView: View {
    let group: GroupOfAccounts
    
    var body: some View {
        VStack(alignment: .trailing) {
            HStack {
                Image(systemName: group.image)
                    .font(.bodyText2())
                
                Text(group.title)
                    .font(.subheading1())
            }
            .foregroundStyle(group.color == AppGradient.appBlack.name ? .appWhite : .black)
        }
        .padding()
        .frame(height: 60)
        .background(AppGradient.getColor(from: group.color)?.value)
        .clipShape(Capsule())
    }
}

#Preview {
    let group = DataStore.shared.groupsOfAccounts.first!
    return GroupCapsuleView(group: group)
}


