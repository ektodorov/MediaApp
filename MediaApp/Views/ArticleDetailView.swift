//
//  ArticleDetailView.swift
//  MediaApp
//

import Foundation
import SwiftUI

struct ArticleDetailView : View {
    
    var article: Article?
    
    var body : some View {
        NavigationStack {
            VStack(alignment: HorizontalAlignment.leading) {
                CardView(article: article)
                
                NavigationLink {
                    ArticleDetailWebView(article: article)
                } label: {
                    Text("Read Now")
                        .padding()
                }
                
                Link("Read in Browser", destination: URL(string: article?.link ?? "")!)
                    .padding()
            }.frame(maxHeight: CGFloat.infinity, alignment: Alignment.top)
        }
    }
}

#Preview {
    ArticleDetailView(article:
                        Article(
                            title: "Title",
                            descriptionArticle: "Description",
                            link:"https://www.lemonde.fr/afrique/article/2025/07/10/au-senegal-la-liberte-d-expression-mise-a-mal-par-la-multiplication-des-delits-d-opinion_6620458_3212.html",
                            mediaContent: "https://img.lemde.fr/2025/07/02/689/0/5416/2708/644/322/60/0/3fffbed_upload-1-apsafndlajpu-000-48nk4t2.jpg",
                            mediaCredit: "Credit"))
}
