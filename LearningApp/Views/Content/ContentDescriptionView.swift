//
//  ContentDescriptionView.swift
//  LearningApp
//
//  Created by Brent on 10/5/2022.
//

import SwiftUI

/// Creates a bridge between UIKit and SwiftUI via the UIViewRepresentable protocol
struct ContentDescriptionView: UIViewRepresentable {
    
    @EnvironmentObject private var model:ContentModel
    
    
    /// Implemented protocol function that creates a UITextView
    /// - Parameter context
    /// - Returns: UITextView to display
    func makeUIView(context: Context) -> UITextView {
        
        let textView = UITextView()
        
        textView.isEditable = false
        
        return textView
        
        
    }
    
    /// Implemented protocol function that updates a UITextView
    /// Updates the textView with the html attributedString create in the ContentModel
    /// Resets the scrollPosition to 0, 0 upon update
    /// - Parameters:
    ///   - textView: the textView that's created in makeUIView
    ///   - context
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
