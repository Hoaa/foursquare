//
//  Leg.swift
//  FourSquare
//
//  Created by nmint8m on 28.12.16.
//  Copyright © 2016 Duy Linh. All rights reserved.
//

import Foundation
import ObjectMapper
import GoogleMaps

class Leg: Mappable {
    var distanceText = ""
    var distanceValue = 0
    var durationText = ""
    var durationValue = 0
    var endAddress = ""
    var endLocation: CLLocationCoordinate2D?
    var startAddress = ""
    var startLocation: CLLocationCoordinate2D?
    var steps: [Step] = []
    
    required init?(map: Map) { }
    
    func mapping(map: Map) {
        distanceText <- map["distance.text"]
        distanceValue <- map["distance.value"]
        durationText <- map["duration.text"]
        durationValue <- map["duration.value"]
        endAddress <- map["end_address"]
        endLocation = getCLLocationCoordinate2DFromMapping(map: map, property: "end_location")
        startAddress <- map["start_address"]
        startLocation = getCLLocationCoordinate2DFromMapping(map: map, property: "start_location")
        steps <- map["steps"]
    }
    
    private func getCLLocationCoordinate2DFromMapping(map: Map, property: String) -> CLLocationCoordinate2D {
        var lat: Double = 0.0
        lat <- map["\(property).lat"]
        var lng: Double = 0.0
        lng <- map["\(property).lng"]
        return CLLocationCoordinate2D(latitude: lat, longitude: lng)
    }
}
