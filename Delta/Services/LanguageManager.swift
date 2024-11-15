//
//  LanguageManager.swift
//  Delta
//
//  Created by Алексей on 03.11.2024.
//

import Foundation

@Observable
final class LanguageManager {
    private(set) var locale: Locale = .current
    
    func changeLanguage(to languageCode: String) {
        locale = Locale(identifier: languageCode)
    }
}
