//
//  NavBarBackButtonView.swift
//  Delta
//
//  Created by Алексей on 26.11.2024.
//

import SwiftUI

struct NavBarBackButtonView: View {
    let dismiss: DismissAction
    
    init(_ dismiss: DismissAction) {
        self.dismiss = dismiss
    }
    
    var body: some View {
        Button {
           dismiss()
        } label: {
            HStack {
                Image(systemName: "chevron.left")
                Text("Back")
            }
        }
    }
}
