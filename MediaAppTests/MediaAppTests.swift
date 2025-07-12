//
//  MediaAppTests.swift
//  MediaAppTests
//

import Testing
import Dispatch
@testable import MediaApp

struct MediaAppTests {

    @Test func testArticleParser() async throws {
        let parser: ArticleParser = ArticleParser()
                
        await withCheckedContinuation { continuation in
            parser.parseWithContentsOfURL(rssUrl: ConstantsMedia.urlRss) { success in
                #expect(success == true)
                #expect(parser.parsedData.count > 0)
                continuation.resume()
            }
        }
        #expect(parser.parsedData.count > 0)
    }
    
    @Test func testArticleFilter() async throws {
        let articleVM = ArticleViewModel(url: ConstantsMedia.urlRss, parser: ArticleParser())
        let item1 = Article(title: "Item1", descriptionArticle: "Desc1")
        let item2 = Article(title: "Item2", descriptionArticle: "Desc2")
        articleVM.articleList.append(item1)
        articleVM.articleList.append(item2)
        
        articleVM.filter(searchTerm: "Item1")
        
        #expect(articleVM.articleList.count == 1)
        #expect(articleVM.articleList[0].title == "Item1")
        #expect(articleVM.articleList[0].descriptionArticle == "Desc1")
    }
}
