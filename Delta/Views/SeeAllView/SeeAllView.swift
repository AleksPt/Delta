//
//  SeeAllView.swift
//  Delta
//
//  Created by Vladimir Dmitriev on 20.07.24.
//

import SwiftUI

struct SeeAllView: View {
    @Environment(Router.self) private var router
    
    var body: some View {
        Button("Dismiss") {
            router.dismissModal()
        }
    }
}

#Preview {
    SeeAllView()
        .environment(Router.shared)
}
