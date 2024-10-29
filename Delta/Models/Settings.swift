//
//  Settings.swift
//  Delta
//
//  Created by Vladimir Dmitriev on 24.07.24.
//

import Foundation

struct Settings {
//    let personName: String = ""
    let language: String
    let currency: String = "GBP"
    let period: Period = .month
    let startOfPeriod: Int
    let appDesign: AppDesign
    let notices: Bool
    let safety: Safety
}

struct AppDesign {
    let theme: String
    let accentColor: String
    let typeOfIncome: String
    let typeOfExpense: String
    let typeOfGoal: String
    let typeOfLoan: String
    let typeOfCredit: String
    let typeOfInvestment: String
}

struct Safety {
    let code: Bool
    let faceID: Bool
    let widgets: Bool
}
