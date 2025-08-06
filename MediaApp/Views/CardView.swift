//
//  CardView.swift
//  MediaApp
//

import Foundation
import SwiftUI


struct CardView : View {
    
    var article: Article?
    
    var body: some View {
        VStack {
            HStack {
                AsyncImage(url: URL(string: article?.mediaContent ?? "")) { phase in
                    switch phase {
                    case .empty:
                        ProgressView()
                    case .success(let image):
                        image.resizable()
                    case .failure(let error):
                        Image(systemName: "photo")
                    @unknown default:
                        Image(systemName: "photo")
                    }
                }
                .scaledToFit()
                .frame(width: 100, height: 100)
            }
            .frame(maxWidth: CGFloat.infinity, alignment: Alignment.leading)
            Text(article?.title ?? "")
                .frame(maxWidth: CGFloat.infinity, alignment: Alignment.leading)
            Text(article?.descriptionArticle ?? "")
                .frame(maxWidth: CGFloat.infinity, alignment: Alignment.leading)
            Text(article?.link ?? "")
                .frame(maxWidth: CGFloat.infinity, alignment: Alignment.leading)
            Text(article?.mediaCredit ?? "")
                .frame(maxWidth: CGFloat.infinity, alignment: Alignment.leading)
            Text(article?.pubDate ?? "")
                .frame(maxWidth: CGFloat.infinity, alignment: Alignment.leading)
        }
        .padding(0.0)
        .frame(maxWidth: CGFloat.infinity,
               alignment: Alignment.leading)
    }
}

#Preview {
    CardView(article: Article(title: "Title",
                              descriptionArticle: "Description",
                              link: "Link",
                              mediaContent: "https://img.lemde.fr/2025/07/02/689/0/5416/2708/644/322/60/0/3fffbed_upload-1-apsafndlajpu-000-48nk4t2.jpg",
                              mediaCredit: "Credit"))
}
