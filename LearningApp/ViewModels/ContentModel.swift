//
//  ContentModel.swift
//  LearningApp
//
//  Created by Brent on 5/5/2022.
//

import Foundation

class ContentModel: ObservableObject {
    
    @Published private(set) var modules:[Module] = []
    
    private var styleData:Data?
    
    init() {
        
        self.modules = getItemsFromJSONFile("data", type: Module.self) ?? []
        self.styleData = getStyleDataHTMLFile("style")
    }
    
    func getItemsFromJSONFile<T>(_ filename:String, type:T.Type) -> [T]? where T:Decodable {
        
        
        guard let url = Bundle.main.url(forResource: filename, withExtension: "json") else { return nil}
        
        guard let data = try? Data(contentsOf: url) else { return nil }
        
        let decoder = JSONDecoder()
        
        guard let items = try? decoder.decode([T].self, from: data) else { return nil }
        
        return items
    }
    
    func getStyleDataHTMLFile(_ filename:String) -> Data? {
        
        guard let url = Bundle.main.url(forResource: filename, withExtension: "html") else { return nil}
        guard let data = try? Data(contentsOf: url) else { return nil }
        
        return data
    }
    
}
