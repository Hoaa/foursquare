//
//  MapDirectionViewController.swift
//  FourSquare
//
//  Created by nmint8m on 26.12.16.
//  Copyright © 2016 Duy Linh. All rights reserved.
//

import UIKit
import GoogleMaps
import Alamofire
import ObjectMapper

class MapDirectionViewController: ViewController {
    
    // MARK: - Properties
    var destinationLocation = CLLocationCoordinate2D(latitude: 16.09, longitude: 108.223)
    
    fileprivate var currentLocation: CLLocationCoordinate2D?
    fileprivate var locationManager = CLLocationManager()
    fileprivate var mapView: GMSMapView!
    fileprivate var zoomLevel: Float = 15.0
    
    // A default location to use when location permission is not granted.
    private let defaultLocation = CLLocation(latitude: 16.0762723, longitude: 108.2221608)
    private var isLoadDone = false
    
    // MARK: - Outlet
    @IBOutlet weak var instructionView: UIView!
    @IBOutlet weak var instructionLabel: UILabel!
    
    // MARK: - Override func
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func loadData() {
        super.loadData()
    }
    
    override func configureUI() {
        super.configureUI()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if isLoadDone {
            return
        }
        isLoadDone = true
        configureGoogleMapView()
        congigureInstructionView()
        addDestinationMarkerToGoogleMapView()
    }
    
    // MARK: - Private func
    
    private func configureGoogleMapView() {
        // Initialize the location manager.
        locationManager = CLLocationManager()
        locationManager.desiredAccuracy = kCLLocationAccuracyKilometer
        locationManager.requestAlwaysAuthorization()
        locationManager.distanceFilter = 30 //The minimum distance (m) device must move horizontal before update event's generated.
        locationManager.startUpdatingLocation()
        locationManager.delegate = self
        
        // Create a map.
        let camera = GMSCameraPosition.camera(withLatitude: defaultLocation.coordinate.latitude,
                                              longitude: defaultLocation.coordinate.longitude,
                                              zoom: zoomLevel)
        mapView = GMSMapView.map(withFrame: view.bounds, camera: camera)
        mapView.isMyLocationEnabled = true
        mapView.settings.myLocationButton = true
        mapView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        view.addSubview(mapView)
        mapView.isHidden = true
        
        mapView.delegate = self
    }
    
    private func congigureInstructionView() {
        self.view.bringSubview(toFront: instructionView)
        instructionView.alpha = 0
        instructionView.layer.cornerRadius = 10
    }
    
    fileprivate func addDestinationMarkerToGoogleMapView() {
        let marker = GMSMarker(position: destinationLocation)
        marker.title = "Destination place"
        marker.map = mapView
    }
    
    fileprivate func addRoute() {
        if let currentLocation = currentLocation {
            let urlString = "https://maps.googleapis.com/maps/api/directions/json?origin=\(currentLocation.latitude),\(currentLocation.longitude)&destination=\(destinationLocation.latitude),\(destinationLocation.longitude)&key=AIzaSyDwy_jU6BQwPfmr_pvkNEdqECd9Px6CR6E"
            Alamofire.request(urlString).responseJSON { response in
                
                if let json = response.result.value as? [String : Any] {
                    if let gmsDirectionAPIResponse = Mapper<GMSDirectionAPIResponse>().map(JSON: json) {
                        if gmsDirectionAPIResponse.status == "OK" {
                            self.addPolyline(gmsDirectionAPIResponse: gmsDirectionAPIResponse)
                            self.addStepDirection(gmsDirectionAPIResponse: gmsDirectionAPIResponse)
                        }
                    }
                }
            }
        }
    }
    
    private func addPolyline(gmsDirectionAPIResponse: GMSDirectionAPIResponse) {
        if let overviewPolylineString = gmsDirectionAPIResponse.routes?[0].overviewPolyline {
            let path = GMSMutablePath(fromEncodedPath: overviewPolylineString)
            let polyline = GMSPolyline(path: path)
            let strokeStyle = GMSStrokeStyle.gradient(from: #colorLiteral(red: 0, green: 0.6730770469, blue: 1, alpha: 1), to: #colorLiteral(red: 0, green: 0.5628422499, blue: 0.3188166618, alpha: 1))
            polyline.spans = [GMSStyleSpan(style: strokeStyle)]
            polyline.strokeColor = #colorLiteral(red: 0.1411764771, green: 0.3960784376, blue: 0.5647059083, alpha: 1)
            polyline.strokeWidth = 5
            polyline.geodesic = true
            polyline.map = self.mapView
        }
    }
    
    private func addStepDirection(gmsDirectionAPIResponse: GMSDirectionAPIResponse){
        if let steps = gmsDirectionAPIResponse.routes?[0].legs[0].steps {
            for i in 0..<steps.count  {
                if let stepLocation = steps[i].startLocation {
                    let circle = GMSCircle(position: stepLocation, radius: 10)
                    circle.fillColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
                    circle.strokeColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
                    circle.strokeWidth = 1
                    circle.title = steps[i].instruction
                    circle.isTappable = true
                    circle.map = self.mapView
                }
            }
        }
    }
    
    fileprivate func resetCameraPosition() {
        if let currentLocation = currentLocation {
            if mapView.isHidden {
                mapView.isHidden = false
                let lat = (currentLocation.latitude + destinationLocation.latitude) / 2
                let lng = (currentLocation.longitude + destinationLocation.longitude) / 2
                let camera = GMSCameraPosition.camera(withLatitude: lat, longitude: lng, zoom: zoomLevel)
                mapView.camera = camera
            } else {
                let camera = GMSCameraPosition.camera(withLatitude: currentLocation.latitude, longitude: currentLocation.longitude, zoom: mapView.camera.zoom)
                mapView.animate(to: camera)
            }
        }
    }
    
    fileprivate func hideInstructionView() {
        UIView.animate(withDuration: 0.3, animations: {
            self.instructionView.alpha = 0
        })
    }
    
    fileprivate func showInstructionView() {
        UIView.animate(withDuration: 0.3, animations: {
            self.instructionView.updateConstraints()
            self.instructionView.alpha = 1
        })
    }
    
    // MARK: - Action
    @IBAction func hideInstructionView(_ sender: UIButton) {
        hideInstructionView()
    }
}

extension MapDirectionViewController: CLLocationManagerDelegate {
    
    // Handle incoming location events.
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location: CLLocation = locations.last!
        currentLocation = location.coordinate
        mapView.clear()
        addDestinationMarkerToGoogleMapView()
        addRoute()
        resetCameraPosition()
    }
    
    // Handle authorization for the location manager.
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
    
    // Handle location manager errors.
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        locationManager.stopUpdatingLocation()
        print("Error: \(error)")
    }
}

extension MapDirectionViewController: GMSMapViewDelegate {
    func mapView(_ mapView: GMSMapView, didTap overlay: GMSOverlay) {
        if instructionView.isHidden == true {
            instructionLabel.text = overlay.title
            showInstructionView()
        } else {
            hideInstructionView()
            instructionLabel.text = overlay.title
            showInstructionView()
        }
    }
}
