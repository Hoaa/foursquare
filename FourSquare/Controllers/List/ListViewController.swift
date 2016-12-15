//
//  ListViewController.swift
//  FourSquare
//
//  Created by Duy Linh on 12/14/16.
//  Copyright © 2016 Duy Linh. All rights reserved.
//
import UIKit
import GoogleMaps
import GooglePlaces
import GooglePlacePicker

class ListViewController: UIViewController {

    // MARK: - Property
    @IBOutlet weak var mapContainerView: UIView!
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
                addRightBarButtonItem()
                collectionView.reloadData()
            case 2:
                addRightBarButtonItem()
                collectionView.reloadData()
            case 3:
                addRightBarButtonItem()
                self.topView.constant = 500
            default:
                break
            }
        }
    }
    
    //tam----------------
    // Fake data
    var venues: [(String, CLLocationCoordinate2D)] = []
    let markerImages = [#imageLiteral(resourceName: "bar"), #imageLiteral(resourceName: "burger"), #imageLiteral(resourceName: "fastfood")]
    
    var locationManager: CLLocationManager!
    var placesClient: GMSPlacesClient!
    var currentLocation: CLLocation?
    var zoomLevel: Float = 15.0
    
    let defaultLocation = CLLocation(latitude: 16.0762723, longitude: 108.2221608) // A default location to use when location permission is not granted.
    
    var mapView: GMSMapView!
    var markers: [GMSMarker] = []
    let infoMarkerOfOtherPlace = GMSMarker()
    
    var currentVenueCollectionViewPage = 0
    //------------------
    
    // MARK: - Cycle Life
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationBar()
        loadData()
        configureUI()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        configGoogleMapView()
        addVenueToGoogleMapView()
        configVenueCollectionView()
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
        var image = UIImage()
        switch self.changeStyle {
        case 1:
            image = #imageLiteral(resourceName: "Style")
        case 2:
            image = #imageLiteral(resourceName: "Style")
        case 3:
            image = #imageLiteral(resourceName: "Style")
        default:
            break
        }
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: image, style: .done, target: self, action: #selector(changeViewAction))
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
    
    //tam-----
    private func loadData() {
        let venue1 = ("ABC", CLLocationCoordinate2D(latitude: 16.0748304, longitude: 108.2219308))
        let venue2 = ("DEF", CLLocationCoordinate2D(latitude: 16.07431, longitude: 108.22132))
        let venue3 = ("GHI", CLLocationCoordinate2D(latitude: 16.07432, longitude: 108.22933))
        venues = [venue1, venue2, venue3]
    }
    
    private func configView() {
        
    }
    
    private func configGoogleMapView() {
        // CLLocationManager
        locationManager = CLLocationManager()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        locationManager.distanceFilter = 50
        locationManager.startUpdatingLocation()
        locationManager.delegate = self
        
        // PlaceClient
        placesClient = GMSPlacesClient.shared()
        
        // MapView
        let camera = GMSCameraPosition.camera(withLatitude: defaultLocation.coordinate.latitude,
                                              longitude: defaultLocation.coordinate.longitude,
                                              zoom: zoomLevel)
        if mapView == nil {
            mapView = GMSMapView.map(withFrame: self.view.bounds, camera: camera)
            mapView.isHidden = true // Hide map until we've got a location update.
            mapContainerView.addSubview(mapView)
            
            // MapView Delegate
            mapView.delegate = self
        }
    }
    
    private func addVenueToGoogleMapView(){
        for i in 0...venues.count - 1 {
            let marker = GMSMarker()
            marker.title = "Title of place"
            marker.snippet = "Snippet of place"
            marker.icon = markerImages[i]
            marker.position = venues[i].1
            marker.appearAnimation = kGMSMarkerAnimationPop
            marker.zIndex = Int32(i)
            marker.map = mapView
            markers.append(marker)
        }
    }
    
    private func configVenueCollectionView() {
        // View
        collectionView.isPagingEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = UIColor.clear
        
        // Flow layout
        let collectionViewFlowLayout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        collectionViewFlowLayout.scrollDirection = .horizontal
        collectionView.collectionViewLayout = collectionViewFlowLayout
        
        // Register
        let nib = UINib(nibName: "ListMapCollectionViewCell", bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: "ListMapCollectionViewCell")
    }
    //----------

}

// MARK: - UICollectionViewDataSource
extension ListViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return venues.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if self.changeStyle == 1 {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CellDefault", for: indexPath) as? ListDefaultCollectionViewCell else {return UICollectionViewCell()}
            return cell
        } else if self.changeStyle == 2 {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CellCollection", for: indexPath) as? ListCollectionViewCell else {return UICollectionViewCell()}
            return cell
        } else {
            guard let listMapCollectionCell = collectionView.dequeueReusableCell(withReuseIdentifier: "ListMapCollectionViewCell", for: indexPath) as? ListMapCollectionViewCell
                else { return UICollectionViewCell() }
            listMapCollectionCell.layer.cornerRadius = 5
            listMapCollectionCell.venueNameLabel.text = venues[indexPath.row].0
            return listMapCollectionCell
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
            return CGSize(width: collectionView.bounds.width - 10, height: collectionView.bounds.height - 10)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsets
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInsets.left
    }
}

// MARK: - UICollectionViewDelegate
extension ListViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    }
    
    func scrollViewWillBeginDecelerating(_ scrollView: UIScrollView) {
        markers[currentVenueCollectionViewPage].zIndex = Int32(currentVenueCollectionViewPage)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let pageWidth = scrollView.bounds.width
        let currentPage = scrollView.contentOffset.x / pageWidth
        markers[Int(currentPage)].zIndex = -1
        currentVenueCollectionViewPage = Int(currentPage)
    }
}

//tam----
extension ListViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location: CLLocation = locations.last!
        let camera = GMSCameraPosition.camera(withLatitude: location.coordinate.latitude,
                                              longitude: location.coordinate.longitude,
                                              zoom: zoomLevel)
        // Location update
        if mapView.isHidden {
            mapView.isHidden = false
            mapView.camera = camera
        } else {
            mapView.animate(to: camera)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .restricted:
            print("Location access was restricted.")
        case .denied:
            print("User denied access to location.")
            // Display the map using the default location.
            mapView.isHidden = false
        case .notDetermined:
            print("Location status not determined.")
        case .authorizedAlways: fallthrough
        case .authorizedWhenInUse:
            print("Location status is OK.")
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        locationManager.stopUpdatingLocation()
        print("Error of location manager: \(error)")
    }
}

extension ListViewController: GMSMapViewDelegate {
    func mapView(_ mapView: GMSMapView,
                 didTapPOIWithPlaceID placeID: String,
                 name: String, location: CLLocationCoordinate2D) {
        print("You tapped \(name): \(placeID), \(location.latitude)/\(location.longitude)")
        infoMarkerOfOtherPlace.snippet = placeID
        infoMarkerOfOtherPlace.position = location
        infoMarkerOfOtherPlace.title = name
        infoMarkerOfOtherPlace.opacity = 0
        infoMarkerOfOtherPlace.infoWindowAnchor.y = 1
        infoMarkerOfOtherPlace.map = mapView
        mapView.selectedMarker = infoMarkerOfOtherPlace
    }
}

