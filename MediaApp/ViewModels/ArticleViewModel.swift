//
//  ArticleProvider.swift
//  MediaApp
//

import Foundation

class ArticleViewModel : ObservableObject {
    
    @Published var articleList: Array<Article> = Array<Article>()
    @Published var isLoading: Bool = false
    private let parser: ArticleParser
    private let url: String
    
    init(url: String, parser: ArticleParser) {
        self.url = url
        self.parser = parser
    }
    
    func parseArticles() {
        isLoading = true
        parser.parseWithContentsOfURL(rssUrl: url) {[weak self] (success) in
            if (success) {
                if let rssItems = self?.parser.parsedData {
                    self?.articleList.removeAll()
                    self?.articleList.append(contentsOf: rssItems)
                }
            }
            self?.isLoading = false
        }
    }
    
    func filter(searchTerm: String?) {
        if(searchTerm == nil) {
            return
        }
        if(searchTerm!.isEmpty) {
            parseArticles()
            return
        }
        let result = articleList.filter{
            $0.contains(searchTerm: searchTerm)
        }
        articleList.removeAll()
        articleList.append(contentsOf: result)
    }
}
