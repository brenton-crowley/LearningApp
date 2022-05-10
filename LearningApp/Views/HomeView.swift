//
//  HomeView.swift
//  LearningApp
//
//  Created by Brent on 5/5/2022.
//

import SwiftUI

struct HomeView: View {
    
    private struct Constants {
        static let navigationTitle = "Get Started"
        static let navigationSubtitle = "What would you like to do today?"
        static let cardSpacing:CGFloat = 30.0
    }
    
    @EnvironmentObject private var model:ContentModel
    
    var body: some View {
         
        NavigationView {
            
            VStack (alignment:.leading) {
                Text(Constants.navigationSubtitle)
                    .padding(.leading)
                ScrollView {
                    LazyVStack (spacing: Constants.cardSpacing) {
                        ForEach(model.modules) { module in
                            contentCard(module: module)
                            testCard(module: module)
                        }
                    }
                    .padding()
                }
            }
            .navigationTitle(Constants.navigationTitle)
        }   
        .navigationViewStyle(.stack)
    }
    
    @ViewBuilder
    private func contentCard(module:Module) -> some View {
        
        let title = "Learn \(module.category)"
        
        NavigationLink {
            ContentListView()
                .navigationTitle(title)
                .onAppear {
                    model.beginModule(module.id)
                }
        } label: {
            let content = module.content
            
            HomeCard(title: title,
                     description: content.description,
                     contentItemsDescription: "\(content.lessons.count) Lessons",
                     duration: "\(content.time)",
                     image: content.image)
        }.buttonStyle(.plain)
    }
    
    @ViewBuilder
    private func testCard(module:Module) -> some View {
        NavigationLink {
            // todo
        } label: {
            let test = module.test
            
            HomeCard(title: "\(module.category) Test",
                     description: test.description,
                     contentItemsDescription: "\(test.questions.count) Questions",
                     duration: "\(test.time)",
                     image: test.image)
        }.buttonStyle(.plain)
    }
    
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .environmentObject(ContentModel())
    }
}
