//
//  ListViewController.swift
//  FourSquare
//
//  Created by Duy Linh on 12/14/16.
//  Copyright © 2016 Duy Linh. All rights reserved.
//

import UIKit

class ListDefaultViewController: UIViewController {
    
    // MARK: - Property
    @IBOutlet weak var collectionView: UICollectionView!
    let sectionInsets = UIEdgeInsets(top: 10, left: 10, bottom: 5, right: 10)
    var changeView: Bool = true {
        willSet {
            self.navigationItem.rightBarButtonItem = nil
        }
        didSet {
            if changeView {
                addRightBarButtonItem()
                collectionView.reloadData()
            } else {
                addRightBarButtonItem()
                collectionView.reloadData()
            }
        }
    }

    // MARK: - Cycle Life
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationBar()
        configureUI()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Private Function
    private func configureNavigationBar() {
        navigationItem.title = Strings.MainMenuListTitle
        navigationController?.navigationBar.titleTextAttributes =
            [NSForegroundColorAttributeName : UIColor.white]
        navigationController?.navigationBar.barTintColor =
            UIColor(red: 0, green: 153/255, blue: 255/255, alpha: 1)
        addRightBarButtonItem()
    }

    private func configureUI() {
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
        collectionView.register(UINib(nibName: "ListDefaultCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CellDefault")
        collectionView.register(UINib(nibName: "ListCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CellCollection")
    }
    
    private func addRightBarButtonItem() {
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "Collection"), style: .done, target: self, action: #selector(changeViewAction))
    }
    
    @objc private func changeViewAction() {
        self.changeView = !self.changeView
    }
}

// MARK: - UICollectionViewDataSource
extension ListDefaultViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if self.changeView {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CellDefault", for: indexPath) as? ListDefaultCollectionViewCell else {return UICollectionViewCell()}
            return cell
        } else {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CellCollection", for: indexPath) as? ListCollectionViewCell else {return UICollectionViewCell()}
            return cell
        }
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension ListDefaultViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if self.changeView {
            let height = (self.view.frame.size.width - 20) * 3 / 4 + 44 + 130
            return CGSize(width: self.view.frame.size.width - 20, height: height)
        } else {
            let itemsPerRow: CGFloat = 2
            let paddingSpace = sectionInsets.left * (itemsPerRow + 1)
            let availableWidth = view.frame.width - paddingSpace
            let widthPerItem = availableWidth / itemsPerRow
            let heightPerItem = widthPerItem * 3 / 4 + 44 + 60
            return CGSize(width: widthPerItem, height: heightPerItem)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsets
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInsets.left
    }
}
