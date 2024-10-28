//
//  DataManager.swift
//  Delta
//
//  Created by Vladimir Dmitriev on 09.09.24.
//

import Foundation

struct DataManager {
    static let shared = DataManager()
    
    private let dataStore = DataStore.shared
    
    private init() {}
    
    func getAccountsAndGroup() -> [Category] {
        dataStore.categories.filter { $0.categoryType == .account || $0.categoryType == .groupOfAccounts }
    }
    
    func getCategories(with categoryType: CategoryType) -> [Category] {
        dataStore.categories.filter { $0.categoryType == categoryType }
    }
    
    static func filterTransactions(
        _ transactions: [Transaction],
        sourceID: UUID? = nil,
        destinationID: UUID? = nil
    ) -> [Transaction] {
        return transactions.filter { transaction in
            var matchesSource = true
            var matchesDestination = true
            
            if let sourceID = sourceID {
                matchesSource = transaction.sourceID == sourceID
            }
            
            if let destinationID = destinationID {
                matchesDestination = transaction.destinationID == destinationID
            }
            
            return matchesSource && matchesDestination
        }
    }
    
    static func filterTransactions(
        _ transactions: [Transaction],
        customStartDate: Date,
        customEndDate: Date
    ) -> [Transaction] {
        return transactions.filter { $0.date >= customStartDate && $0.date <= customEndDate }
    }
    
    static func filterTransactions(
        _ transactions: [Transaction],
        for period: Calendar.Component,
        startDay: Int,
        fromMonthOffset offset: Int
    ) -> [Transaction] {
        let calendar = Calendar.current
        let today = Date()
        
        guard let startOfCurrentPeriod = calendar.date(byAdding: period, value: -offset, to: today) else {
            return []
        }
        
        var startOfPeriod: Date
        
        if let startDateOfPeriod = calendar.date(bySetting: .day, value: startDay, of: startOfCurrentPeriod) {
            if startDateOfPeriod > today {
                startOfPeriod = calendar.date(byAdding: period, value: -1, to: startDateOfPeriod)!
            } else {
                startOfPeriod = startDateOfPeriod
            }
        } else {
            return []
        }
        
        let endOfPeriod = calendar.date(byAdding: period, value: 1, to: startOfPeriod)!
        
        return transactions.filter { $0.date >= startOfPeriod && $0.date < endOfPeriod }
    }
}
