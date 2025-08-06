//
//  ArticleParser.swift
//  MediaApp
//

import Foundation

class ArticleParser: NSObject, XMLParserDelegate {
    
    var parsedData: Array<Article> = [Article]()
    private var xmlParser: XMLParser!
    private var currentElement = ""
    private var rssItems: Array<Article> = [Article]()
    private var rssArticle =  Article.init()
    
    func parseWithContentsOfURL(rssUrl: String, with completion: @escaping (Bool)-> ()) {
        DispatchQueue.global(qos: DispatchQoS.QoSClass.default).async(execute: {[weak self] () -> Void in
            guard let rssURL = URL.init(string: rssUrl) else {
                DispatchQueue.main.async(execute: {() -> Void in
                    completion(false)
                })
                return
            }
            let parser = XMLParser(contentsOf: rssURL)
            parser?.delegate = self
            if let flag = parser?.parse() {
                DispatchQueue.main.async(execute: {() -> Void in
                    completion(flag)
                })
            }
        })
    }

    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        currentElement = elementName
        if currentElement == "item" {
            self.rssArticle = Article()
        }
        if(elementName == "guid") {
            self.rssArticle.guidIsPermalink = Bool(attributeDict["isPermaLink"] ?? "false")
        } else if(elementName == "media:content") {
            self.rssArticle.mediaContent = attributeDict["url"]
        }
    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        let string = string.trimmingCharacters(in: .whitespacesAndNewlines)
        switch currentElement {
        case "title":
            self.rssArticle.title = (self.rssArticle.title ?? "") + string
        case "pubDate":
            self.rssArticle.pubDate = (self.rssArticle.pubDate ?? "") + string
        case "description":
            self.rssArticle.descriptionArticle = (self.rssArticle.descriptionArticle ?? "") + string
        case "guid":
            self.rssArticle.guid = (self.rssArticle.guid ?? "") + string
        case "link":
            self.rssArticle.link = (self.rssArticle.link ?? "") + string
        case "media:description":
            self.rssArticle.mediaDescription = (self.rssArticle.mediaDescription ?? "") + string
        case "media:credit":
            self.rssArticle.mediaCredit = (self.rssArticle.mediaCredit ?? "") + string
        default: break
        }
    }
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if elementName == "item" {
            let item = self.rssArticle
            self.rssItems.append(item)
        }
    }
    
    func parserDidEndDocument(_ parser: XMLParser) {
        self.parsedData = self.rssItems
    }
    
    func parser(_ parser: XMLParser, parseErrorOccurred parseError: Error) {
        print(parseError.localizedDescription)
    }
    
}
