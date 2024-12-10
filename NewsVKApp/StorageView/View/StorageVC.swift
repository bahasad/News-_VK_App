//
//  StorageVC.swift
//  NewsVKApp
//
//  Created by Baha Sadyr on 12/5/24.
//

import UIKit

protocol StorageVCProtocol: AnyObject {
    
}

class StorageVC: UIViewController, StorageVCProtocol {
    
    var presenter: StoragePresenterProtocol?
    
    
    let layout = UICollectionViewFlowLayout.createLayout()
    
    private lazy var collectionView: UICollectionView = {
        $0.delegate = self
        $0.dataSource = self
        $0.register(StorageCollectionViewCell.self, forCellWithReuseIdentifier: StorageCollectionViewCell.reuseId)
        $0.register(StorageHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: StorageHeaderView.reuseId)
        return $0
    }(UICollectionView(frame: view.frame, collectionViewLayout: layout))
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(collectionView)
        self.collectionView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        collectionView.reloadData()
    }
    
    
}

extension StorageVC:  UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        presenter?.fetchAllFavouriteNews().count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: StorageCollectionViewCell.reuseId, for: indexPath) as! StorageCollectionViewCell
        let items = presenter?.fetchAllFavouriteNews()
        let item = items?[indexPath.row]
        cell.titleLabel.text = item?.title
        cell.descLabel.text = item?.desc
        cell.dateLabel.text = Utilities.formatDate(from: item?.publishedAt)
        cell.webSiteLabel.text = Utilities.extractDomain(from: item?.url)
        cell.imageView.image = UIImage(systemName: "photo")
        let imageUrl = item?.imageUrl ?? ""
        presenter?.fetchImage(for: imageUrl) {  data in
            guard let imageData = data, let image = UIImage(data: imageData) else { return }
            cell.imageView.image = image
        }
        cell.delegate = self
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard kind == UICollectionView.elementKindSectionHeader else {
            fatalError("Wrong elemetn kind")
        }
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: StorageHeaderView.reuseId, for: indexPath) as! StorageHeaderView
        return header
    }
}
extension StorageVC: StorageCollectionViewCellDelegate {
    
    func didTapStarButton(on cell: StorageCollectionViewCell) {
        guard let indexPath = collectionView.indexPath(for: cell),
              let savedNews = presenter?.fetchAllFavouriteNews()[indexPath.row] else { return }
        presenter?.deleteFavouriteNews(newsItem: savedNews)
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
}

extension StorageVC: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let savedNews = presenter?.fetchAllFavouriteNews()[indexPath.row] else { return }
        let newsItem = NewsFeedItems(
            uuid: savedNews.id ?? "",
            title: savedNews.title ?? "",
            description: savedNews.desc ?? "",
            url: savedNews.url ?? "",
            imageUrl: savedNews.imageUrl ?? "",
            publishedAt: savedNews.publishedAt ?? ""
        )
        let detailsVC = NewsDetailsBuilder.build(newsItem: newsItem)
        navigationController?.pushViewController(detailsVC, animated: true)
    }
}
