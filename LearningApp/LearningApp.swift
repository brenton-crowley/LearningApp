//
//  LearningApp.swift
//  LearningApp
//
//  Created by Brent on 5/5/2022.
//

import SwiftUI

@main
struct LearningApp: App {
    var body: some Scene {
        WindowGroup {
            HomeView()
                .environmentObject(ContentModel())
        }
    }
}
