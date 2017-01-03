//
//  VenueDetailViewController.swift
//  FourSquare
//
//  Created by nmint8m on 22.12.16.
//  Copyright © 2016 Duy Linh. All rights reserved.
//

import UIKit
import GoogleMaps

class VenueDetailViewController: ViewController {
    
    // MARK: - Properties
    fileprivate var tips: [(userAvatar: UIImage?, username: String, datePost: Date, comment: String, commentImage: UIImage?)] = []
    private var isLoadDone = false
    private var mapView: GMSMapView!
    var currentLocation: CLLocation?
//    var placesClient: GMSPlacesClient!
    // A default location to use when location permission is not granted.
    let defaultLocation = CLLocation(latitude: 16.0762723, longitude: 108.2221608)
    
    // MARK: - Outlet
    @IBOutlet private weak var imagesContainerView: UIView!
    @IBOutlet private weak var numberOfRatingsLabel: UILabel!
    @IBOutlet private weak var rateColorImageView: UIImageView!
    @IBOutlet private weak var rateLabel: UILabel!
    @IBOutlet private weak var saveButtonImageView: UIImageView!
    @IBOutlet private weak var likeButtonImageView: UIImageView!
    @IBOutlet private weak var mapContainerView: UIView!
    @IBOutlet private weak var venueInforContainerView: UIView!
    @IBOutlet private weak var venueNameLabel: UILabel!
    @IBOutlet private weak var venueAddressLabel: UILabel!
    @IBOutlet private weak var venuePriceLabel: UILabel!
    @IBOutlet private weak var venueCategoryLabel: UILabel!
    @IBOutlet private weak var venuePhoneNumberLabel: UILabel!
    @IBOutlet private weak var tipTableView: UITableView!
    
    // MARK: - Override func
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if isLoadDone {
            return
        }
        isLoadDone = !isLoadDone
        configureImagesContainerView()
        configureVenueInforContainerView()
        configGoogleMapView()
        addVenueToGoogleMapView()
        configureTipTableView()
    }
    
    override func loadData() {
        super.loadData()
        tips = [(userAvatar: #imageLiteral(resourceName: "Feature_Price"), username: "Tam Tinh te", datePost: Date(), comment: "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, pretium quis, sem. Nulla consequat massa quis enim. Donec pede justo, fringilla vel, aliquet nec, vulputate eget, arcu. In enim justo, rhoncus ut, imperdiet a, venenatis vitae, justo. Nullam dictum felis eu pede mollis pretium. Integer tincidunt. Cras dapibus. Vivamus elementum semper nisi. Aenean vulputate eleifend tellus.", commentImage: #imageLiteral(resourceName: "523159398")),
                (userAvatar: #imageLiteral(resourceName: "Feature_Price"), username: "Tam Tinh te", datePost: Date(), comment: "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. ", commentImage: #imageLiteral(resourceName: "Feature_Rate")),
                (userAvatar: #imageLiteral(resourceName: "Feature_Price"), username: "Tam Tinh te", datePost: Date(), comment: "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. ", commentImage: nil),
                (userAvatar: #imageLiteral(resourceName: "Feature_Price"), username: "Tam Tinh te", datePost: Date(), comment: "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. ", commentImage: nil),
                (userAvatar: #imageLiteral(resourceName: "Feature_Price"), username: "Tam Tinh te", datePost: Date(), comment: "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. ", commentImage: #imageLiteral(resourceName: "Feature_Like")),
                (userAvatar: #imageLiteral(resourceName: "Feature_Price"), username: "Tam Tinh te", datePost: Date(), comment: "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. ", commentImage: nil),
                (userAvatar: #imageLiteral(resourceName: "Feature_Price"), username: "Tam Tinh te", datePost: Date(), comment: "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Donec pede justo, fringilla vel, aliquet nec, vulputate eget, arcu. In enim justo, rhoncus ut, imperdiet a, venenatis vitae, justo. Nullam dictum felis eu pede mollis pretium. Integer tincidunt. Cras dapibus. Vivamus elementum semper nisi. Aenean vulputate eleifend tellus.", commentImage: nil)]
    }
    
    override func configureUI() {
        super.configureUI()
    }
    
    // MARK: - Private func
    private func configureVenueInforContainerView() {
    }
    
    private func configureImagesContainerView() {
        var count = 0
        let imageSize = CGSize(width: imagesContainerView.bounds.width / 3, height: imagesContainerView.bounds.height)
        for i in 0..<tips.count {
            if tips[i].commentImage != nil {
                let frame = CGRect(x: imageSize.width * CGFloat(count), y: 0, width: imageSize.width, height: imageSize.height)
                let imageView = UIImageView(frame: frame)
                imageView.contentMode = .scaleAspectFill
                imageView.clipsToBounds = true
                imageView.image = tips[i].commentImage
                imagesContainerView.addSubview(imageView)
                count += 1
            }
            if count == 3 {
                break
            }
        }
    }
    
    private func configGoogleMapView() {
//        placesClient = GMSPlacesClient.shared()
        let camera = GMSCameraPosition.camera(withLatitude: defaultLocation.coordinate.latitude,
                                              longitude: defaultLocation.coordinate.longitude,
                                              zoom: 15)
        mapView = GMSMapView.map(withFrame: self.view.bounds, camera: camera)
        let firstColor = UIColor(red: 254, green: 254, blue: 254, alpha: 1)
        let secondColor = UIColor(red: 254, green: 254, blue: 254, alpha: 0)
        mapView.applyGradientLayer(firstColor: firstColor, secondColor: secondColor)
        mapContainerView.clipsToBounds = true
        mapContainerView.addSubview(mapView)
        
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: defaultLocation.coordinate.latitude, longitude: defaultLocation.coordinate.longitude)
        marker.appearAnimation = kGMSMarkerAnimationPop
        marker.map = mapView
    }
    
    private func addVenueToGoogleMapView(){
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
        self.navigationController?.pushViewController(mapDirectionViewController, animated: true)
    }
}

extension VenueDetailViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tips.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let tipTableViewCell = tableView.dequeueReusableCell(withIdentifier: "TipTableViewCell", for: indexPath) as? TipTableViewCell
            else { return UITableViewCell() }
        if let image = tips[indexPath.row].userAvatar {
            tipTableViewCell.userImageView.image = image
        }
        tipTableViewCell.usernameLabel.text = tips[indexPath.row].username
        tipTableViewCell.postDateLabel.text = String(describing: tips[indexPath.row].datePost)
        tipTableViewCell.commentLabel.text = tips[indexPath.row].comment
        if let image = tips[indexPath.row].commentImage {
            tipTableViewCell.commentImageView.image = image
            tipTableViewCell.commentImageViewHeightConstraint.constant = 167.5
        } else {
            tipTableViewCell.commentImageViewHeightConstraint.constant = 0
        }
        return tipTableViewCell
    }
}

extension VenueDetailViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let image = tips[indexPath.row].commentImage {
            let tipWithImageDetailViewController = TipWithImageDetailViewController(nibName: "TipWithImageDetailViewController", bundle: nil)
            tipWithImageDetailViewController.tip = (username: tips[indexPath.row].username,
                                                    datePost: tips[indexPath.row].datePost,
                                                    comment: tips[indexPath.row].comment,
                                                    commentImage: image)
//            self.navigationController?.pushViewController(tipWithImageDetailViewController, animated: true)
            self.navigationController?.present(tipWithImageDetailViewController, animated: true, completion: nil)
        }
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
}
