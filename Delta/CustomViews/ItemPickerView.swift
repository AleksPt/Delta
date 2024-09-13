//
//  ItemPickerView.swift
//  Delta
//
//  Created by Tatiana Lazarenko on 9/13/24.
//

import SwiftUI
import UISystem

struct ItemPickerView<T: Hashable>: View {
    @Binding var selectedItem: T
    let items: [T]
    let title: String
    let size: CGSize
    
    var body: some View {
        HStack {
            if let items = items as? [GroupOfAccounts] {
                Picker(title, selection: $selectedItem) {
                    ForEach(items) { item in
                        Text(item.title).tag(item)
                    }
                }
                .pickerStyle(.menu)
                .accentColor(.appBlack)
                .padding(.leading, 4)
            }
            
            if let items = items as? [Person] {
                Picker(title, selection: $selectedItem) {
                    ForEach(items) { item in
                        Text(item.name).tag(item)
                    }
                }
                .pickerStyle(.menu)
                .accentColor(.appBlack)
                .padding(.leading, 4)
            }
            
            Spacer()
        }
        .componentBackground(
            color: AppGradient.appBackgroundMini.name,
            size: CGSize(width: size.width, height: size.height)
        )
    }
}

#Preview {
    ItemPickerView(
        selectedItem: .constant(DataStore.shared.groupsOfAccounts.first),
        items: DataStore.shared.groupsOfAccounts,
        title: "Users",
        size: CGSize(width: Constants.largeAccountCardWidth, height: Constants.largeAccountCardHeight)
    )
}
