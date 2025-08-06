//
//  ArticleDetailWebView.swift
//  MediaApp
//

import Foundation
import SwiftUI

struct ArticleDetailWebView : View {
    
    var article: Article?
    
    var body : some View {
        VStack {
            if(article != nil) {
                ArticleWebView(url: URL(string: article?.link ?? "")!)
                    .navigationTitle(article?.title ?? "")
                    .navigationBarTitleDisplayMode(.inline)
            } else {
                Text("Link is missing")
            }
        }
    }
}
