//
//  ItemPickerView.swift
//  Delta
//
//  Created by Tatiana Lazarenko on 9/13/24.
//

import SwiftUI
import UISystem

struct GroupPickerView: View {
    @Binding var selectedGroup: String
    let groups: [GroupOfAccounts]
    let size: CGSize
    
    var body: some View {
        HStack {
            Picker("", selection: $selectedGroup) {
                Text("No group").tag("")
                ForEach(groups) { group in
                    Text(LocalizedStringKey(group.title)).tag(group.title)
                }
            }
            .labelsHidden()
            .pickerStyle(.menu)
            .accentColor(.appBlack)
            .padding(.horizontal, 4)
            
            Spacer()
        }
        .frame(width: size.width, height: size.height)
        .background(AppGradient.appBackgroundMini.value)
        .cornerRadius(16)
    }
}

struct PersonPickerView: View {
    @Binding var selectedPerson: Person
    let persons: [Person]
    let size: CGSize
    
    var body: some View {
        HStack {
            Picker("", selection: $selectedPerson) {
                ForEach(persons) { person in
                    Text(LocalizedStringKey(person.name)).tag(person)
                }
            }
            .padding(.horizontal, 4)
            .labelsHidden()
            .pickerStyle(.menu)
            .accentColor(.appBlack)
            
            Spacer()
        }
        .frame(width: size.width, height: size.height)
        .background(AppGradient.appBackgroundMini.value)
        .cornerRadius(16)
    }
}

#Preview {
    GroupPickerView(
        selectedGroup: .constant(DataStore.shared.groupsOfAccounts.first!.title),
        groups: DataStore.shared.groupsOfAccounts,
        size: CGSize(width: Constants.widthThree, height: Constants.heightSix)
    )
}
