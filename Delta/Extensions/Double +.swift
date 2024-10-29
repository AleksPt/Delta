//
//  Double +.swift
//  Delta
//
//  Created by Tatiana Lazarenko on 9/2/24.
//

import Foundation

extension Double {
    func formattedAmount(for currency: Currency) -> String {
        let roundedAmount = self.rounded()
        let formatter = NumberFormatter()
        
        formatter.numberStyle = .currency
        formatter.currencySymbol = currency.symbol
        formatter.locale = Locale.current
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        formatter.positiveFormat = "\(currency.symbol) #,##0.00"

        return formatter.string(from: roundedAmount as NSNumber) ?? "\(roundedAmount)"
    }
}
