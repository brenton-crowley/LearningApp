//
//  RectangleButton.swift
//  LearningApp
//
//  Created by Brent on 11/5/2022.
//

import SwiftUI

struct RectangleButton: View {
    
    var title = ""
    var bgColor:Color = .white
    var action: (() -> Void)?
    
    var body: some View {
        Button {
            if let action = action { action() }
        } label: {
            
            ZStack {
                // background
                RectangleCard(bgColor: bgColor)
                
                // text overlay
                Text(title)
                    .fontWeight(.bold)
            }
            
        }
    }
}

struct RectangleButton_Previews: PreviewProvider {
    static var previews: some View {
        RectangleButton()
    }
}
