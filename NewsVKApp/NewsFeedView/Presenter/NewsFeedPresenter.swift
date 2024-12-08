//
//  NewsFeedPresenter.swift
//  NewsVKApp
//
//  Created by Baha Sadyr on 12/5/24.
//

import Foundation

protocol NewsFeedPresenterProtocol: AnyObject {
    init(view: NewsFeedVCProtocol, networkService: NetworkServiceProtocol, dataManager: DataManager)
    func getAllNews()
    func getNewsBySearchWord(searchWord: String)
    var news: [NewsFeedItems]? { get set }
    func handleStarButtonTap(for newsItem: NewsFeedItems)
    
    func deleteFavouriteNewsItem(newsItem: SavedNews)
    func saveFavouriteNews(newsItem: NewsFeedItems)
    
}

class NewsFeedPresenter: NewsFeedPresenterProtocol {
   
    weak var view: NewsFeedVCProtocol?
    let networkService: NetworkServiceProtocol
    var news: [NewsFeedItems]?
    let dataManager: DataManager
    
    required init(view: NewsFeedVCProtocol, networkService: any NetworkServiceProtocol, dataManager: DataManager) {
        self.view = view
        self.networkService = networkService
        self.dataManager = dataManager
        getAllNews()
    }
    
    func getAllNews() {
        Task {
            do {
                news = try await networkService.fetchAllNews()
                print("Fetched it: \(String(describing: news))")
                DispatchQueue.main.async { [weak self] in
                    self?.view?.updateNewsFeed(with: self?.news ?? [])
                }
            } catch CustomError.invalidURL {
                print("invalid URL")
            } catch CustomError.invalidResponse {
                print("invalid Response")
            } catch CustomError.invalidData {
                print("invalid Data")
            } catch {
                print("unexpected error")
            }
        }
    }
    
    func getNewsBySearchWord(searchWord: String) {
        Task {
            do {
                news = try await networkService.fetchNewsBySearchWord(searchWord: searchWord)
                print("Fetched it: \(String(describing: news))")
                DispatchQueue.main.async { [weak self] in
                    self?.view?.updateNewsFeed(with: self?.news ?? [])
                }
            } catch CustomError.invalidURL {
                print("invalid URL")
            } catch CustomError.invalidResponse {
                print("invalid Response")
            } catch CustomError.invalidData {
                print("invalid Data")
            } catch {
                print("unexpected error")
            }
        }
    }
    
    func handleStarButtonTap(for newsItem: NewsFeedItems) {
        //add logic for saving to array to save in core data
        print("Star button tapped in Presenter for news: \(newsItem.title)")
    }
  
}

extension NewsFeedPresenter {
    
    func deleteFavouriteNewsItem(newsItem: SavedNews) {
        newsItem.deleteFavouriteNews()
    }
    
    func saveFavouriteNews(newsItem: NewsFeedItems) {
        dataManager.saveNews(newsItem: newsItem)
    }
    
}
