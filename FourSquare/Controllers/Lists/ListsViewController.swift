//
//  ListsViewController.swift
//  FourSquare
//
//  Created by nmint8m on 15.12.16.
//  Copyright © 2016 Duy Linh. All rights reserved.
//

import UIKit

class ListsViewController: ViewController {
    
    // MARK: - Properties
    fileprivate var features: [(featureName: String, image: UIImage)] = []
    fileprivate var yourLikedPlaces: (quantity: Int, images: [UIImage])!
    fileprivate var yourSavedPlace: (quantity: Int, images: [UIImage])!
    fileprivate var yourCreatedList: [(listName: String, quantity: Int, images: [UIImage])] = []
    
    fileprivate let numberItemsInLine = 2
    fileprivate var featureSize: CGSize!
    fileprivate var listsItemSize: CGSize!
    fileprivate let itemInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    fileprivate let featureReuseIdentifier = "FeatureCollectionViewCell"
    fileprivate let yourCreatedReuseIdentifier = "YouCreatedListsCollectionViewCell"
    fileprivate let createNewListReuseIdentifier = "CreateNewListCollectionViewCell"
    
    private var isLoadDone = false
    
    // MARK: - Outlet
    @IBOutlet fileprivate weak var featureCollectionView: UICollectionView!
    @IBOutlet private weak var likedPlacesLabel: UILabel!
    @IBOutlet private weak var savedPlacesLabel: UILabel!
    @IBOutlet private weak var yourCreatedCollectionViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet fileprivate weak var youCreatedListsCollectionView: UICollectionView!
    
    // MARK: - Override func
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if isLoadDone {
            return
        }
        isLoadDone = !isLoadDone
        configureItemSize()
        configureFeatureCollectionView()
        configureYouCreatedCollectionView()
    }
    
//    override func viewDidLayoutSubviews() {
//        
//    }
    
    override func loadData() {
        super.loadData()
        // Feature data
        features = [(featureName: "Most popular", image: #imageLiteral(resourceName: "Feature_Like")),
                    (featureName: "Save money", image: #imageLiteral(resourceName: "Feature_Rate")),
                    (featureName: "Rate most", image: #imageLiteral(resourceName: "Feature_Price"))]
        
        // Your places data
        yourLikedPlaces = (quantity: 1, images: [#imageLiteral(resourceName: "Feature_Like")])
        yourSavedPlace = (quantity: 1, images: [#imageLiteral(resourceName: "Feature_Like"), #imageLiteral(resourceName: "Feature_Price")])
        
        // Lists you created data
        yourCreatedList = [(listName: "Da Nang", quantity: 2, images: [#imageLiteral(resourceName: "Feature_Like"), #imageLiteral(resourceName: "Feature_Rate")]),
                            (listName: "Da Nang", quantity: 4, images: [#imageLiteral(resourceName: "Feature_Like"), #imageLiteral(resourceName: "Feature_Price"), #imageLiteral(resourceName: "Feature_Price")]),
                            (listName: "Da Nang", quantity: 3, images: [#imageLiteral(resourceName: "Feature_Like"), #imageLiteral(resourceName: "Feature_Rate"), #imageLiteral(resourceName: "Feature_Price")]),
                            (listName: "Da Nang", quantity: 3, images: [#imageLiteral(resourceName: "Feature_Like"), #imageLiteral(resourceName: "Feature_Rate")]),]
    }
    
    override func configureUI() {
        super.configureUI()
        self.title = "Lists"
    }
    
    // MARK: Private func
    private func configureItemSize() {
        let viewSize = self.view.bounds.size
        let width = viewSize.width / CGFloat(numberItemsInLine) - itemInset.left * (1 + 1 / CGFloat(numberItemsInLine))
        featureSize = CGSize(width: viewSize.width, height: 180)
        listsItemSize = CGSize(width: width , height: 180)
    }
    
    private func configureFeatureCollectionView() {
        // Register
        let nibForFeatureCollectionView = UINib(nibName: featureReuseIdentifier, bundle: nil)
        featureCollectionView.register(nibForFeatureCollectionView, forCellWithReuseIdentifier: featureReuseIdentifier)
        
        // DataSource and delegate
        featureCollectionView.dataSource = self
        featureCollectionView.delegate = self
    }

    private func configureYouCreatedCollectionView() {
        // Height
        let numberItems = yourCreatedList.count + 1
        var lines = numberItems / numberItemsInLine
        if numberItems % yourCreatedList.count != 0 {
            lines = lines + 1
        }
        let height = CGFloat(lines) * listsItemSize.height + CGFloat(lines + 1) * itemInset.top
        yourCreatedCollectionViewHeightConstraint.constant = height
        
        // Register
        let nibForYourCreatedCollectionView1 = UINib(nibName: yourCreatedReuseIdentifier, bundle: nil)
        youCreatedListsCollectionView.register(nibForYourCreatedCollectionView1, forCellWithReuseIdentifier: yourCreatedReuseIdentifier)
        
        let nibForYourCreatedCollectionView2 = UINib(nibName: createNewListReuseIdentifier, bundle: nil)
        youCreatedListsCollectionView.register(nibForYourCreatedCollectionView2, forCellWithReuseIdentifier: createNewListReuseIdentifier)
        
        // DataSource and delegate
        youCreatedListsCollectionView.dataSource = self
        youCreatedListsCollectionView.delegate = self
    }
}

extension ListsViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == featureCollectionView {
            return features.count
        } else {
            return yourCreatedList.count + 1
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == featureCollectionView {
            guard let featureCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: featureReuseIdentifier, for: indexPath) as? FeatureCollectionViewCell else { return UICollectionViewCell() }
            featureCollectionViewCell.featureImageView.image = features[indexPath.row].image
            featureCollectionViewCell.featureNameLabel.text = features[indexPath.row].featureName
            return featureCollectionViewCell
        } else if collectionView == youCreatedListsCollectionView {
            // The last cell of youCreatedCollectionView is CreateAListCollectionViewCell, another cells is YouCreatedListsCollectionViewCell
            if indexPath.row == yourCreatedList.count {
//                let cell = CreateAListCollectionViewCell()
                guard let createdNewListsCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: createNewListReuseIdentifier, for: indexPath) as? CreateNewListCollectionViewCell
                    else { return UICollectionViewCell() }
                return createdNewListsCollectionViewCell
            } else {
                guard let yourCreatedListsCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: yourCreatedReuseIdentifier, for: indexPath) as? YouCreatedListsCollectionViewCell else { return UICollectionViewCell() }
                yourCreatedListsCollectionViewCell.typeLabel.text = yourCreatedList[indexPath.row].listName
                yourCreatedListsCollectionViewCell.numberPlacesLabel.text = "\(yourCreatedList[indexPath.row].quantity)"
                return yourCreatedListsCollectionViewCell
            }
        } else {
            return UICollectionViewCell()
        }
    }
}

extension ListsViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let listDetailVC = ListDetailViewController(nibName: "ListDetailViewController", bundle: nil)
        self.navigationController?.pushViewController(listDetailVC, animated: true)
    }
}

extension ListsViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == featureCollectionView {
            return featureSize
        } else {
            return listsItemSize
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        if collectionView == featureCollectionView {
            return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        } else {
            return itemInset
        }
    }
}