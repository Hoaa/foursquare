//
//  MenuItemViewController.swift
//  FourSquare
//
//  Created by Duy Linh on 12/23/16.
//  Copyright © 2016 Duy Linh. All rights reserved.
//

import UIKit
import SVProgressHUD

let animationDuration: TimeInterval = 0.5
private let listLayoutStaticCellHeight: CGFloat = 80
private let cellPadding: CGFloat = 36.0
private let CellInfo: CGFloat = 62.0
private let gridLayoutStaticCellHeight: CGFloat = (UIScreen.main.bounds.width - cellPadding) / 3 + CellInfo

class MenuItemViewController: BaseViewController {
    
    // MARK: - Property
    @IBOutlet private(set) weak var venueCollectionView: UICollectionView?
    fileprivate var layoutState: LayoutState = .list
    fileprivate lazy var listLayout = DisplaySwitchLayout(staticCellHeight: listLayoutStaticCellHeight, nextLayoutStaticCellHeight: gridLayoutStaticCellHeight, layoutState: .list)
    fileprivate lazy var gridLayout = DisplaySwitchLayout(staticCellHeight: gridLayoutStaticCellHeight, nextLayoutStaticCellHeight: listLayoutStaticCellHeight, layoutState: .grid)
    
    // MARK: - Cycle Life
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
    }
    
    // MARK: - Public funtion
    func isChangeStyle() {
        let transitionManager: TransitionManager
        if layoutState == .list {
            layoutState = .grid
            transitionManager = TransitionManager(duration: animationDuration, collectionView: venueCollectionView!, destinationLayout: gridLayout, layoutState: layoutState)
        } else {
            layoutState = .list
            transitionManager = TransitionManager(duration: animationDuration, collectionView: venueCollectionView!, destinationLayout: listLayout, layoutState: layoutState)
        }
        transitionManager.startInteractiveTransition()
    }
    
    // MARK: - Private function
    private func setupCollectionView() {
        venueCollectionView?.backgroundColor = Color.Gray246
        venueCollectionView?.registerNib(aClass: VenueItemCollectionViewCell.self)
        venueCollectionView?.collectionViewLayout = listLayout
        venueCollectionView?.dataSource = self
        venueCollectionView?.delegate = self
    }
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
        let cell = collectionView.dequeue(aClass: VenueItemCollectionViewCell.self, forIndexPath: indexPath)
        if self.layoutState == .grid {
            cell.setupGridLayoutConstraints(1, cellWidth: cell.frame.width)
        } else {
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
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if scrollView.contentOffset.y < -80.0 {
            SVProgressHUD.setDefaultAnimationType(.native)
            SVProgressHUD.show()
        }
    }
}
