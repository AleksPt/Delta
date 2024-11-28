//
//  AutoTransaction.swift
//  Delta
//
//  Created by Vladimir Dmitriev on 28.11.24.
//

import Foundation

final class AutoTransaction {
    var id: UUID = UUID()
    var title: String = ""
    var repeatDate: Date = Date()
    var endDate: Date = Date()
    var period: Period = .month
    var isNotify: Bool = false
    
    init(
        id: UUID,
        title: String,
        repeatDate: Date,
        endDate: Date,
        period: Period,
        isNotify: Bool
    ) {
        self.id = id
        self.title = title
        self.repeatDate = repeatDate
        self.endDate = endDate
        self.period = period
        self.isNotify = isNotify
    }
}
