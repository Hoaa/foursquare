//
//  File.swift
//  FourSquare
//
//  Created by nmint8m on 28.12.16.
//  Copyright © 2016 Duy Linh. All rights reserved.
//

import Foundation
import ObjectMapper
import GoogleMaps

struct Bounds: Mappable {
    var northeast: CLLocationCoordinate2D?
    var southwest: CLLocationCoordinate2D?
    
    init?(map: Map) { }
    
    mutating func mapping(map: Map) {
        northeast = getCLLocationCoordinate2DFromMapping(map: map, property: "northeast")
        southwest = getCLLocationCoordinate2DFromMapping(map: map, property: "southwest")
    }
    
    private func getCLLocationCoordinate2DFromMapping(map: Map, property: String) -> CLLocationCoordinate2D {
        var lat: Double = 0.0
        lat <- map["\(property).lat"]
        var lng: Double = 0.0
        lng <- map["\(property).lng"]
        return CLLocationCoordinate2D(latitude: lat, longitude: lng)
    }
}

class Route: Mappable {
    var bounds: Bounds?
    var legs: [Leg] = []
    var overviewPolyline = ""
    var waypointOrder: [Int] = []
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        bounds <- map["bounds"]
        legs <- map["legs"]
        overviewPolyline <- map["overview_polyline.points"]
        waypointOrder <- map["waypoint_order"]
    }
}
