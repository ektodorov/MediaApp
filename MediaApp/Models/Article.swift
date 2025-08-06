//
//  Article.swift
//  MediaApp
//

import Foundation

struct Article: Identifiable {
    
    var id: UUID = UUID()
    
    var title: String?
    var pubDate: String?
    var descriptionArticle: String?
    var guid: String?
    var guidIsPermalink: Bool?
    var link: String?
    var mediaContent: String?
    var mediaDescription: String?
    var mediaCredit: String?
    
    func contains(searchTerm: String?) -> Bool {
        if(searchTerm == nil) {
            return false
        }
        if((title?.contains(searchTerm!) == true)
           || (pubDate?.contains(searchTerm!) == true)
           || (descriptionArticle?.contains(searchTerm!) == true)) {
            return true;
        }
        
        return false;
    }
    
    var description: String {
        return """
        title=\(String(describing: title)),\n
        pubDate=\(String(describing: pubDate)),\n
        descriptionArticle=\(String(describing: descriptionArticle)),\n
        guid=\(String(describing: guid)),\n
        guidIsPermalink=\(String(describing: guidIsPermalink)),\n
        link=\(String(describing: link)),\n
        mediaContent=\(String(describing: mediaContent)),\n
        mediaDescription=\(String(describing: mediaDescription)),\n
        mediaCredit=\(String(describing: mediaCredit)),\n
        """
    }
}
