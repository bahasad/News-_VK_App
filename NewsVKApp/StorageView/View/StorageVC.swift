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
    
    let layout = UICollectionViewFlowLayout.createLayout()
    
    private lazy var collectionView: UICollectionView = {
        $0.delegate = self
        $0.dataSource = self
        $0.register(CollectionViewCell.self, forCellWithReuseIdentifier: CollectionViewCell.reuseId)
        $0.register(StorageHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: StorageHeaderView.reuseId)
        return $0
    }(UICollectionView(frame: view.frame, collectionViewLayout: layout))

}

extension StorageVC: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        presenter?.fetchAllFavouriteNews().count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCell.reuseId, for: indexPath) as! CollectionViewCell
        let items = presenter?.fetchAllFavouriteNews()
        let item = items?[indexPath.row]
        cell.titleLabel.text = item?.title
        cell.descLabel.text = item?.desc
        cell.dateLabel.text = Utilities.formatDate(from: item?.publishedAt)
        cell.webSiteLabel.text = Utilities.extractDomain(from: item?.url)
        if let url = URL(string: item?.imageUrl ?? "") {
            cell.imageView.kf.setImage(with: url, placeholder: UIImage(named: "404notFound"))
        } else {
            cell.imageView.image = UIImage(named: "imageForPlaceholder")
        }
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

