//
//  View +.swift
//  Delta
//
//  Created by Tatiana Lazarenko on 9/13/24.
//

import SwiftUI

extension View {
    func hideKeyboard() {
        let resign = #selector(UIResponder.resignFirstResponder)
        UIApplication.shared.sendAction(resign, to: nil, from: nil, for: nil)
    }
}
