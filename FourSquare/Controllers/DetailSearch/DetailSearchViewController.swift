//
//  DetailSearchViewController.swift
//  FourSquare
//
//  Created by Duy Linh on 12/16/16.
//  Copyright © 2016 Duy Linh. All rights reserved.
//

import UIKit

private let animationDuration: TimeInterval = 1
private let listLayoutStaticCellHeight: CGFloat = 96
private let gridLayoutStaticCellHeight: CGFloat = 235

class DetailSearchViewController: ViewController {
    
    // MARK: - Property
    @IBOutlet fileprivate weak var collectionView: UICollectionView!
    private lazy var searchBar = UISearchBar()
    private let menuStyleButtonFrame = CGRect(x: 0, y: 0, width: 25, height: 25)
    fileprivate let sectionInsetsDefault = UIEdgeInsets(top: 0, left: 1, bottom: 0, right: 1)
    fileprivate let sectionInsetsCollection = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    fileprivate var valueChangeStyle: Int = 1 {
        willSet {
            //navigationItem.rightBarButtonItem = nil
        }
        didSet {
            collectionView.reloadData()
        }
    }
    
    private lazy var listLayout = DisplaySwitchLayout(staticCellHeight: listLayoutStaticCellHeight, nextLayoutStaticCellHeight: gridLayoutStaticCellHeight, layoutState: .list)
    private lazy var gridLayout = DisplaySwitchLayout(staticCellHeight: gridLayoutStaticCellHeight, nextLayoutStaticCellHeight: listLayoutStaticCellHeight, layoutState: .grid)
    private var layoutState: LayoutState = .list
    var manuStyleButton = SwitchLayoutButton()

    // MARK: - Cycle Life
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func configureUI() {
        super.configureUI()
        self.configureNavigationItem()
        collectionView.registerNib(aClass: DefaultVenueCollectionViewCell.self)
        collectionView.registerNib(aClass: VenueCollectionViewCell.self)
        collectionView.collectionViewLayout = listLayout
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    // MARK: - Private Function
    private func configureNavigationItem() {
        //let manuStyleButton = UIButton(type: .custom)
        manuStyleButton.imageView?.contentMode = .scaleAspectFill
        manuStyleButton.setImage(#imageLiteral(resourceName: "StyleCollection"), for: UIControlState.normal)
        manuStyleButton.frame = menuButtonFrame
        manuStyleButton.addTarget(self, action: #selector(self.changeStyle), for: UIControlEvents.touchUpInside)
        let menuStyleBarButton = UIBarButtonItem(customView: manuStyleButton)
        navigationItem.rightBarButtonItem = menuStyleBarButton
        manuStyleButton.isSelected = layoutState == .list
        searchBar = UISearchBar()
        searchBar.placeholder = "Coffe & Tea"
        searchBar.sizeToFit()
        navigationItem.titleView = searchBar
    }
    
    @objc private func changeStyle() {
        switch self.valueChangeStyle {
        case 1:
            self.valueChangeStyle = 2
        case 2:
            self.valueChangeStyle = 1
        default:
            break
        }
        
        let transitionManager: TransitionManager
        if layoutState == .list {
            layoutState = .grid
            transitionManager = TransitionManager(duration: animationDuration, collectionView: collectionView!, destinationLayout: gridLayout, layoutState: layoutState)
        } else {
            layoutState = .list
            transitionManager = TransitionManager(duration: animationDuration, collectionView: collectionView!, destinationLayout: listLayout, layoutState: layoutState)
        }
        transitionManager.startInteractiveTransition()
        manuStyleButton.animationDuration = animationDuration
        manuStyleButton.isSelected = layoutState == .list
        
    }
}

// MARK: - UICollectionViewDataSource
extension DetailSearchViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if self.valueChangeStyle == 1 {
            guard let cell = collectionView.dequeue(aClass: DefaultVenueCollectionViewCell.self, forIndexPath: indexPath) else {return UICollectionViewCell()}
            return cell
        } else {
            guard let cell = collectionView.dequeue(aClass: VenueCollectionViewCell.self, forIndexPath: indexPath) else {return UICollectionViewCell()}
            return cell
        }
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension DetailSearchViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if self.valueChangeStyle == 1 {
            return CGSize(width: self.view.frame.width, height: 96)
        } else {
            let itemsPerRow: CGFloat = 2
            let paddingSpace = sectionInsetsCollection.left * (itemsPerRow + 1)
            let availableWidth = view.frame.width - paddingSpace
            let widthPerItem = availableWidth / itemsPerRow
            let heightViewInfo: CGFloat = 60
            let heightPerItem = widthPerItem * 3 / 4 + heightViewInfo
            return CGSize(width: widthPerItem, height: heightPerItem)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        if self.valueChangeStyle == 1 {
            return sectionInsetsDefault
        } else {
            return sectionInsetsCollection
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        if self.valueChangeStyle == 1 {
            return sectionInsetsDefault.left
        } else {
            return sectionInsetsCollection.left
        }
    }
}

// MARK: - UICollectionViewDelegate
extension DetailSearchViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, transitionLayoutForOldLayout fromLayout: UICollectionViewLayout, newLayout toLayout: UICollectionViewLayout) -> UICollectionViewTransitionLayout {
        let customTransitionLayout = TransitionLayout(currentLayout: fromLayout, nextLayout: toLayout)
        return customTransitionLayout
    }
}
