//
//  ContentModel.swift
//  LearningApp
//
//  Created by Brent on 5/5/2022.
//

import Foundation

class ContentModel: ObservableObject {
    
    @Published var selectedContent:Int?
    
    @Published private(set) var modules:[Module] = []
    @Published private(set) var currentModule:Module?    
    @Published private(set) var currentLesson:Lesson?
    @Published private(set) var lessonDescription = NSAttributedString()
    
    private(set) var currentLessonIndex:Int = 0
    
    private var currentModuleIndex = 0
    private var styleData:Data?
    
    init() {
        
        self.modules = getItemsFromJSONFile("data", type: Module.self) ?? []
        self.styleData = getStyleDataHTMLFile("style")
    }
    
    /// Imports a JSON file and maps its object tree to model objects
    /// - Parameters:
    ///   - filename: The name of the JSON file you wish to import
    ///   - type: The root model object's type. Eg. `Module.self`
    /// - Returns: An array of the root model's type. If only one object exists then it will return an array with that one object.
    func getItemsFromJSONFile<T>(_ filename:String, type:T.Type) -> [T]? where T:Decodable {
        
        
        guard let url = Bundle.main.url(forResource: filename, withExtension: "json") else { return nil}
        
        guard let data = try? Data(contentsOf: url) else { return nil }
        
        let decoder = JSONDecoder()
        
        guard let items = try? decoder.decode([T].self, from: data) else { return nil }
        
        return items
    }
    
    /// Import the styling css from the bundle file.
    /// - Parameter filename: The name of the style file that you want to import.
    /// - Returns: A data object containing the styling data should it succeed, otherwise nil.
    func getStyleDataHTMLFile(_ filename:String) -> Data? {
        
        guard let url = Bundle.main.url(forResource: filename, withExtension: "html") else { return nil}
        guard let data = try? Data(contentsOf: url) else { return nil }
        
        return data
    }
    
    // MARK: - Module navigation methods
    
    /// Sets the currentModuleIndex to the input value if it finds one, otherwise it default to 0
    /// - Parameter moduleid: The id of the module that you want to begin.
    public func beginModule(_ moduleid:Int) {
        currentModuleIndex = modules.firstIndex(where: { $0.id == moduleid }) ?? 0
        currentModule = modules[currentModuleIndex]
    }
    
    /// Sets the current lesson index to the input value if it's within the accepted lesson range.
    /// - Parameter lessonIndex: The index of the lesson you want to begin. If out of bounds, defaults to 0 and sets currentLesson to nil.
    public func beginLesson(_ lessonIndex:Int) {
        
        guard lessonIndex < (currentModule?.content.lessons.count)! else {
            
            currentLessonIndex = 0
            currentLesson = nil
            return
        }
        
        currentLessonIndex = lessonIndex
        currentLesson = currentModule?.content.lessons[currentLessonIndex]
        lessonDescription = addStylingToHTMLString(currentLesson?.explanation ?? "")
    }
    
    /// Checks to see if the current module has another lesson after the current lesson
    /// - Returns: `true` if another lesson is available, otherwise `false`
    public func hasNextLesson() -> Bool {
        return (currentLessonIndex + 1 < (currentModule!.content.lessons.count))
    }
    
    /// Increments the current lesson by one if it's within the lesson range.
    public func advanceLesson() { beginLesson(currentLessonIndex + 1) }
    
    //MARK: - Code Styling
    /// Returns an NSAttributedString that's styled based on the styleData property.
    /// - Parameter htmlString: The HTML String that will be parsed
    /// - Returns: NSAttributedString
    private func addStylingToHTMLString(_ htmlString:String) -> NSAttributedString {
        
        var attributedString = NSAttributedString()
        var data = Data()
        
        // Append the styleData to the data object if it exists.
        if let styleData = styleData { data.append(styleData) }
        
        data.append(Data(htmlString.utf8))
        
        // assign the attributedString to the result variable.
        if let result = try? NSAttributedString(data: data,
                                                options: [.documentType:NSAttributedString.DocumentType.html],
                                                documentAttributes: nil) {
            attributedString = result
        }
        
        return attributedString
    }
}
