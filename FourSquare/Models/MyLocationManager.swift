//
//  MyLocationManager.swift
//  FourSquare
//
//  Created by Duy Linh on 1/3/17.
//  Copyright © 2017 Duy Linh. All rights reserved.
//

import Foundation
import UIKit
import CoreLocation

class MyLocationManager: NSObject {
    static let sharedInstanced = MyLocationManager()
    let locationManager: CLLocationManager = CLLocationManager()
    var currentLocation: CLLocation?

    override init() {
        super.init()
        self.locationManager.delegate = self
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.distanceFilter = 100.0
        self.locationManager.pausesLocationUpdatesAutomatically = true
    }

    func startLocation() {
        self.locationManager.startUpdatingLocation()
    }
}

// MARK: - LocationManager Delegate
extension MyLocationManager: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            self.currentLocation = self.locationManager.location
        }
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        self.currentLocation = locations.last
        self.locationManager.stopUpdatingLocation()
    }
}
