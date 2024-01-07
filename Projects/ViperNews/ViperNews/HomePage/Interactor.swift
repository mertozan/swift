//
//  Interactor.swift
//  ViperNews
//
//  Created by Mert ÖZAN on 6.11.2023.
//

import Foundation


protocol AnyInteractor {
    
    var presenter : AnyPresenter? {get set}
    
    func downloadNews()
    
}

class NewsInteractor : AnyInteractor {
    
    var presenter: AnyPresenter?
    
    
    func downloadNews() {
        guard let url = URL(string: "https://newsapi.org/v2/everything?q=tesla&from=2023-11-29&sortBy=publishedAt&apiKey=027ed2bcd39c40d5a6639e7ff33189ca") else {
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                self.presenter?.interactorDidDownloadNews(result: .failure(NetworkError.NetworkFailed))
                return
            }
            do {
                let decoder = JSONDecoder()
                let newsResponse = try decoder.decode(News.self, from: data)
                let articles = newsResponse.articles
                self.presenter?.interactorDidDownloadNews(result: .success(articles))
            } catch {
                self.presenter?.interactorDidDownloadNews(result: .failure(NetworkError.ParsingFailed))
            }
        }
        task.resume()
        
    }
    
}
