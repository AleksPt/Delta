//
//  ContentView.swift
//  Delta
//
//  Created by Tatiana Lazarenko on 8/29/24.
//

import SwiftUI

@MainActor
struct ContentView: View {
    @State private var router = Router.shared
    @State private var categoryService = CategoryService()
    
    var body: some View {
        //        NavigationStack(path: $router.path) {
        //            router.view(for: router.startScreen)
        //                .navigationDestination(for: Route.self) { route in
        //                    router.view(for: route)
        //                }
        //        }
        router.tabView()
            .sheet(isPresented: $router.isModalPresented) {
                if let modalRoute = router.modalRoute {
                    router.modalView(for: modalRoute)
                }
            }
            .environment(router)
            .environment(categoryService)
    }
}

#Preview {
    ContentView()
}

