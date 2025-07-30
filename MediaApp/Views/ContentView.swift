//
//  ContentView.swift
//  MediaApp
//

import SwiftUI

struct ContentView: View {
    
    @State var searchTerm: String = ""
    @StateObject private var viewModel: ArticleViewModel
    
    init() {
        _viewModel = StateObject(wrappedValue: ArticleViewModel(url: ConstantsMedia.urlRss, parser: ArticleParser()))
    }
    
    var body: some View {
        NavigationStack {
            VStack(alignment: HorizontalAlignment.leading) {
                HStack {
                    Button("Refresh") {
                        viewModel.parseArticles()
                    }
                    .frame(minWidth: 44.0, maxHeight: CGFloat.infinity)
                    
                    TextField("Search", text: $searchTerm)
                        .frame(maxHeight: CGFloat.infinity)
                    
                    Button("Search") {
                        viewModel.filter(searchTerm: searchTerm)
                    }
                    .frame(minWidth: 44.0, maxHeight: CGFloat.infinity)
                }
                .frame(height: 60.0)
                
                if(viewModel.isLoading) {
                    ProgressView().progressViewStyle(CircularProgressViewStyle())
                } else {
                    List {
                        ForEach(0..<viewModel.articleList.count, id: \.self) { i in
                            if(i == 0) {
                                Section {
                                    NavigationLink {
                                        ArticleDetailView(article: viewModel.articleList[i])
                                    } label: {
                                        CardView(article: viewModel.articleList[i])
                                    }
                                }
                                .listRowBackground(LinearGradient(gradient: Gradient(colors: [.blue, .green.opacity(0.3)]), startPoint: .top, endPoint: .bottom))
                            } else {
                                NavigationLink {
                                    ArticleDetailView(article: viewModel.articleList[i])
                                } label: {
                                    CardView(article: viewModel.articleList[i])
                                }
                            }
                        }
                    }.listRowSpacing(4.0)
                }
            }
            .padding()
            .frame(maxHeight: CGFloat.infinity, alignment: Alignment.top)
        }.onAppear {
            self.viewModel.parseArticles()
        }
    }
}

#Preview {
    @Previewable @State var value = true
    @Previewable @State var searchState: String = ""
    @Previewable @State var viewModel: ArticleViewModel = ArticleViewModel(url: ConstantsMedia.urlRss, parser: ArticleParser())
    ContentView()
}
