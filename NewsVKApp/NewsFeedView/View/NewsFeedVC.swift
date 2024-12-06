//
//  NewsFeedVC.swift
//  NewsVKApp
//
//  Created by Baha Sadyr on 12/5/24.
//

import UIKit

protocol NewsFeedVCProtocol: AnyObject {
    func updateNewsFeed(with data: [NewsFeedItems])
}

class NewsFeedVC: UIViewController, NewsFeedVCProtocol {
    
    var presenter: NewsFeedPresenterProtocol?
    let userNameSigned = "Имя пользователя"
    
    private lazy var userImage: UIImageView = {
        $0.contentMode = .scaleAspectFit
        $0.clipsToBounds = true
        $0.backgroundColor = .lightGray
        $0.layer.cornerRadius = 35 / 2
        return $0
    }(UIImageView())
    
    private lazy var userName: UILabel = {
        $0.font = UIFont.systemFont(ofSize: 12, weight: .bold)
        $0.text = userNameSigned
        $0.numberOfLines = 0
        return $0
    }(UILabel())
    
    private lazy var menuIcon: UIImageView = {
        $0.contentMode = .scaleAspectFit
        $0.clipsToBounds = true
        $0.image = UIImage(named: "menuIcon")
        return $0
    }(UIImageView())
    
    private lazy var searchBar: UISearchBar = {
        $0.placeholder = "Search"
        $0.searchBarStyle = .minimal
        $0.delegate = self
        $0.showsBookmarkButton = true
        if let micImage = UIImage(systemName: "mic.fill") {
            $0.setImage(micImage, for: .bookmark, state: .normal)
        }
        let searchTextField = $0.searchTextField
        searchTextField.backgroundColor = .appColorLightGray
        searchTextField.layer.cornerRadius = 10
        searchTextField.clipsToBounds = true
        if let backgroundView = $0.subviews.first?.subviews.first(where: { $0 is UIImageView }) {
            backgroundView.isHidden = true
        }
        searchTextField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            searchTextField.leadingAnchor.constraint(equalTo: $0.leadingAnchor, constant: 0),
            searchTextField.trailingAnchor.constraint(equalTo: $0.trailingAnchor, constant: 0),
            searchTextField.topAnchor.constraint(equalTo: $0.topAnchor, constant: 0),
            searchTextField.bottomAnchor.constraint(equalTo: $0.bottomAnchor, constant: 0)
        ])
        return $0
    }(UISearchBar())
    
    private lazy var collectionView: UICollectionView = {
        
        return $0
    }(UICollectionView())



    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        //        presenter?.getAllNews()
        //        print(presenter?.news?.count as Any)
        //        presenter?.news?.forEach({ item in
        //            print(item.title)
        //            print(item.imageUrl)
        //            print(item.url)
        //        })
        
        addSubviews()
        setConstraints()
    }
    
    private func addSubviews() {
        [userImage, userName, menuIcon, searchBar].forEach {
            view.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            
            userImage.widthAnchor.constraint(equalToConstant: 35),
            userImage.heightAnchor.constraint(equalToConstant: 35),
            userImage.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25),
            userImage.centerYAnchor.constraint(equalTo: menuIcon.centerYAnchor),
            
            menuIcon.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -25),
            menuIcon.widthAnchor.constraint(equalToConstant: 24),
            menuIcon.heightAnchor.constraint(equalToConstant: 24),
            menuIcon.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            
            userName.leadingAnchor.constraint(equalTo: userImage.trailingAnchor, constant: 10),
            userName.trailingAnchor.constraint(equalTo: menuIcon.leadingAnchor, constant: -10),
            userName.centerYAnchor.constraint(equalTo: userImage.centerYAnchor),
            
            searchBar.topAnchor.constraint(equalTo: userImage.bottomAnchor, constant: 15),
            searchBar.leadingAnchor.constraint(equalTo: userImage.leadingAnchor),
            searchBar.trailingAnchor.constraint(equalTo: menuIcon.trailingAnchor),
            searchBar.heightAnchor.constraint(equalToConstant: 40),
            
        ])
    }
    
    func searchBarBookmarkButtonClicked(_ searchBar: UISearchBar) {
        print("Microphone button tapped!")
    }
    
}

extension NewsFeedVC: UISearchBarDelegate {

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print("Search text updated: \(searchText)")
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let searchText = searchBar.text {
            presenter?.getNewsBySearchWord(searchWord: searchText)
        }
        searchBar.resignFirstResponder()
    }

}

extension NewsFeedVC {
    func updateNewsFeed(with data: [NewsFeedItems]) {
        print("Received \(data.count) news items to display.")
        //reload  collection view  when it implemented
    }
}


