//
//  VKFeedVC.swift
//  NewsVKApp
//
//  Created by Baha Sadyr on 12/5/24.
//

import UIKit

protocol VKFeedVCProtocol: AnyObject {
    func updateVKUserDetails(with data: [VKUserDataItems])
    func updateNewsFeed(with data: [VKWallItem])
    
}

class VKFeedVC: UIViewController, VKFeedVCProtocol {
    
    var presenter: VKFeedPresenterProtocol?
    
    let components = Components()
    
    private lazy var userImage = components.createImageView(contentMode: .scaleAspectFit, clipsToBounds: true, cornerRadius: 35/2)
    private lazy var userName = Components.label(size: 12, numberOfLines: 0, weight: .bold)
    private lazy var menuIcon = components.createBtnForMenuIcon(menu: createContextMenu())
    private lazy var headerLabel = Components.label(size: 34, weight: .bold)
    private lazy var activityIndicator = components.createActivityIndicator()
    private lazy var collectionView: UICollectionView = {
        $0.delegate = self
        $0.dataSource = self
        $0.register(VKFeedCollectionViewCell.self, forCellWithReuseIdentifier: VKFeedCollectionViewCell.reuseId)
        $0.isScrollEnabled = false
        return $0
    }(UICollectionView(frame: .zero, collectionViewLayout: components.setLayout()))
    private lazy var scrollView = components.createScrollView(frame: view.frame)
    private lazy var scrollContent = components.createView()
    private lazy var headerView = components.createView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        headerLabel.text = "Error Nil VK"
        
        getAllItems()
        addSubviews()
        setConstraints()
        presenter?.fetchVKWallNews()
        
        presenter?.vkWallItems?.forEach({ item in
            print(item.text)
        })
    }
    
    private func addSubviews() {
        view.addSubview(scrollView)
        view.addSubview(activityIndicator)
        scrollView.addSubview(scrollContent)
        
        [userImage, userName, menuIcon].forEach {
            headerView.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        [headerView, headerLabel, collectionView].forEach {
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
            
            headerView.topAnchor.constraint(equalTo: scrollContent.topAnchor),
            headerView.leadingAnchor.constraint(equalTo: scrollContent.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: scrollContent.trailingAnchor),
            headerView.bottomAnchor.constraint(equalTo: userImage.bottomAnchor, constant: 15),
            
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
        presenter?.fetchVKWallNews()
    }
    
    func updateNewsFeed(with data: [VKWallItem]) {
        print("Fetched \(data.count) news to display")
        DispatchQueue.main.async {
            self.components.hideLoadingIndicator(activityIndicator: self.activityIndicator, collectionView: self.collectionView)
            self.collectionView.reloadData()
            self.collectionView.layoutIfNeeded()
            self.updateCollectionViewHeight()
        }
    }
    
    private func updateCollectionViewHeight() {
        self.collectionViewHeightConstraint?.constant = self.collectionView.contentSize.height
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
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
    
    
}

extension VKFeedVC: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let count = presenter?.vkWallItems?.count ?? 0
        if count == 0 {
            print("No VK wall items available.")
        }
        return count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: VKFeedCollectionViewCell.reuseId, for: indexPath) as! VKFeedCollectionViewCell
        if let item = presenter?.vkWallItems?[indexPath.row] {
            cell.setCellData(item: item)
            if let imageUrl = item.attachments?.first?.video?.image?.first?.url {
                presenter?.fetchImage(for: imageUrl) { data in
                    guard let imageData = data, let image = UIImage(data: imageData) else { return }
                    DispatchQueue.main.async {
                        cell.imageView.image = image
                    }
                }
            } else {
                print("Image URL is nil for index: \(indexPath.row)")
            }
        }
        return cell
    }
    
    
}



