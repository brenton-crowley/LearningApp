//
//  ContentListView.swift
//  LearningApp
//
//  Created by Brent on 9/5/2022.
//

import SwiftUI

struct ContentListView: View {
    
    private struct Constants {
        static let cornerRadius:CGFloat = GlobalConstants.cornerRadius
        static let shadowRadius:CGFloat = GlobalConstants.shadowRadius
        static let shadowColour:CGFloat = GlobalConstants.shadowColour
        static let shadowOpacity:CGFloat = GlobalConstants.shadowOpacity
        static let cardSpacing:CGFloat = 20.0
        
        static let numberPadding:CGFloat = 25.0
        static let infoSpacing:CGFloat = 5.0
    }
    
    @EnvironmentObject private var model:ContentModel
    
    var lessons:[Lesson] { model.currentModule?.content.lessons ?? [] }
    
    var body: some View {
        
        ScrollView {
            VStack (alignment: .leading, spacing: Constants.cardSpacing) {
                ForEach(lessons.indices, id:\.self) { index in

                    NavigationLink {
                        ContentDetailView()
                            .onAppear { model.beginLesson(index) }
                    } label: { listCardWithLesson(index) }.buttonStyle(.plain)
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
                    model.beginModule(0)
                }
        }
    }
}
