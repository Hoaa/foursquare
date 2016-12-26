//
//  MapViewController.swift
//  FourSquare
//
//  Created by Duy Linh on 12/26/16.
//  Copyright © 2016 Duy Linh. All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlaces

class MapViewController: ViewController {

    // MARK: - Property
    @IBOutlet weak var mapContainerView: UIView!
    var venues: [(String, CLLocationCoordinate2D)] = []
    let markerImages = [#imageLiteral(resourceName: "bar"), #imageLiteral(resourceName: "burger"), #imageLiteral(resourceName: "fastfood")]
    var locationManager: CLLocationManager!
    var placesClient: GMSPlacesClient!
    var currentLocation: CLLocation?
    var zoomLevel: Float = 15.0
    let defaultLocation = CLLocation(latitude: 16.0762723, longitude: 108.2221608)
    var mapView: GMSMapView!
    var markers: [GMSMarker] = []
    let infoMarkerOfOtherPlace = GMSMarker()
    var currentVenueCollectionViewPage = 0
    
    // MARK: - Cycle life
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
        configGoogleMapView()
        addVenueToGoogleMapView()
    }

    // MARK: - Private function
    private func loadData() {
        let venue1 = ("ABC", CLLocationCoordinate2D(latitude: 16.0748304, longitude: 108.2219308))
        let venue2 = ("DEF", CLLocationCoordinate2D(latitude: 16.07431, longitude: 108.22132))
        let venue3 = ("GHI", CLLocationCoordinate2D(latitude: 16.07432, longitude: 108.22933))
        venues = [venue1, venue2, venue3]
    }
    
    // MARK: - Public function
    func configGoogleMapView() {
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
    
    func addVenueToGoogleMapView(){
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
}

// MARK: - CLLocationManagerDelegate
extension MapViewController: CLLocationManagerDelegate {
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

// MARK: - GMSMapViewDelegate
extension MapViewController: GMSMapViewDelegate {
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

