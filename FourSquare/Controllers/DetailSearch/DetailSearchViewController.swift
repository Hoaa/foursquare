//
//  DetailSearchViewController.swift
//  FourSquare
//
//  Created by Duy Linh on 12/16/16.
//  Copyright © 2016 Duy Linh. All rights reserved.
//

import UIKit

private let animationDuration: TimeInterval = 0.5
private let listLayoutStaticCellHeight: CGFloat = 80
private let gridLayoutStaticCellHeight: CGFloat = (UIScreen.main.bounds.width - 26) / 3 + 64

class DetailSearchViewController: ViewController {
    
    // MARK: - Property
    @IBOutlet fileprivate weak var collectionView: UICollectionView!
    private lazy var searchBar = UISearchBar()
    private let menuStyleButtonFrame = CGRect(x: 0, y: 0, width: 25, height: 25)
    fileprivate var layoutState: LayoutState = .list
    fileprivate var isTransitionAvailable = true
    fileprivate var manuStyleButton = SwitchLayoutButton()
    fileprivate lazy var listLayout = DisplaySwitchLayout(staticCellHeight: listLayoutStaticCellHeight, nextLayoutStaticCellHeight: gridLayoutStaticCellHeight, layoutState: .list)
    fileprivate lazy var gridLayout = DisplaySwitchLayout(staticCellHeight: gridLayoutStaticCellHeight, nextLayoutStaticCellHeight: listLayoutStaticCellHeight, layoutState: .grid)
    
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
        collectionView.collectionViewLayout = listLayout
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    // MARK: - Private Function
    private func configureNavigationItem() {
        manuStyleButton.isSelected = true
        manuStyleButton.frame = menuStyleButtonFrame
        manuStyleButton.awakeFromNib()
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
        if !isTransitionAvailable {
            return
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
        let cell = collectionView.dequeue(aClass: DefaultVenueCollectionViewCell.self, forIndexPath: indexPath)
        if self.layoutState == .grid {
            cell.setupGridLayoutConstraints(1, cellWidth: cell.frame.width)
        } else if self.layoutState == .list {
            cell.setupListLayoutConstraints(1, cellWidth: cell.frame.width)
        }
        print(cell.frame.width)
        print("width: \(cell.imageVenue.frame.width) + height: \(cell.imageVenue.frame.height)")
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension DetailSearchViewController: UICollectionViewDelegateFlowLayout {
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        if self.valueChangeStyle == 1 {
//            return CGSize(width: self.view.frame.width, height: 80)
//        } else {
//            let itemsPerRow: CGFloat = 2
//            let paddingSpace = sectionInsetsCollection.left * (itemsPerRow + 1)
//            let availableWidth = view.frame.width - paddingSpace
//            let widthPerItem = availableWidth / itemsPerRow
//            let heightViewInfo: CGFloat = 60
//            let heightPerItem = widthPerItem * 3 / 4 + heightViewInfo
//            return CGSize(width: widthPerItem, height: heightPerItem)
//        }
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
//        if self.valueChangeStyle == 1 {
//            return sectionInsetsDefault
//        } else {
//            return sectionInsetsCollection
//        }
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
//        if self.valueChangeStyle == 1 {
//            return sectionInsetsDefault.left
//        } else {
//            return sectionInsetsCollection.left
//        }
//    }
}

// MARK: - UICollectionViewDelegate
extension DetailSearchViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, transitionLayoutForOldLayout fromLayout: UICollectionViewLayout, newLayout toLayout: UICollectionViewLayout) -> UICollectionViewTransitionLayout {
        let customTransitionLayout = TransitionLayout(currentLayout: fromLayout, nextLayout: toLayout)
        return customTransitionLayout
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        isTransitionAvailable = false
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        isTransitionAvailable = true
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        view.endEditing(true)
    }
}
