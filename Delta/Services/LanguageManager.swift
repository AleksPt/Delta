//
//  LanguageManager.swift
//  Delta
//
//  Created by Алексей on 03.11.2024.
//

import Foundation

enum LocaleIdentifier: String {
    case ru = "ru_RU"
    case en = "en_US"
}

@Observable
final class LanguageManager {
    private(set) var locale: Locale = .current
    
    func changeLanguage(to languageCode: LocaleIdentifier) {
        locale = Locale(identifier: languageCode.rawValue)
    }
}
