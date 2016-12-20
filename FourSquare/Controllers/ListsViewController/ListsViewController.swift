//
//  ListsViewController.swift
//  FourSquare
//
//  Created by nmint8m on 15.12.16.
//  Copyright © 2016 Duy Linh. All rights reserved.
//

import UIKit

class ListsViewController: ViewController {
    
    fileprivate let numberOfSectionsOfTableView = 3
    fileprivate let heightForHeaderInSection: CGFloat = 44
    fileprivate let heightForRow: CGFloat = 180
    fileprivate var myData: [(name: String, items: Any)] = []
    
    fileprivate var featureView: FeatureView!
    fileprivate var yourPlacesView: YourPlacesView!
    fileprivate var youCreatedView: YouCreatedView!
    
    @IBOutlet private weak var containerTableView: UITableView!
    
    // MARK: - Override func
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        configureFeatureView()
        configureYourPlacesView()
        configureYouCreatedView()
    }
    
    override func loadData() {
        // Feature data
        var itemsOfFeature: [(title: String, description: String)] = []
        for _ in 0...4 {
            let item = (title: "Feature place name", description: "Description about this feature")
            itemsOfFeature.append(item)
        }
        let feature = (name: "Feature", items: itemsOfFeature as Any)
        myData.append(feature)
        
        // Your places data
        var itemsOfYourPlaces: [(name: String, places: [Int])] = []
        let itemMySavedPlaces = (name: "My saved places", places: [1, 2, 3, 4, 5])
        itemsOfYourPlaces.append(itemMySavedPlaces)
        let itemMyLikedPlaces = (name: "My liked places", places: [1, 2])
        itemsOfYourPlaces.append(itemMyLikedPlaces)
        let yourPlaces = (name: "Your places", items: itemsOfYourPlaces as Any)
        myData.append(yourPlaces)
        
        // Lists you created data
        var itemsOfListsYouCreated: [(name: String, places: [Int])] = []
        let itemDaNangPlaces = (name: "DaNang places", places: [1, 2, 3])
        itemsOfListsYouCreated.append(itemDaNangPlaces)
        let listsYouCreated = (name: "Lists you created", items: itemsOfListsYouCreated as Any)
        myData.append(listsYouCreated)
    }
    
    override func configureUI() {
        configureContainerTableView()
    }
    
    // MARK: Private func
    private func configureContainerTableView() {
        // Register
        let nibForSectionHeader = UINib(nibName: "ListsSectionHeaderTableViewCell", bundle: nil)
        containerTableView.register(nibForSectionHeader, forCellReuseIdentifier: "ListsSectionHeaderTableViewCell")
        
        // DataSource and delegate
        containerTableView.dataSource = self
        containerTableView.delegate = self
    }
    
    // MARK: - Fileprivate func
    private func configureFeatureView() {
        featureView.frame = CGRect(x: 0, y: 0, width: self.view.bounds.width, height: heightForRow)
        featureView.configureView()
        featureView.datasource = self
        featureView.delegate = self
    }
    
    private func configureYourPlacesView() {
        yourPlacesView.frame = CGRect(x: 0, y: 0, width: self.view.bounds.width, height: heightForRow)
        yourPlacesView.configureView()
        yourPlacesView.datasource = self
        yourPlacesView.delegate = self
    }
    
    private func configureYouCreatedView() {
        youCreatedView.frame = CGRect(x: 0, y: 0, width: self.view.bounds.width, height: heightForRow)
        youCreatedView.configureView()
        youCreatedView.datasource = self
        youCreatedView.delegate = self
    }
}

extension ListsViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return numberOfSectionsOfTableView
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return 1
        case 2:
            return 1
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let featureViewCell = UITableViewCell()
            if featureView == nil {
                featureView = Bundle.main.loadNibNamed("FeatureView", owner: self, options: nil)?[0] as? FeatureView
            }
            featureViewCell.addSubview(featureView)
            return featureViewCell
        case 1:
            let yourPlacesViewCell = UITableViewCell()
            if yourPlacesView == nil {
                yourPlacesView = Bundle.main.loadNibNamed("YourPlacesView", owner: self, options: nil)?[0] as? YourPlacesView
            }
            yourPlacesViewCell.addSubview(yourPlacesView)
            return yourPlacesViewCell
        case 2:
            let youCreatedViewCell = UITableViewCell()
            if youCreatedView == nil {
                youCreatedView = Bundle.main.loadNibNamed("YouCreatedView", owner: self, options: nil)?[0] as? YouCreatedView
            }
            youCreatedViewCell.addSubview(youCreatedView)
            return UITableViewCell()
        default:
            return UITableViewCell()
        }
    }
}

extension ListsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return heightForRow
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let listsSectionHeaderTableViewCell = tableView.dequeueReusableCell(withIdentifier: "ListsSectionHeaderTableViewCell") as? ListsSectionHeaderTableViewCell else { return UITableViewCell() }
        listsSectionHeaderTableViewCell.headerNameLabel.text = myData[section].name
        return listsSectionHeaderTableViewCell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return heightForHeaderInSection
    }
}

extension ListsViewController: FeatureViewDataSource, YourPlacesViewDataSource, YouCreatedViewDataSource {
    func numberOfSections(_ view: UIView, collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ view: UIView, collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if view.isMember(of: FeatureView.self) {
            if let itemsOfFeature = myData[0].items as? [(title: String, description: String)] {
                return itemsOfFeature.count
            }
        } else if view.isMember(of: YourPlacesView.self) {
            if let itemsOfYourPlaces = myData[1].items as? [(name: String, places: [Int])] {
                return itemsOfYourPlaces.count
            }
        } else {
            if let itemsOfYourPlaces = myData[2].items as? [(name: String, places: [Int])] {
                return itemsOfYourPlaces.count + 1
            } else {
                return 1
            }
        }
        return 0
    }
    
    func collectionView(_ view: UIView, collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if view.isMember(of: FeatureView.self) {
            guard let featureCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "FeatureCollectionViewCell", for: indexPath) as? FeatureCollectionViewCell else { return UICollectionViewCell() }
            if let itemsOfFeature = myData[0].items as? [(title: String, description: String)] {
                featureCollectionViewCell.featureImageView.image = #imageLiteral(resourceName: "Picture_Landscape_100")
                featureCollectionViewCell.featureNameLabel.text = itemsOfFeature[indexPath.row].title
                featureCollectionViewCell.featureDescriptionLabel.text = itemsOfFeature[indexPath.row].description
            }
            return featureCollectionViewCell
        } else if view.isMember(of: YourPlacesView.self) {
            guard let yourPlacesCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "ListsItemCollectionViewCell", for: indexPath) as? ListsItemCollectionViewCell else { return UICollectionViewCell() }
            if let itemsOfYourPlaces = myData[1].items as? [(name: String, places: [Int])] {
                yourPlacesCollectionViewCell.typeLabel.text = itemsOfYourPlaces[indexPath.row].name
                if itemsOfYourPlaces[indexPath.row].places.count == 0 {
                    yourPlacesCollectionViewCell.numberPlacesLabel.text = "Nothing was saved"
                } else if itemsOfYourPlaces[indexPath.row].places.count == 1 {
                    yourPlacesCollectionViewCell.numberPlacesLabel.text = "There is 1 place"
                } else {
                    yourPlacesCollectionViewCell.numberPlacesLabel.text = "There are \(itemsOfYourPlaces[indexPath.row].places.count) places"
                }
            }
            return yourPlacesCollectionViewCell
        } else {
//            if indexPath.row == 0 {
//                guard let createANewListCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "CreateAListCollectionViewCell", for: indexPath) as? CreateAListCollectionViewCell else { return UICollectionViewCell() }
//                return createANewListCollectionViewCell
//            } else {
                guard let youCreatedCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "ListsItemCollectionViewCell", for: indexPath) as? ListsItemCollectionViewCell else { return UICollectionViewCell() }
                if let itemsOfYourPlaces = myData[1].items as? [(name: String, places: [Int])] {
                    youCreatedCollectionViewCell.typeLabel.text = itemsOfYourPlaces[indexPath.row].name
                    if itemsOfYourPlaces[indexPath.row].places.count == 0 {
                        youCreatedCollectionViewCell.numberPlacesLabel.text = "Nothing was saved"
                    } else if itemsOfYourPlaces[indexPath.row].places.count == 1 {
                        youCreatedCollectionViewCell.numberPlacesLabel.text = "There is 1 place"
                    } else {
                        youCreatedCollectionViewCell.numberPlacesLabel.text = "There are \(itemsOfYourPlaces[indexPath.row].places.count) places"
                    }
                }
                return youCreatedCollectionViewCell
//            }
        }
    }
}

extension ListsViewController: FeatureViewDelegate, YourPlacesViewDelegate, YouCreatedViewDelegate {
    func collectionView(_ view: UIView, collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if view.isMember(of: FeatureView.self) {
            print("Selecting...")
        } else if view.isMember(of: YourPlacesView.self) {
            print("Selecting,,,")
        } else {
            if indexPath.row == 0 {
                print("Create a new list")
            } else {
                print("Selecting~~~")
            }
        }
        
    }
}
