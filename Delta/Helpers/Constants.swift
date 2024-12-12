//
//  Constants.swift
//  Delta
//
//  Created by Vladimir Dmitriev on 08.09.24.
//

import SwiftUI

struct Constants {
    static let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
    
    static let screenWidth: CGFloat = {
        guard let width = windowScene?.screen.bounds.width else {
            return UIScreen.main.bounds.width
        }
        return width
    }()
    
    static let screenHeight: CGFloat = {
        guard let height = windowScene?.screen.bounds.height else {
            return UIScreen.main.bounds.height
        }
        return height
    }()
    
    static let widthOne = (screenWidth - 16 * 6) / 5
    static let widthTwo = (screenWidth - 16 * 6) / 5 * 2 + 16
    static let widthThree = (screenWidth - 16 * 6) / 5 * 3 + 32
    static let widthFour = (screenWidth - 16 * 5) / 2
    static let widthFive = screenWidth - 32
    static let widthHalfScreen = (screenWidth - 16 * 3) / 2
    static let widthSix = screenWidth - 38
    
    static let heightOne = screenHeight * 0.09
    static let heightTwo = screenHeight * 0.18 + 16
    static let heightThree = screenHeight * 0.1
    static let heightFour = screenHeight * 0.12
    static let heightFive = screenHeight * 0.06
    static let heightSix = screenHeight * 0.16
}
