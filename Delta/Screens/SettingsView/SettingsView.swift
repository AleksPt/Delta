//
//  SettingsView.swift
//  Delta
//
//  Created by Vladimir Dmitriev on 20.07.24.
//

import SwiftUI

struct SettingsView: View {
    @Environment(LanguageManager.self) private var languageManager
    @State private var selectedLanguage = LocaleIdentifier.en
    
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
                    Text("Draco Malfoy")
                        .font(.system(size: 24))
                        .fontWeight(.bold)
                }
            }
            .listRowBackground(Color.clear)
            .listRowSeparator(.hidden)
            Section {
                NavigationLink("My profile") {
                    EmptyView()
                }
                NavigationLink("PRO - account") {
                    EmptyView()
                }
                NavigationLink("Users") {
                    EmptyView()
                }
            }
            Section {
                Picker("Language", selection: $selectedLanguage) {
                    Text("English").tag(LocaleIdentifier.en)
                    Text("Russian").tag(LocaleIdentifier.ru)
                }
                .onChange(of: selectedLanguage) { _, newValue in
                    languageManager.changeLanguage(to: newValue)
                }
                Picker("Main currency", selection: $selectedLanguage) {
                    Text("Chocolate").tag(LocaleIdentifier.en)
                    Text("Vanilla").tag(LocaleIdentifier.en)
                    Text("Strawberry").tag(LocaleIdentifier.en)
                }
                Picker("Budget period", selection: $selectedLanguage) {
                    Text("Chocolate").tag(LocaleIdentifier.en)
                    Text("Vanilla").tag(LocaleIdentifier.en)
                    Text("Strawberry").tag(LocaleIdentifier.en)
                }
                DatePicker(
                    "Start of period",
                    selection: .constant(.now),
                    displayedComponents: .date
                )
                NavigationLink("Design") {
                    EmptyView()
                }
                Toggle("Notifications", isOn: .constant(true))
            }
            Section("Security") {
                Toggle("Code", isOn: .constant(true))
                Toggle("Face ID", isOn: .constant(true))
                Toggle("Allow widgets", isOn: .constant(true))
            }
            Section("Data") {
                HStack {
                    Text("Synchronization")
                    Spacer()
                    Button("Button") {
                        
                    }
                }
                HStack {
                    Text("Removing")
                    Spacer()
                    Button("Button") {
                        
                    }
                }
                HStack {
                    Text("Delete demo data")
                    Spacer()
                    Button("Button") {
                        
                    }
                }
            }
            Section {
                NavigationLink("Оценить в App Store") {
                    EmptyView()
                }
                NavigationLink("Поделиться с друзьями") {
                    EmptyView()
                }
                NavigationLink("Помощь") {
                    EmptyView()
                }
                NavigationLink("О приложении") {
                    EmptyView()
                }
            }
            Section {
                HStack {
                    Text("Экспорт")
                    Spacer()
                    Button("Button") {
                        
                    }
                }
                HStack {
                    Text("Создание копии")
                    Spacer()
                    Button("Button") {
                        
                    }
                }
                HStack {
                    Text("Восстановить из копии")
                    Spacer()
                    Button("Button") {
                        
                    }
                }
                NavigationLink("Теги") {
                    EmptyView()
                }
            }
        }
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button("Save") {
                    
                }
            }
        }
        
//        Button("Switch language") {
//            if languageManager.locale.identifier == "ru_RU" {
//                languageManager.changeLanguage(to: "en_US")
//            } else {
//                languageManager.changeLanguage(to: "ru_RU")
//            }
//        }
//        .buttonStyle(.borderedProminent)
    }
}

#Preview {
    SettingsView()
        .environment(LanguageManager())
}
