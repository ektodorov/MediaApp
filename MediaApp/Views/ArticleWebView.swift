//
//  ArticleWebView.swift
//  MediaApp
//

import Foundation
import SwiftUI
import WebKit

struct ArticleWebView: UIViewRepresentable {
    let url: URL
    
    init(url: URL) {
        self.url = url
    }
    
    func makeUIView(context: Context) -> some UIView {
        let webView = WKWebView()
        webView.load(URLRequest(url: url))
        
        return webView
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {}
}

