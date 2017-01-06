//
//  VenueDetailViewController.swift
//  FourSquare
//
//  Created by nmint8m on 22.12.16.
//  Copyright © 2016 Duy Linh. All rights reserved.
//

import UIKit
import GoogleMaps
import SDWebImage
import SVPullToRefresh

class VenueDetailViewController: ViewController {
    
    // MARK: - Properties
    var venue: Venue!
    private var isLoadDone = false
    private var isRefreshingDataVenue = false
    private var isLoadingMoreTips = false
    private var mapView: GMSMapView!
    fileprivate var currentLocation: CLLocation?
    fileprivate let defaultLocation = CLLocation(latitude: 16.0762723, longitude: 108.2221608)
    fileprivate var offset = 0
    fileprivate var limit = 10
    
    // MARK: - Outlet
    @IBOutlet private weak var imagesContainerView: UIView!
    @IBOutlet private weak var numberOfRatingsLabel: UILabel!
    @IBOutlet private weak var rateColorView: UIView!
    @IBOutlet private weak var rateLabel: UILabel!
    @IBOutlet private weak var saveButtonImageView: UIImageView!
    @IBOutlet private weak var likeButtonImageView: UIImageView!
    @IBOutlet private weak var mapContainerView: UIView!
    @IBOutlet private weak var venueInforContainerView: UIView!
    @IBOutlet private weak var venueNameLabel: UILabel!
    @IBOutlet private weak var venueAddressLabel: UILabel!
    @IBOutlet private weak var venuePriceLabel: UILabel!
    @IBOutlet private weak var venueCategoryLabel: UILabel!
    @IBOutlet private weak var tipTableView: UITableView!
    
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
        configureTipTableView()
    }
    
    override func loadData() {
        super.loadData()
        
        VenueDetailService.loadVenueDetail(venueID: venue.id) { (success, error) in
            self.reloadVenueDetail()
            
            VenueTipsService.loadVenueTips(venueID: self.venue.id, sort: "recent", offset: self.offset, limit: self.limit, completion: { (success, error) in
                self.reloadVenueTips()
            })
        }
    }
    
    override func configureUI() {
        super.configureUI()
        self.navigationItem.hidesBackButton = true
        let backButton = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(back))
        self.navigationItem.leftBarButtonItem = backButton
        rateColorView.conerRadiusWith(value: 5)
    }
    
    // MARK: - Private func
    
    // This func is only called after pulling to refresh
    private func refreshData() {
        if isRefreshingDataVenue {
            self.tipTableView.pullToRefreshView.stopAnimating()
            return
        }
        isRefreshingDataVenue = true
        // Clear all data of venue before refresh
        RealmManager.sharedInstance.deleteAllVenuePhotos(venueID: venue.id)
        RealmManager.sharedInstance.deleteAllVenueTips(venueID: venue.id)
        
        offset = 0
        self.tipTableView.showsInfiniteScrolling = true
        
        VenueDetailService.loadVenueDetail(venueID: venue.id) { (success, error) in
            self.reloadVenueDetail()
            self.isRefreshingDataVenue = false
            VenueTipsService.loadVenueTips(venueID: self.venue.id, sort: "recent", offset: self.offset, limit: self.limit, completion: { (success, error) in
                self.reloadVenueTips()
                self.tipTableView.pullToRefreshView.stopAnimating()
            })
        }
    }
    
    // This func is called in func loadData() and refreshDataVenue()
    private func reloadVenueDetail() {
        venue = RealmManager.sharedInstance.getVenueDetail(id: venue.id)
        configureImagesContainerView()
        configureVenueInforContainerView()
        configGoogleMapView()
    }
    
    // This func is called in func loadData() and refreshDataVenue()
    private func reloadVenueTips() {
        venue = RealmManager.sharedInstance.getVenueDetail(id: venue.id)
        tipTableView.reloadData()
    }
    
    // This func is only called when loading more
    private func loadMoreTips() {
        VenueTipsService.loadVenueTips(venueID: venue.id, sort: "recent", offset: offset, limit: limit, completion: { (success, error) in
            var indexPath: [IndexPath] = []
            if self.offset > self.venue.tips.count{
                self.tipTableView.infiniteScrollingView.stopAnimating()
                return
            }
            for i in self.offset..<self.venue.tips.count {
                indexPath.append(IndexPath(row: i, section: 0))
            }
            self.tipTableView.insertRows(at: indexPath, with: .fade)
            self.tipTableView.infiniteScrollingView.stopAnimating()
        })
    }
    
    private func configureImagesContainerView() {
        var count = 0
        let imageSize = CGSize(width: imagesContainerView.bounds.width / 3, height: imagesContainerView.bounds.height)
        for i in 0..<venue.photos.count {
            if let url = venue.photos[i].venuePhotoURL {
                let frame = CGRect(x: imageSize.width * CGFloat(count), y: 0, width: imageSize.width, height: imageSize.height)
                let imageView = UIImageView(frame: frame)
                imageView.contentMode = .scaleAspectFill
                imageView.clipsToBounds = true
                imageView.sd_setImage(with: url)
                imagesContainerView.addSubview(imageView)
                count += 1
            }
            if count == 3 {
                break
            }
        }
    }
    
    private func configureVenueInforContainerView() {
        rateColorView.backgroundColor = venue.ratingColor
        rateLabel.text = "\(venue.rating)"
        numberOfRatingsLabel.text = "Base on \(venue.ratingSignals) ratings"
        venueNameLabel.text = venue.name
        venueAddressLabel.text = venue.location?.address
        venuePriceLabel.text = venue.price?.showCurrency()
        venueCategoryLabel.text = venue.getCategoriesName()
    }
    
    private func configGoogleMapView() {
        if let location = venue.location {
            let camera = GMSCameraPosition.camera(withLatitude: location.latitude,
                                                  longitude: location.longitude,
                                                  zoom: 15)
            let frame = CGRect(x: mapContainerView.bounds.width / 2, y: 0, width: mapContainerView.bounds.width / 2, height: mapContainerView.bounds.height)
            mapView = GMSMapView.map(withFrame: frame, camera: camera)
            
            let whiteColor = UIColor(red: 254, green: 254, blue: 254, alpha: 1)
            let whiteTransColor = UIColor(red: 254, green: 254, blue: 254, alpha: 0)
            mapView.applyGradientLayerHorizontal(firstColor: whiteColor, secondColor: whiteTransColor)
            let views = mapContainerView.subviews
            for view in views {
                view.removeFromSuperview()
            }
            mapContainerView.addSubview(mapView)
            
            let marker = GMSMarker()
            marker.position = CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude)
            marker.appearAnimation = kGMSMarkerAnimationPop
            marker.map = mapView
        }
    }
    
    private func configureTipTableView() {
        // Self-sizing table view cell
        tipTableView.rowHeight = UITableViewAutomaticDimension
        tipTableView.estimatedRowHeight = 150
        
        // Register
        let nibForTipTableView = UINib(nibName: "TipTableViewCell", bundle: nil)
        tipTableView.register(nibForTipTableView, forCellReuseIdentifier: "TipTableViewCell")
        
        // Datasource and Delegate
        tipTableView.dataSource = self
        tipTableView.delegate = self
        
        // Set up refresh and load more control
        tipTableView.addPullToRefresh(actionHandler: {
            self.refreshData()
        })
        
        tipTableView.addInfiniteScrolling(actionHandler: {
            if self.offset <= self.venue.tips.count {
                self.offset += self.limit
                self.loadMoreTips()
            } else {
                self.tipTableView.showsInfiniteScrolling = false
            }
        })
    }
    
    @objc private func back() {
        RealmManager.sharedInstance.deleteAllVenuePhotos(venueID: venue.id)
        RealmManager.sharedInstance.deleteAllVenueTips(venueID: venue.id)
        _ = self.navigationController?.popViewController(animated: true)
    }
    
    // MARK: - Action
    @IBAction func saveVenue(_ sender: UIButton) {
        if saveButtonImageView.image == #imageLiteral(resourceName: "Save_Gray_100") {
            saveButtonImageView.image = #imageLiteral(resourceName: "Save_Green_100")
        } else {
            saveButtonImageView.image = #imageLiteral(resourceName: "Save_Gray_100")
        }
    }
    
    @IBAction func likeVenue(_ sender: UIButton) {
        if likeButtonImageView.image == #imageLiteral(resourceName: "Like_Gray_100") {
            likeButtonImageView.image = #imageLiteral(resourceName: "Like_Pink_100")
        } else {
            likeButtonImageView.image = #imageLiteral(resourceName: "Like_Gray_100")
        }
    }
    
    @IBAction func leaveATipOfVenue(_ sender: UIButton) {
    }
    
    @IBAction func showDirection(_ sender: UIButton) {
        let mapDirectionViewController = MapDirectionViewController(nibName: "MapDirectionViewController", bundle: nil)
        mapDirectionViewController.venue = venue
        self.navigationController?.pushViewController(mapDirectionViewController, animated: true)    }
}

extension VenueDetailViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return venue.tips.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let tipTableViewCell = tableView.dequeueReusableCell(withIdentifier: "TipTableViewCell", for: indexPath) as? TipTableViewCell
            else { return UITableViewCell() }
        if let url = venue.tips[indexPath.row].userAvatarURL {
            tipTableViewCell.userImageView.sd_setImage(with: url)
        }
        tipTableViewCell.usernameLabel.text = venue.tips[indexPath.row].userFullName
        tipTableViewCell.postDateLabel.text = "\(venue.tips[indexPath.row].createdAt)"
        tipTableViewCell.commentLabel.text = venue.tips[indexPath.row].text
        if let url = venue.tips[indexPath.row].tipPhotoURL {
            tipTableViewCell.commentImageView.sd_setImage(with: url)
            tipTableViewCell.commentImageViewHeightConstraint.constant = 167.5
        } else {
            tipTableViewCell.commentImageViewHeightConstraint.constant = 0
        }
        return tipTableViewCell
    }
}

extension VenueDetailViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let _ = venue.tips[indexPath.row].tipPhotoURL {
            let tipWithImageDetailViewController = TipWithImageDetailViewController(nibName: "TipWithImageDetailViewController", bundle: nil)
            tipWithImageDetailViewController.tip = venue.tips[indexPath.row]
            self.navigationController?.present(tipWithImageDetailViewController, animated: true, completion: nil)
        }
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
}
