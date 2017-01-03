//
//  TipWithImageDetailViewController.swift
//  FourSquare
//
//  Created by nmint8m on 23.12.16.
//  Copyright © 2016 Duy Linh. All rights reserved.
//

import UIKit

class TipWithImageDetailViewController: ViewController {
    
    // MARK: - Properties
    var tip: (username: String, datePost: Date, comment: String, commentImage: UIImage)!
    private var isLoadDone = false
    // MARK: - Outlet
    @IBOutlet private weak var imageContainerScrollView: UIScrollView!
    @IBOutlet fileprivate weak var imageView: UIImageView!
    @IBOutlet private weak var imageViewLeadingConstraint: NSLayoutConstraint!
    @IBOutlet private weak var imageViewTopConstraint: NSLayoutConstraint!
    @IBOutlet private weak var imageViewTrailingConstraint: NSLayoutConstraint!
    @IBOutlet private weak var imageViewBottomConstraint: NSLayoutConstraint!
    @IBOutlet private weak var tipInforContainerView: UIView!
    @IBOutlet private weak var usernameLabel: UILabel!
    @IBOutlet private weak var postDateLabel: UILabel!
    @IBOutlet private weak var commentLabel: UITextView!
    
    fileprivate var viewSize: CGSize {
        return self.view.bounds.size
    }
    
    fileprivate var imageSize: CGSize {
        return tip.commentImage.size
    }
    
    fileprivate var imageViewSize: CGSize {
        return imageView.frame.size
    }
    // MARK: - Override func
    override func viewDidLoad() {
        super.viewDidLoad()
        configureImageView()
        imageContainerScrollView.delegate = self
        
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        updateMinZoomScaleForSize(size: viewSize)
        updateConstraintsForSize(size: viewSize)
    }
    
    override func loadData() {
        super.loadData()
    }
    
    override func configureUI() {
        super.configureUI()
    }
    
    // MARK: - Private func
    
    private func configureImageView() {
        imageView.image = tip.commentImage
        imageView.frame.size = tip.commentImage.size
    }
    
    private func updateMinZoomScaleForSize(size: CGSize) {
        let minScale = min(size.width / imageSize.width, size.height / imageSize.height)
        imageContainerScrollView.minimumZoomScale = minScale
        imageContainerScrollView.maximumZoomScale = 1.0
        imageContainerScrollView.zoomScale = minScale
    }
    
    fileprivate func updateConstraintsForSize(size: CGSize) {
        let xOffset = max(0, (size.width - imageViewSize.width) / 2)
        imageViewLeadingConstraint.constant = xOffset
        imageViewTrailingConstraint.constant = xOffset
        let yOffset = max(0, (size.height - imageViewSize.height) / 2 )
        imageViewTopConstraint.constant = yOffset
        imageViewBottomConstraint.constant = yOffset
        view.layoutIfNeeded()
    }
    
    // MARK: - Action
    @IBAction func dismissTipViewController(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
}

extension TipWithImageDetailViewController: UIScrollViewDelegate {
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return self.imageView
    }
    
    func scrollViewDidZoom(_ scrollView: UIScrollView) {
        UIView.animate(withDuration: 0.1, animations: {
            self.updateConstraintsForSize(size: self.viewSize)
        }, completion: nil)
    }
}
