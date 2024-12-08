//
//  MyProfileView.swift
//  Delta
//
//  Created by Алексей on 08.12.2024.
//

import SwiftUI

struct MaxTextWidthKey: PreferenceKey {
    static var defaultValue: CGFloat = 0
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = max(value, nextValue())
    }
}

struct MyProfileView: View {
    @State private var maxTextWidth: CGFloat = 0
    @State private var name = ""
    @State private var age = ""
    @State private var phone = ""
    @State private var mail = ""
    @State private var password = ""
    
    var body: some View {
        List {
            Section {
                VStack(alignment: .center) {
                    HStack {
                        Spacer()
                        Image(.person)
                            .clipShape(.circle)
                            .frame(width: 114.86)
                        Spacer()
                    }
                    Spacer()
                    Text("id: 123456789")
                        .font(.system(size: 18))
                        .fontWeight(.bold)
                }
            }
            .listRowBackground(Color.clear)
            .listRowSeparator(.hidden)
            Section {
                HStack {
                    Text("Name")
                    TextField("Malfoy", text: $name)
                }
                HStack {
                    Text("Age")
                    TextField("Value", text: $age)
                }
                HStack {
                    Text("Phone")
                    TextField("+7 (900) 999-99-99", text: $phone)
                }
                HStack {
                    Text("Mail")
                    TextField("d.malfoy@hogwarts.edu", text: $mail)
                }
                HStack {
                    Text("Password")
                    SecureField("******", text: $password)
                }
            }
            Section {
                HStack {
                    Spacer()
                    RoundedButtonView(
                        title: "Logout") {
                            
                        }.frame(width: 100)
                    Spacer()
                }
            }.listRowBackground(Color.clear)
        }
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button("Save") {
                    
                }
            }
        }
    }
}

#Preview {
    MyProfileView()
}
