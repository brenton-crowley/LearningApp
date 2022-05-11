//
//  RectangleCard.swift
//  LearningApp
//
//  Created by Brent on 11/5/2022.
//

import SwiftUI

struct RectangleCard: View {
    
    private struct Constants {
        static let buttonHeight:CGFloat = GlobalConstants.buttonHeight
        static let shadowRadius:CGFloat = GlobalConstants.shadowRadius
    }
    
    var bgColor:Color = .white
    
    var body: some View {
        RoundedRectangle(cornerRadius: GlobalConstants.cornerRadius)
            .frame(height: Constants.buttonHeight)
            .foregroundColor(bgColor)
            .shadow(radius: Constants.shadowRadius)
    }
}

struct RectangleCard_Previews: PreviewProvider {
    static var previews: some View {
        RectangleCard()
    }
}
