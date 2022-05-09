//
//  LessonListView.swift
//  LearningApp
//
//  Created by Brent on 9/5/2022.
//

import SwiftUI

struct LessonListView: View {
    
    private struct Constants {
        static let cornerRadius:CGFloat = 10.0
        static let shadowRadius:CGFloat = 5.0
        static let cardSpacing:CGFloat = 20.0
        static let shadowColour:CGFloat = 100.0
        static let shadowOpacity:CGFloat = 0.5
        
        static let numberPadding:CGFloat = 25.0
        static let infoSpacing:CGFloat = 5.0
    }
    
    let lessons:[Lesson]
    
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
            RoundedRectangle(cornerRadius: Constants.cornerRadius)
                .foregroundColor(.white)
                .shadow(radius: Constants.shadowRadius)
                .opacity(Constants.shadowOpacity)
            HStack {
                
                // number
                Text("\(index)")
                    .font(.title)
                    .padding(Constants.numberPadding)
                VStack (alignment: .leading, spacing: Constants.infoSpacing) {
                    // title
                    Text(title)
                        .fontWeight(.bold)
                    Text("Video - \(duration)")
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
        let lessons = model.modules.first!.content.lessons
        
        NavigationView {
            LessonListView(lessons:lessons)
                .navigationTitle("Learn Swift")
        }
    }
}
