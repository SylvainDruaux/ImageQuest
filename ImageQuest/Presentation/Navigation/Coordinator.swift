//
//  Coordinator.swift
//  ImageQuest
//
//  Created by Sylvain Druaux on 04/04/2024.
//

import SwiftUI

final class Coordinator: ObservableObject {
    @Published var selectedTab: MainViewTab = .discoverTab
    @Published var discoverNavigation: [DiscoverDestination] = []
    @Published var settingsNavigation: [SettingsDestination] = []
    
    var tabSelection: Binding<MainViewTab> {
        Binding<MainViewTab>(
            get: { self.selectedTab },
            set: { [self] tappedTab in
                if tappedTab == selectedTab {
                    switch tappedTab {
                    case .discoverTab:
                        withAnimation { discoverNavigation = [] }
                    case .settingsTab:
                        withAnimation { settingsNavigation = [] }
                    }
                }
                selectedTab = tappedTab
            }
        )
    }
    
    @ViewBuilder
    func build(discoverDestination: DiscoverDestination) -> some View {
        switch discoverDestination {
        case .photoDetail(let photo):
            PhotoDetailView(photo: photo)
        }
    }
    
    @ViewBuilder
    func build(settingsDestination: SettingsDestination) -> some View {
        switch settingsDestination {
        case .about:
            // AboutView
            EmptyView()
        }
    }
}
