//
//  ContentListView.swift
//  LearningApp
//
//  Created by Brent on 9/5/2022.
//

import SwiftUI

struct ContentListView: View {
    
    private struct Constants {
        static let cornerRadius:CGFloat = 10.0
        static let shadowRadius:CGFloat = 5.0
        static let cardSpacing:CGFloat = 20.0
        static let shadowColour:CGFloat = 100.0
        static let shadowOpacity:CGFloat = 0.5
        
        static let numberPadding:CGFloat = 25.0
        static let infoSpacing:CGFloat = 5.0
    }
    
    @EnvironmentObject private var model:ContentModel
    
    var lessons:[Lesson] { model.currentModule?.content.lessons ?? [] }
    
    var body: some View {
        
        ScrollView {
            VStack (alignment: .leading, spacing: Constants.cardSpacing) {
                ForEach(lessons.indices, id:\.self) { index in
                    listCardWithLesson(index)
                }
            }
            .padding()
        }
    }
    
    @ViewBuilder
    private func listCardWithLesson(_ index:Int) -> some View {
        
        let lesson = lessons[index]
        let title = lesson.title
        let duration = lesson.duration
        
        ZStack {
            // Background
            RoundedRectangle(cornerRadius: Constants.cornerRadius)
                .foregroundColor(.white)
                .shadow(radius: Constants.shadowRadius)
                .opacity(Constants.shadowOpacity)
            
            // Info Details
            HStack {
                
                // number
                Text("\(index + 1)")
                    .font(.title)
                    .padding(Constants.numberPadding)
                VStack (alignment: .leading, spacing: Constants.infoSpacing) {
                    // title
                    Text(title)
                        .fontWeight(.bold)
                    Text("\(duration)")
                        .font(.caption)
                }
                Spacer()
            }
        }
        
    }
}

struct LessonListView_Previews: PreviewProvider {
    static var previews: some View {
        
        let model = ContentModel()
        
        NavigationView {
            ContentListView()
                .environmentObject(model)
                .navigationTitle("Learn \(model.currentModule?.category ?? "")")
                .onAppear {
                    model.beginModule(model.modules.first!.id)
                }
        }
    }
}
