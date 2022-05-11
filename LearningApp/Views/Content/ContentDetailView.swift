//
//  ContentDetailView.swift
//  LearningApp
//
//  Created by Brent on 9/5/2022.
//

import SwiftUI
import AVKit

struct ContentDetailView: View {
    
    @EnvironmentObject private var model:ContentModel
    
    var body: some View {
        
        if let lesson = model.currentLesson {
            VStack (alignment: .center) {
                // video
                videoPlayerForLesson(lesson)
                
                // description
                ContentDescriptionView()
                // Next Lesson
                nextLessonButton()
            }
            .padding()
            .navigationTitle(lesson.title)
        } else {
            Text("No Lesson to Show")
        }
    }
    
    @ViewBuilder
    private func videoPlayerForLesson(_ lesson:Lesson) -> some View {
        if let url = URL(string: GlobalConstants.urlPrefix + (lesson.video)) {
            VideoPlayer(player: AVPlayer(url: url))
                .cornerRadius(GlobalConstants.cornerRadius)
                .shadow(radius: GlobalConstants.shadowRadius)
        }
    }
    
    @ViewBuilder
    private func nextLessonButton() -> some View {
        if model.hasNextLesson() {
            
            let nextLessonIndex = model.currentLessonIndex + 1
            let nextLesson = model.currentModule?.content.lessons[nextLessonIndex]
            
            lessonButton(title: "Next Lesson: \(nextLesson?.title ?? "")", bgColor: .green) {
                model.advanceLesson()
            }
            
        } else {
            // show the complete button
            lessonButton(title: "Complete", bgColor: .green) {
                model.selectedContent = nil
            }
        }
    }
    
    @ViewBuilder
    private func lessonButton(title:String?, bgColor:Color?, action: (() -> Void)?) -> some View {
        Button {
            if let action = action { action() }
        } label: {
            
            ZStack {
                // background
                RectangleCard(bgColor: .green)
                
                // text overlay
                Text(title ?? "")
                    .foregroundColor(.white)
                    .fontWeight(.bold)
            }
            
        }
    }
}

struct LessonView_Previews: PreviewProvider {
    static var previews: some View {
        
        let model = ContentModel()
        let _ = model.beginModule(0)
        
        
        NavigationView {
            ContentDetailView()
                .environmentObject(model)
                .onAppear {
                    model.beginLesson(0)
                }
        }
        
    }
}
