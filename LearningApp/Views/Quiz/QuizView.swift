//
//  QuizView.swift
//  LearningApp
//
//  Created by Brent on 11/5/2022.
//

import SwiftUI

struct QuizView: View {
    
    private struct Constants {
        static let answerSpacing:CGFloat = 20.0
    }
    
    @EnvironmentObject private var model:ContentModel
    
    var body: some View {
        VStack {
            
            if let module = model.currentModule {
                
                header(module:module)
                
                // question
//                Text(model.currentQuestion?.content ?? "No Question")
                CodeTextView(textToDisplay: model.questionText)
                    .border(.green)
                // Attributed String
                
                // Answers
                VStack (spacing: Constants.answerSpacing){
                    ForEach(model.currentQuestion?.answers ?? [], id:\.self) { answer in
                        RectangleButton(title: answer, bgColor: .white) {
                            // TODO: Link to ContentModel
                        }
                        .foregroundColor(.black)
                    }
                }
                Spacer()
                // TODO: Change to be dynamic
                RectangleButton(title: "Next", bgColor: .green) {
                    
                }
                .foregroundColor(.white)
            }
            
        }
        .padding()
    }
    
    @ViewBuilder
    private func header(module:Module) -> some View {
        HStack {
            // Quiz Name
            Text("\(module.category) Test")
                .font(.title)
                .fontWeight(.bold)
            Spacer()
            
            Text("Question \(model.currentQuestionIndex+1) of \(model.currentModule?.test.questions.count ?? 0)")
        }
    }
}

struct QuizView_Previews: PreviewProvider {
    static var previews: some View {
        let model = ContentModel()
        
        let _ = model.beginTest(moduleId: 0)
        
        QuizView()
            .environmentObject(model)
    }
}
