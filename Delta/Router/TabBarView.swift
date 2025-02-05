//
//  TabBarView.swift
//  Delta
//
//  Created by Tatiana Lazarenko on 8/29/24.
//

import SwiftUI
import UISystem

struct TabBarView: View {
    @Environment(LanguageManager.self) private var languageManager
    @State private var router = Router.shared
    @State private var selectedTab = TabRoute.main
    
    init() {
        setupTabBarAppearance()
    }
    
    var body: some View {
        TabView(selection: $selectedTab) {
            // MARK: - Main
            NavigationStack(path: $router.path) {
                MainView()
                    .navigationDestination(for: Route.self) { route in
                        router.view(for: route)
                    }
            }
            .environment(router)
            .tabItem { setTabItem(icon: "house", title: "Main") }
            .tag(TabRoute.main)
            
            // MARK: - Analytics
            NavigationStack {
                AnalyticsView()
                    .navigationTitle("Analytics")
            }
            .tabItem { setTabItem(icon: "chartPie", title: "Analytics") }
            .tag(TabRoute.analytic)
            
            // MARK: - Shopping List
            NavigationView {
                ShoppingListView()
                    .navigationTitle("Shopping List")
            }
            .tabItem { setTabItem(icon: "list", title: "Shopping List") }
            .tag(TabRoute.shoppingList)
            
            // MARK: - Settings
            NavigationStack {
                SettingsView()
                    .navigationTitle("Settings")
            }
            .tabItem { setTabItem(icon: "gearshape", title: "Settings") }
            .tag(TabRoute.settings)
        }
        .id(languageManager.locale.identifier)
    }
}

extension TabBarView {
    private func setTabItem(icon: String, title: String) -> some View {
        VStack {
            Image(icon)
            Text(LocalizedStringKey(title))
                .font(.metadata2())
        }
    }
    
    private func setupTabBarAppearance() {
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .appBackground
        
        appearance.shadowImage = nil
        appearance.shadowColor = nil
        
        // Цвет для выделенного таба
        appearance.stackedLayoutAppearance.selected.iconColor = .appBlack
        appearance.stackedLayoutAppearance.selected.titleTextAttributes = [.foregroundColor: UIColor.appBlack]
        
        // Цвет для невыбранных табов
        appearance.stackedLayoutAppearance.normal.iconColor = UIColor.lightGray
        appearance.stackedLayoutAppearance.normal.titleTextAttributes = [.foregroundColor: UIColor.lightGray]
        
        UITabBar.appearance().standardAppearance = appearance
        
        if #available(iOS 15.0, *) {
            UITabBar.appearance().scrollEdgeAppearance = appearance
        }
    }
}

//#Preview {
//    TabBarView()
//}
