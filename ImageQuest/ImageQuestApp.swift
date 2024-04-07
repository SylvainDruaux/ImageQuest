//
//  ImageQuestApp.swift
//  ImageQuest
//
//  Created by Sylvain Druaux on 03/04/2024.
//

import SwiftUI

@main
struct ImageQuestApp: App {
    @StateObject var coordinator = Coordinator()
    
    init() {
        URLCache.shared.memoryCapacity = 50_000_000 // ~50 MB memory space
        URLCache.shared.diskCapacity = 100_000_000 // Maximum of ~100 MB disk cache space
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(coordinator)
                .preferredColorScheme(.dark)
        }
    }
}
