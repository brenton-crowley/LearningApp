//
//  QuizResultView.swift
//  LearningApp
//
//  Created by Brent on 16/5/2022.
//

import SwiftUI

struct QuizResultView: View {
    
    @EnvironmentObject private var model:ContentModel
    
    let numberCorrect:Int
    
    var body: some View {
        
        
        let questions = model.currentModule?.test.questions.count ?? 0
        let percentage = model.calculatePercentFromNumberCorrect(numberCorrect, numQuestions: questions)
        
        VStack  {
            Spacer()
            Text(model.headingForPercentage(percentage))
                .font(.title)
            Spacer()
            Text("You got \(numberCorrect) out of \(questions) questions.")
            Spacer()
            RectangleButton(title: "Complete", bgColor: .green) {
                // go back to home screen
                model.selectedTest = nil
            }
            .foregroundColor(.white)

            Spacer()
        }.padding()
    }
}

struct QuizResultView_Previews: PreviewProvider {
    static var previews: some View {
        
        let model = ContentModel()
        let _ = model.beginModule(0)
        
        QuizResultView(numberCorrect: 12)
            .environmentObject(model)
    }
}
