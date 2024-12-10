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
    
    private lazy var headerLabel: UILabel = {
        $0.font = UIFont.systemFont(ofSize: 34, weight: .bold)
        $0.text = "Новости"
        $0.numberOfLines = 0
        return $0
    }(UILabel())
    
    private lazy var activityIndicator: UIActivityIndicatorView = {
        $0.color = .gray
        $0.hidesWhenStopped = true
        return $0
    }(UIActivityIndicatorView(style: .large))
    
    private lazy var collectionView: UICollectionView = {
        $0.delegate = self
        $0.dataSource = self
        $0.register(CollectionViewCell.self, forCellWithReuseIdentifier: CollectionViewCell.reuseId)
        return $0
    }(UICollectionView(frame: .zero, collectionViewLayout: setLayout()))
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        getAllItems()
        addSubviews()
        setConstraints()
        
    }
    
    private func addSubviews() {
        [ userImage, userName, menuIcon, searchBar, headerLabel, collectionView, activityIndicator ].forEach {
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
            
            headerLabel.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 25),
            headerLabel.leadingAnchor.constraint(equalTo: searchBar.leadingAnchor),
            headerLabel.trailingAnchor.constraint(equalTo: searchBar.trailingAnchor),
            
            collectionView.topAnchor.constraint(equalTo: headerLabel.bottomAnchor, constant: 25),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -25),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
    }
    
    private func getAllItems() {
        showLoadingIndicator()
        presenter?.getAllNews()
        presenter?.news?.forEach({ item in
            print(item.title)
            print(item.description)
        })
    }
    
    func searchBarBookmarkButtonClicked(_ searchBar: UISearchBar) {
        print("Microphone button tapped!")
    }
    
    func setLayout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = 10
        layout.minimumLineSpacing = 20
        layout.sectionInset = UIEdgeInsets(top: 10 , left: 10, bottom: 10, right: 10)
        //layout.itemSize = CGSize(width: 100, height: 500)
        let screenWidth = UIScreen.main.bounds.width
        let cellWidth = (screenWidth - 50)
        layout.itemSize = CGSize(width: cellWidth, height: 500)
        
        return layout
    }
    
    private func showLoadingIndicator() {
        DispatchQueue.main.async {
            self.activityIndicator.startAnimating()
            self.collectionView.isHidden = true
        }
    }
    
    private func hideLoadingIndicator() {
        DispatchQueue.main.async {
            self.activityIndicator.stopAnimating()
            self.collectionView.isHidden = false
        }
    }
}

extension NewsFeedVC: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print("Search text updated: \(searchText)")
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let searchText = searchBar.text {
            showLoadingIndicator()
            presenter?.getNewsBySearchWord(searchWord: searchText)
        }
        searchBar.resignFirstResponder()
    }
    
}

extension NewsFeedVC {
    
    func updateNewsFeed(with data: [NewsFeedItems]) {
        print("Fetched \(data.count) news to display")
        DispatchQueue.main.async {
            self.hideLoadingIndicator()
            self.collectionView.reloadData()
        }
    }
}

extension NewsFeedVC: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let count = presenter?.news?.count ?? 0
        if count == 0 {
            print("No news available.")
        }
        return count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCell.reuseId, for: indexPath) as! CollectionViewCell
        if let item = presenter?.news?[indexPath.row] {
            cell.setCellData(item: item)
            let imageUrl = item.imageUrl
            presenter?.fetchImage(for: imageUrl) {  data in
                guard let imageData = data, let image = UIImage(data: imageData) else { return }
                cell.imageView.image = image
            }
            cell.starBtn.isBookmarked = presenter?.fetchAllFavouriteNews().contains(where: {$0.id == item.uuid}) ?? false
        }
        cell.delegate = self
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let selectedNewsItem = presenter?.news?[indexPath.row] else { return }
        let detailsVC = NewsDetailsBuilder.build(newsItem: selectedNewsItem)
        navigationController?.pushViewController(detailsVC, animated: true)
    }
    
    
}
extension NewsFeedVC: CollectionViewCellDelegate {
    func didTapStarButton(on cell: CollectionViewCell) {
        guard let indexPath = collectionView.indexPath(for: cell) else { return }
        guard let newsItem = presenter?.news?[indexPath.row] else { return }
        print("Star btn tapped in View Controller for news: \(newsItem.title)")
        //here i need to pass this event to presenter
        presenter?.handleStarButtonTap(for: newsItem)
        //here I need to toggle state of the star btn
        let isBookmarked = cell.starBtn.isBookmarked
        cell.starBtn.isBookmarked = !isBookmarked
    }
}
//scrollview, - to do item (for the whole page to be scrollabel, not only the collection view!


