//
//  SettingsView.swift
//  Delta
//
//  Created by Vladimir Dmitriev on 20.07.24.
//

import SwiftUI

struct SettingsView: View {
    @Environment(LanguageManager.self) private var languageManager
    
    var body: some View {
        Button("Switch language") {
            if languageManager.locale.identifier == "ru_RU" {
                languageManager.changeLanguage(to: "en_US")
            } else {
                languageManager.changeLanguage(to: "ru_RU")
            }
        }
        .buttonStyle(.borderedProminent)
    }
}

#Preview {
    SettingsView()
        .environment(LanguageManager())
}
