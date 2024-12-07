//
//  RepeatingType.swift
//  Delta
//
//  Created by Vladimir Dmitriev on 21.11.24.
//

enum RepeatingType: String, CaseIterable, Identifiable, Codable {
    case random = "Random"
    case certain = "Certain"
    
    var id: String { self.rawValue }
}
