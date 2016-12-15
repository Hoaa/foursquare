//
//  ListViewController.swift
//  FourSquare
//
//  Created by Duy Linh on 12/14/16.
//  Copyright © 2016 Duy Linh. All rights reserved.
//
import UIKit

class ListViewController: UIViewController {

    // MARK: - Property
    @IBOutlet weak var topView: NSLayoutConstraint!
    @IBOutlet weak var collectionView: UICollectionView!
    let sectionInsets = UIEdgeInsets(top: 10, left: 10, bottom: 5, right: 10)
    var changeStyle: Int = 1 {
        willSet {
            navigationItem.rightBarButtonItem = nil
        }
        didSet {
            switch changeStyle {
            case 1:
                addRightBarButtonItemDefaultStyle()
                collectionView.reloadData()
            case 2:
                addRightBarButtonItemCollectionStyle()
                collectionView.reloadData()
            case 3:
                addRightBarButtonItemMapStyle()
                topView.constant = 500
            default:
                break
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
        addRightBarButtonItemDefaultStyle()
    }

    private func configureUI() {
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
        collectionView.register(UINib(nibName: "ListDefaultCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CellDefault")
        collectionView.register(UINib(nibName: "ListCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CellCollection")
    }
    
    private func addRightBarButtonItemDefaultStyle() {
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "Collection"), style: .done, target: self, action: #selector(changeViewAction))
    }
    
    private func addRightBarButtonItemCollectionStyle() {
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "Collection"), style: .done, target: self, action: #selector(changeViewAction))
    }

    private func addRightBarButtonItemMapStyle() {
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "Collection"), style: .done, target: self, action: #selector(changeViewAction))
    }

    @objc private func changeViewAction() {
        switch self.changeStyle {
        case 1:
            self.changeStyle = 2
        case 2:
            self.changeStyle = 3
        case 3:
            self.changeStyle = 1
            self.topView.constant = 0
        default:
            break
        }
    }

}

// MARK: - UICollectionViewDataSource
extension ListViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if self.changeStyle == 1 {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CellDefault", for: indexPath) as? ListDefaultCollectionViewCell else {return UICollectionViewCell()}
            return cell
        } else if self.changeStyle == 2 {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CellCollection", for: indexPath) as? ListCollectionViewCell else {return UICollectionViewCell()}
            return cell
        } else {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CellCollection", for: indexPath) as? ListCollectionViewCell else {return UICollectionViewCell()}
            return cell
        }
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension ListViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if self.changeStyle == 1 {
            let height = (self.view.frame.size.width - 20) * 3 / 4 + 44 + 130
            return CGSize(width: self.view.frame.size.width - 20, height: height)
        } else if self.changeStyle == 2 {
            let itemsPerRow: CGFloat = 2
            let paddingSpace = sectionInsets.left * (itemsPerRow + 1)
            let availableWidth = view.frame.width - paddingSpace
            let widthPerItem = availableWidth / itemsPerRow
            let heightPerItem = widthPerItem * 3 / 4 + 44 + 60
            return CGSize(width: widthPerItem, height: heightPerItem)
        } else {
            return CGSize(width: 0, height: 0)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsets
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInsets.left
    }
}
