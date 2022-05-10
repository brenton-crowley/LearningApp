//
//  ContentModel.swift
//  LearningApp
//
//  Created by Brent on 5/5/2022.
//

import Foundation

class ContentModel: ObservableObject {
    
    @Published private(set) var modules:[Module] = []
    @Published private(set) var currentModule:Module?
    private var currentModuleIndex = 0
    
    @Published private(set) var currentLesson:Lesson?
    private(set) var currentLessonIndex:Int = 0
    
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
    
    // MARK: - Module navigation methods
    
    public func beginModule(_ moduleid:Int) {
        currentModuleIndex = modules.firstIndex(where: { $0.id == moduleid }) ?? 0
        currentModule = modules[currentModuleIndex]
    }
    
    public func beginLesson(_ lessonIndex:Int) {
        
        guard lessonIndex < (currentModule?.content.lessons.count)! else {
            
            currentLessonIndex = 0
            currentLesson = nil
            return
        }
        
        currentLessonIndex = lessonIndex
        currentLesson = currentModule?.content.lessons[currentLessonIndex]
    }
    
    public func hasNextLesson() -> Bool {
        return (currentLessonIndex + 1 < (currentModule!.content.lessons.count))
    }
    
    public func advanceLesson() {
        beginLesson(currentLessonIndex + 1)
    }
}
