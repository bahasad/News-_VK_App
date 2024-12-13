//
//  NewsFeedVC.swift
//  NewsVKApp
//
//  Created by Baha Sadyr on 12/5/24.
//

import UIKit
import Kingfisher

protocol NewsFeedVCProtocol: AnyObject {
    
    func updateNewsFeed(with data: [NewsFeedItems])
    func updateVKUserDetails(with data: [VKUserDataItems])
}

class NewsFeedVC: UIViewController, NewsFeedVCProtocol {
    
    
    var presenter: NewsFeedPresenterProtocol?
    let components = Components()
    
    private lazy var userImage = components.createImageView(contentMode: .scaleAspectFit, clipsToBounds: true, cornerRadius: 35/2)
    private lazy var userName = Components.label(size: 12, numberOfLines: 0, weight: .bold)
    private lazy var menuIcon = components.createBtnForMenuIcon(menu: createContextMenu())
    private lazy var headerLabel = Components.label(size: 34, weight: .bold)
    private lazy var activityIndicator = components.createActivityIndicator()
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
        $0.delegate = self
        $0.dataSource = self
        $0.register(CollectionViewCell.self, forCellWithReuseIdentifier: CollectionViewCell.reuseId)
        $0.isScrollEnabled = false
        return $0
    }(UICollectionView(frame: .zero, collectionViewLayout: setLayout()))
    private lazy var scrollView = components.createScrollView(frame: view.frame)
    private lazy var scrollContent = components.createView()
    private lazy var headerView = components.createView()
    private lazy var refreshControl = UIRefreshControl()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        headerLabel.text = "Новости"
        getAllItems()
        addSubviews()
        setConstraints()
        setupRefreshControl()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        collectionView.reloadData()
    }

    private func addSubviews() {
        
        view.addSubview(scrollView)
        view.addSubview(activityIndicator)
        scrollView.addSubview(scrollContent)
        
        [ userImage, userName, menuIcon, searchBar].forEach {
            headerView.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        [ headerView, headerLabel, collectionView ].forEach {
            scrollContent.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    
    
    private var collectionViewHeightConstraint: NSLayoutConstraint?
    
    private func setConstraints() {
        collectionViewHeightConstraint = collectionView.heightAnchor.constraint(equalToConstant: 0)
        collectionViewHeightConstraint?.isActive = true
        
        NSLayoutConstraint.activate([
            
            userImage.widthAnchor.constraint(equalToConstant: 35),
            userImage.heightAnchor.constraint(equalToConstant: 35),
            userImage.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 25),
            userImage.topAnchor.constraint(equalTo: headerView.topAnchor, constant: 10),
            
            menuIcon.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: -25),
            menuIcon.widthAnchor.constraint(equalToConstant: 24),
            menuIcon.heightAnchor.constraint(equalToConstant: 24),
            menuIcon.centerYAnchor.constraint(equalTo: userImage.centerYAnchor),
            
            userName.leadingAnchor.constraint(equalTo: userImage.trailingAnchor, constant: 10),
            userName.trailingAnchor.constraint(equalTo: menuIcon.leadingAnchor, constant: -10),
            userName.centerYAnchor.constraint(equalTo: userImage.centerYAnchor),
            
            searchBar.topAnchor.constraint(equalTo: userImage.bottomAnchor, constant: 15),
            searchBar.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 25),
            searchBar.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: -25),
            searchBar.heightAnchor.constraint(equalToConstant: 40),
            
            headerView.topAnchor.constraint(equalTo: scrollContent.topAnchor),
            headerView.leadingAnchor.constraint(equalTo: scrollContent.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: scrollContent.trailingAnchor),
            headerView.bottomAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 15),
            
            headerLabel.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 20),
            headerLabel.leadingAnchor.constraint(equalTo: scrollContent.leadingAnchor, constant: 25),
            headerLabel.trailingAnchor.constraint(equalTo: scrollContent.trailingAnchor, constant: -25),
            
            collectionView.topAnchor.constraint(equalTo: headerLabel.bottomAnchor, constant: 20),
            collectionView.leadingAnchor.constraint(equalTo: scrollContent.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: scrollContent.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: scrollContent.bottomAnchor),
            
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            scrollContent.topAnchor.constraint(equalTo: scrollView.topAnchor),
            scrollContent.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            scrollContent.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            scrollContent.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            scrollContent.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
    
    private func createContextMenu() -> UIMenu {
        let logOutAction = UIAction(title: "Log Out", image: UIImage(systemName: "arrow.backward")) { [weak self] _ in
            self?.handleLogOut()
        }
        
        let settingsAction = UIAction(title: "Settings", image: UIImage(systemName: "gearshape")) { _ in
            print("Settings")
        }
        
        let editProfileAction = UIAction(title: "Edit Profile", image: UIImage(systemName: "person.crop.circle")) { _ in
            print("Edit Profile")
        }
        return UIMenu(title: "", children: [editProfileAction, settingsAction, logOutAction])
    }
    
    private func handleLogOut() {
        
        let alertController = UIAlertController(title: "Выйти", message: "Хотите выйти из профиля?", preferredStyle: .alert)
        
        let confirmation = UIAlertAction(title: "Да", style: .destructive) { [weak self] _ in
            print("Log out selected")
            UserDefaults.standard.set(false, forKey: "isLogin")
            print("user defaults for isLogin set to false")
            self?.presenter?.deleteTokenFromKeychain()
            NotificationCenter.default.post(name: Notification.Name(rawValue: "routeVC"), object: nil, userInfo: ["vc": WindowCase.login])
        }
        
        let cancelAction = UIAlertAction(title: "Назад", style: .cancel, handler: nil)
        
        alertController.addAction(confirmation)
        alertController.addAction(cancelAction)
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    
    private func getAllItems() {
        components.showLoadingIndicator(activityIndicator: self.activityIndicator, collectionView: self.collectionView)
        presenter?.getAllNews()
    }
    
    func searchBarBookmarkButtonClicked(_ searchBar: UISearchBar) {
        print("Microphone button tapped!")
    }
    
    func setLayout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = 10
        layout.minimumLineSpacing = 20
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width - 50, height: 500)
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        return layout
    }
    
    
    //
    //    func setLayout() -> UICollectionViewFlowLayout {
    //        let layout = UICollectionViewFlowLayout()
    //        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
    //        layout.minimumLineSpacing = 10
    //        layout.minimumInteritemSpacing = 10
    //        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    //        return layout
    //    }
    
    
    private func setupRefreshControl() {
        self.scrollView.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(handleRefreshOnScrollView), for: .valueChanged)
    }
    
    @objc func handleRefreshOnScrollView() {
        presenter?.clearImageCache()
        presenter?.getAllNews()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [weak self] in
            self?.refreshControl.endRefreshing()
        }
    }
    
}

extension NewsFeedVC: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print("Search text updated: \(searchText)")
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let searchText = searchBar.text {
            components.showLoadingIndicator(activityIndicator: activityIndicator, collectionView: collectionView)
            presenter?.getNewsBySearchWord(searchWord: searchText)
        }
        searchBar.resignFirstResponder()
    }
    
}

extension NewsFeedVC {
    
    func updateNewsFeed(with data: [NewsFeedItems]) {
        print("Fetched \(data.count) news to display")
        DispatchQueue.main.async {
            self.components.hideLoadingIndicator(activityIndicator: self.activityIndicator, collectionView: self.collectionView)
            self.refreshControl.endRefreshing()
            self.collectionView.reloadData()
            self.collectionView.layoutIfNeeded()
            self.updateCollectionViewHeight()
        }
    }
    func updateVKUserDetails(with data: [VKUserDataItems]) {
        DispatchQueue.main.async {
            self.userName.text = (data.first?.firstName ?? "") + " " + (data.first?.lastName ?? "")
            if let photoURLString = data.first?.photo200, let photoURL = URL(string: photoURLString) {
                self.userImage.kf.setImage(
                    with: photoURL,
                    placeholder: UIImage(named: "noPhoto"),
                    options: [
                        .transition(.fade(0.2)),
                        .cacheOriginalImage
                    ],
                    progressBlock: { receivedSize, totalSize in
                        print("Loading progress: \(receivedSize) / \(totalSize)")
                    },
                    completionHandler: { result in
                        switch result {
                        case .success(let value):
                            print("Successfully loaded image: \(value.image)")
                        case .failure(let error):
                            print("Failed to load image: \(error.localizedDescription)")
                        }
                    }
                )
            } else {
                print("No photo URL available")
                self.userImage.image = UIImage(named: "noPhoto")
            }
        }
    }
    
    private func updateCollectionViewHeight() {
        self.collectionViewHeightConstraint?.constant = self.collectionView.contentSize.height
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
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




