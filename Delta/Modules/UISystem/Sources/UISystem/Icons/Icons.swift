//
//  File.swift
//  
//
//  Created by Tatiana Lazarenko on 9/12/24.
//

import Foundation

public enum Icon: CaseIterable, Hashable {
    case dollar
    case creditcard
    case book
    case bookmark
    case study
    case sport
    case award
    case shopping
    case renovation
    case health
    case accessories
    case travel
    case entertainment
    
    public var name: String {
        switch self {
        case .dollar:
            "dollarsign.circle"
        case .creditcard:
            "creditcard"
        case .book:
            "book"
        case .bookmark:
            "bookmark"
        case .study:
            "graduationcap"
        case .sport:
            "dumbbell"
        case .award:
            "trophy"
        case .shopping:
            "cart"
        case .renovation:
            "hammer"
        case .health:
            "cross.case"
        case .accessories:
            "handbag"
        case .travel:
            "suitcase.rolling"
        case .entertainment:
            "theatermasks"
        }
    }
    
    public static func getIcon(from stringIcon: String) -> Icon? {
        Icon.allCases.first { $0.name == stringIcon }
    }
}
