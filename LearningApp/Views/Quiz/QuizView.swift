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
    
    @State private var selectedAnswerIndex:Int?
    @State private var numberCorrect = 0
    @State private var submitted = false
    
    var buttonText:String {
        
        // check if answer has been submitted
        if submitted {
            
            if model.currentQuestionIndex + 1 == (model.currentModule?.test.questions.count ?? -1) {
                return "Finish"
            }
            
            return "Next" // or finish
        }
        
        return "Submit"
    }
    
    var body: some View {
        VStack {
            
            if let module = model.currentModule {
                
                if let _ = model.currentQuestion {
                    
                    header(module:module)
                        .padding(.horizontal)
                    
                    // question
                    //                Text(model.currentQuestion?.content ?? "No Question")
                    CodeTextView(textToDisplay: model.questionText)
                        .padding(.horizontal)
                        .border(.green)
                    // Attributed String
                    
                    // Answers
                    answers()
                    // TODO: Change to be dynamic
                    RectangleButton(title: buttonText, bgColor: .green) {
                        //  Check the answer and increment the counter if correct.
                        if selectedAnswerIndex == model.currentQuestion?.correctIndex { numberCorrect += 1 }
                        
                        // change submitted state to true
                        if submitted {
                            model.advanceQuestion()
                            submitted = false
                            selectedAnswerIndex = nil
                        } else { submitted = true }
                    }
                    .disabled(selectedAnswerIndex == nil)
                    .foregroundColor(.white)
                    .padding(.horizontal)
                } else {
                    QuizResultView(numberCorrect:numberCorrect)
                }
                
            }
        }
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
    
    @ViewBuilder
    private func answers() -> some View {
        ScrollView {
            VStack (spacing: Constants.answerSpacing){
                ForEach(0..<(model.currentQuestion?.answers.count ?? 0), id:\.self) { index in
                    
                    let answer = model.currentQuestion?.answers[index]
//                    let bgColor:Color = selectedAnswerIndex == index ? .gray : .white
                    
                    let bgColor = model.colorForAnswerIndex(index,
                                                            selectedAnswerIndex: selectedAnswerIndex ?? -1,
                                                            isSubmitted: submitted)
                    
                    RectangleButton(title: answer ?? "", bgColor: bgColor) {
                        // TODO: Link to ContentModel
                        selectedAnswerIndex = index
                    }
                    .disabled(submitted)
                    .padding(.horizontal)
                    .foregroundColor(.black)
                }
            }.padding(.top)
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
