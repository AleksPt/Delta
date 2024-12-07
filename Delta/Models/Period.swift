//
//  Period.swift
//  Delta
//
//  Created by Vladimir Dmitriev on 21.11.24.
//

import Foundation

enum Period: CaseIterable {
    case day
    case week
    case month
    case quarter
    case year
    
    var calendarComponent: Calendar.Component {
        switch self {
        case .day:
                .day
        case .week:
                .weekOfYear
        case .month:
                .month
        case .quarter:
                .quarter
        case .year:
                .year
        }
    }
    
    var title: String {
        switch self {
        case .day:
            "Day"
        case .week:
            "Week"
        case .month:
            "Month"
        case .quarter:
            "Quarter"
        case .year:
            "Year"
        }
    }
}
