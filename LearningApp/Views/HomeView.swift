//
//  HomeView.swift
//  LearningApp
//
//  Created by Brent on 5/5/2022.
//

import SwiftUI

struct HomeView: View {
    
    @EnvironmentObject private var model:ContentModel
    
    var body: some View {
        Text("Hello, world!")
            .padding()
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .environmentObject(ContentModel())
    }
}
