//
//  GlobalConstants.swift
//  LearningApp
//
//  Created by Brent on 10/5/2022.
//

import Foundation
import SwiftUI

public typealias GlobalConstants = Global.Constants

public struct Global {
    public struct Constants {
        static let urlPrefix = "https://codewithchris.github.io/learningJSON/"
        static let remoteJSONURLString = "https://brenton-crowley.github.io/CWC-learning-app-data/data2.json"
        
        static let cornerRadius:CGFloat = 10.0
        static let shadowRadius:CGFloat = 5.0
        static let shadowColour:CGFloat = 1.0
        static let shadowOpacity:CGFloat = 0.5
        
        static let buttonHeight:CGFloat = 48.0
        
    }
    
}
