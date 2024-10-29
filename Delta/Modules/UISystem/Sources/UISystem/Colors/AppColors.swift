//
//  File.swift
//  
//
//  Created by Tatiana Lazarenko on 7/29/24.
//

import SwiftUI

public extension Color {
    static let theme = AppColors()
}

public struct AppColors {
    //System Colors
    public let appWhite = Color("appWhite")
    public let appBlack = Color("appBlack")
    public let appGray = Color("appGray")
    public let textGray = Color("textGray")
    public let appBackground = Color("appBackground")
    public let appBackgroundMini = Color("appBackgroundMini")
    
    //Accent Colors
    public let appBlue = Color("appBlue")
    public let appGreen = Color("appGreen")
    public let appMint = Color("appMint")
    public let appPink = Color("appPink")
    public let appPurple = Color("appPurple")
    public let appRed = Color("appRed")
    public let appYellow = Color("appYellow")
    
}

public enum AppGradient: CaseIterable, Hashable {
    case blueGradient
    case purpleGradient
    case pinkGradient
    case redGradient
    case yellowGradient
    case greenGradient
    case mintGradient
    case appWhite
    case appBlack
    case appGray
    case textGray
    case appBackground
    case appBackgroundMini
    case appBlue
    case appGreen
    case appMint
    case appPink
    case appPurple
    case appRed
    case appYellow
    
    public var name: String {
        switch self {
        case .blueGradient:
            "blueGradient"
        case .purpleGradient:
            "purpleGradient"
        case .pinkGradient:
            "pinkGradient"
        case .redGradient:
            "redGradient"
        case .yellowGradient:
            "yellowGradient"
        case .greenGradient:
            "greenGradient"
        case .mintGradient:
            "mintGradient"
        case .appWhite:
            "appWhite"
        case .appBlack:
            "appBlack"
        case .appGray:
            "appGray"
        case .textGray:
            "textGray"
        case .appBackground:
            "appBackground"
        case .appBackgroundMini:
            "appBackgroundMini"
        case .appBlue:
            "appBlue"
        case .appGreen:
            "appGreen"
        case .appMint:
            "appMint"
        case .appPink:
            "appPink"
        case .appPurple:
            "appPurple"
        case .appRed:
            "appRed"
        case .appYellow:
            "appYellow"
        }
    }
    
    public var value: LinearGradient {
        switch self {
        case .blueGradient:
            return LinearGradient(
                gradient: Gradient(colors: [Color.theme.appBlue, Color.theme.appPurple]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
        case .purpleGradient:
            return LinearGradient(
                gradient: Gradient(colors: [Color.theme.appPurple, Color.theme.appPink]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
        case .pinkGradient:
            return LinearGradient(
                gradient: Gradient(colors: [Color.theme.appPink, Color.theme.appRed]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
        case .redGradient:
            return LinearGradient(
                gradient: Gradient(colors: [Color.theme.appRed, Color.theme.appYellow]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
        case .yellowGradient:
            return LinearGradient(
                gradient: Gradient(colors: [Color.theme.appYellow, Color.theme.appGreen]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
        case .greenGradient:
            return LinearGradient(
                gradient: Gradient(colors: [Color.theme.appGreen, Color.theme.appMint]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
        case .mintGradient:
            return LinearGradient(
                gradient: Gradient(colors: [Color.theme.appMint, Color.theme.appBlue]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
        case .appWhite:
            return LinearGradient(
                gradient: Gradient(colors: [Color.theme.appWhite, Color.theme.appWhite]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
        case .appBlack:
            return LinearGradient(
                gradient: Gradient(colors: [Color.theme.appBlack, Color.theme.appBlack]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
        case .appGray:
            return LinearGradient(
                gradient: Gradient(colors: [Color.theme.appGray, Color.theme.appGray]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
        case .textGray:
            return LinearGradient(
                gradient: Gradient(colors: [Color.theme.textGray, Color.theme.textGray]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
        case .appBackground:
            return LinearGradient(
                gradient: Gradient(colors: [Color.theme.appBackground, Color.theme.appBackground]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
        case .appBackgroundMini:
            return LinearGradient(
                gradient: Gradient(colors: [Color.theme.appBackgroundMini, Color.theme.appBackgroundMini]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
        case .appBlue:
            return LinearGradient(
                gradient: Gradient(colors: [Color.theme.appBlue, Color.theme.appBlue]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
        case .appGreen:
            return LinearGradient(
                gradient: Gradient(colors: [Color.theme.appGreen, Color.theme.appGreen]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
        case .appMint:
            return LinearGradient(
                gradient: Gradient(colors: [Color.theme.appMint, Color.theme.appMint]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
        case .appPink:
            return LinearGradient(
                gradient: Gradient(colors: [Color.theme.appPink, Color.theme.appPink]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
        case .appPurple:
            return LinearGradient(
                gradient: Gradient(colors: [Color.theme.appPurple, Color.theme.appPurple]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
        case .appRed:
            return LinearGradient(
                gradient: Gradient(colors: [Color.theme.appRed, Color.theme.appRed]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
        case .appYellow:
            return LinearGradient(
                gradient: Gradient(colors: [Color.theme.appYellow, Color.theme.appYellow]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
        }
    }
    
    public static func getColor(from stringColor: String) -> AppGradient? {
        AppGradient.allCases.first { $0.name == stringColor }
    }
}

//public extension LinearGradient {
//    static var blueGradient = LinearGradient(
//        gradient: Gradient(colors: [Color.theme.appBlue, Color.theme.appPurple]),
//        startPoint: .topLeading,
//        endPoint: .bottomTrailing
//    )
//
//    static var purpleGradient = LinearGradient(
//        gradient: Gradient(colors: [Color.theme.appPurple, Color.theme.appPink]),
//        startPoint: .topLeading,
//        endPoint: .bottomTrailing
//    )
//    
//    static var pinkGradient = LinearGradient(
//        gradient: Gradient(colors: [Color.theme.appPink, Color.theme.appRed]),
//        startPoint: .topLeading,
//        endPoint: .bottomTrailing
//    )
//    
//    static var redGradient = LinearGradient(
//        gradient: Gradient(colors: [Color.theme.appRed, Color.theme.appYellow]),
//        startPoint: .topLeading,
//        endPoint: .bottomTrailing
//    )
//    
//    static var yellowGradient = LinearGradient(
//        gradient: Gradient(colors: [Color.theme.appYellow, Color.theme.appGreen]),
//        startPoint: .topLeading,
//        endPoint: .bottomTrailing
//    )
//    
//    static var greenGradient = LinearGradient(
//        gradient: Gradient(colors: [Color.theme.appGreen, Color.theme.appMint]),
//        startPoint: .topLeading,
//        endPoint: .bottomTrailing
//    )
//    
//    static var mintGradient = LinearGradient(
//        gradient: Gradient(colors: [Color.theme.appMint, Color.theme.appBlue]),
//        startPoint: .topLeading,
//        endPoint: .bottomTrailing
//    )
//}
