//
//  ContentDescriptionView.swift
//  LearningApp
//
//  Created by Brent on 10/5/2022.
//

import SwiftUI

struct ContentDescriptionView: UIViewRepresentable {
    
    @EnvironmentObject private var model:ContentModel
    
    func makeUIView(context: Context) -> UITextView {
        
        let textView = UITextView()
        
        textView.isEditable = false
        
        return textView
        
        
    }
    
    func updateUIView(_ textView: UITextView, context: Context) {
        
        // set the attributed text for the lesson
        textView.attributedText = model.lessonDescription
        textView.scrollRectToVisible(CGRect(x: 0, y: 0, width: 1, height: 1), animated: false)
        
    }
    
}

struct ContentDescriptionView_Previews: PreviewProvider {
    static var previews: some View {
        ContentDescriptionView()
    }
}
