//
//  Models.swift
//  LearningApp
//
//  Created by Brent on 5/5/2022.
//

import Foundation

protocol Cardable {
    
    var id:Int { get set }
    var title:String { get set }
    var description:String { get set }
    var duration:String { get set }
    var type:String { get }
    
}

struct Module: Identifiable, Decodable {
    var id:Int
    var category:String
    var content:Content
    var test:Test
}

struct Content: Identifiable, Decodable {
    var id:Int
    var image:String
    var time:String
    var description:String
    var lessons:[Lesson]
}

struct Lesson: Identifiable, Decodable {
    var id:Int
    var title:String
    var video:String
    var duration:String
    var explanation:String
    
}

struct Test: Identifiable, Decodable {
    var id:Int
    var image:String
    var time:String
    var description:String
    var questions:[Question]
}

struct Question: Identifiable, Decodable {
    var id:Int
    var content:String
    var correctIndex:Int
    var answers:[String]
}
