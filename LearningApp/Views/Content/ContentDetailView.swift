//
//  ContentDetailView.swift
//  LearningApp
//
//  Created by Brent on 9/5/2022.
//

import SwiftUI
import AVKit

struct ContentDetailView: View {
    
    private struct Constants {
        static let buttonHeight:CGFloat = GlobalConstants.buttonHeight
        static let shadowRadius:CGFloat = GlobalConstants.shadowRadius
    }
    
    @EnvironmentObject private var model:ContentModel
    
    var body: some View {
        
        if let lesson = model.currentLesson {
            VStack (alignment: .center) {
                // video
                videoPlayerForLesson(lesson)
                
                // description
                
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
            Button {
                model.advanceLesson()
            } label: {
                
                let nextLessonIndex = model.currentLessonIndex + 1
                let nextLesson = model.currentModule?.content.lessons[nextLessonIndex]
                
                ZStack {
                    // background
                    RoundedRectangle(cornerRadius: GlobalConstants.cornerRadius)
                        .frame(height: Constants.buttonHeight)
                        .foregroundColor(.green)
                        .shadow(radius: Constants.shadowRadius)
                    
                    // text overlay
                    Text("Next Lesson: \(nextLesson?.title ?? "")")
                        .foregroundColor(.white)
                        .fontWeight(.bold)
                }
                
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
