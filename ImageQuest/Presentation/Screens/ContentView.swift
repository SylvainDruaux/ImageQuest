//
//  ContentView.swift
//  ImageQuest
//
//  Created by Sylvain Druaux on 03/04/2024.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject private var coordinator: Coordinator
    
    var body: some View {
        TabView(selection: coordinator.tabSelection) {
            NavigationStack(path: $coordinator.discoverNavigation) {
                DiscoverPhotosView()
                    .navigationDestination(for: DiscoverDestination.self) { screen in
                        coordinator.build(discoverDestination: screen)
                    }
            }
            .tabItem { Image(systemName: "magnifyingglass") }
            .tag(MainViewTab.discoverTab)
            
            NavigationStack(path: $coordinator.settingsNavigation) {
                SettingsView()
                    .navigationDestination(for: SettingsDestination.self) { screen in
                        coordinator.build(settingsDestination: screen)
                    }
            }
            .tabItem { Image(systemName: "gear") }
            .tag(MainViewTab.settingsTab)
        }
    }
}

#Preview {
    ContentView()
        .environmentObject(Coordinator())
        .preferredColorScheme(.dark)
}
