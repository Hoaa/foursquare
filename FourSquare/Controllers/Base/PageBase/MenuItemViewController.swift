//
//  MenuItemViewController.swift
//  FourSquare
//
//  Created by Duy Linh on 12/23/16.
//  Copyright © 2016 Duy Linh. All rights reserved.
//

import UIKit

private let animationDuration: TimeInterval = 0.5
private let listLayoutStaticCellHeight: CGFloat = 80
private let cellPadding: CGFloat = 36.0
private let CellInfo: CGFloat = 62.0
private let gridLayoutStaticCellHeight: CGFloat = (UIScreen.main.bounds.width - cellPadding) / 3 + CellInfo

class MenuItemViewController: BaseViewController {
    
    // MARK: - Property
    @IBOutlet private(set) weak var venueCollectionView: UICollectionView?
    fileprivate var layoutState: LayoutState = .list
    fileprivate var isTransitionAvailable = true
    fileprivate lazy var listLayout = DisplaySwitchLayout(staticCellHeight: listLayoutStaticCellHeight, nextLayoutStaticCellHeight: gridLayoutStaticCellHeight, layoutState: .list)
    fileprivate lazy var gridLayout = DisplaySwitchLayout(staticCellHeight: gridLayoutStaticCellHeight, nextLayoutStaticCellHeight: listLayoutStaticCellHeight, layoutState: .grid)
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    override func changeStyle(sender: AnyObject) {
        super.changeStyle(sender: sender)
        if !isTransitionAvailable {
            return
        }
        let transitionManager: TransitionManager
        if layoutState == .list {
            layoutState = .grid
            transitionManager = TransitionManager(duration: animationDuration, collectionView: venueCollectionView!, destinationLayout: gridLayout, layoutState: layoutState)
        } else {
            layoutState = .list
            transitionManager = TransitionManager(duration: animationDuration, collectionView: venueCollectionView!, destinationLayout: listLayout, layoutState: layoutState)
        }
        transitionManager.startInteractiveTransition()
        //gridButton = animationDuration
        //gridButton = layoutState == .list
    }
    
    // MARK: - Private function
    private func setupCollectionView() {
        venueCollectionView?.backgroundColor = Color.LightGray246
        venueCollectionView?.registerNib(aClass: DefaultVenueCollectionViewCell.self)
        venueCollectionView?.collectionViewLayout = listLayout
        venueCollectionView?.dataSource = self
        venueCollectionView?.delegate = self
    }
    
    // MARK: - Public funtion
    
}


// MARK: - UICollectionViewDataSource
extension MenuItemViewController: UICollectionViewDataSource {
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
        return cell
    }
}

// MARK: - UICollectionViewDelegate
extension MenuItemViewController: UICollectionViewDelegate {
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
