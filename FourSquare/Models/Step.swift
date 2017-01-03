//
//  Step.swift
//  FourSquare
//
//  Created by nmint8m on 28.12.16.
//  Copyright © 2016 Duy Linh. All rights reserved.
//

import Foundation
import ObjectMapper
import GoogleMaps

class Step: Mappable {
    var distanceText = ""
    var distanceValue = 0
    var durationText = ""
    var durationValue = 0
    var endLocation: CLLocationCoordinate2D?
    var instruction = ""
    var startLocation: CLLocationCoordinate2D?
    var travelMode = ""
    
    required init?(map: Map) { }
    
    func mapping(map: Map) {
        distanceText <- map["distance.text"]
        distanceValue <- map["distance.value"]
        durationText <- map["duration.text"]
        durationValue <- map["duration.value"]
        endLocation = getCLLocationCoordinate2DFromMapping(map: map, property: "end_location")
        instruction = getStringFromMappingHTML(map: map, property: "html_instructions")
        startLocation = getCLLocationCoordinate2DFromMapping(map: map, property: "start_location")
        travelMode <- map["travel_mode"]
    }
    
    private func getCLLocationCoordinate2DFromMapping(map: Map, property: String) -> CLLocationCoordinate2D {
        var lat: Double = 0.0
        lat <- map["\(property).lat"]
        var lng: Double = 0.0
        lng <- map["\(property).lng"]
        return CLLocationCoordinate2D(latitude: lat, longitude: lng)
    }
    
    private func getStringFromMappingHTML(map: Map, property: String) -> String {
        var htmlString = ""
        htmlString <- map[property]
        guard let data = htmlString.data(using: .utf8) else { return "" }
        do {
            return try NSAttributedString(data: data,
                                          options: [NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType, NSCharacterEncodingDocumentAttribute: String.Encoding.utf8.rawValue],
                                          documentAttributes: nil).string
        } catch {
            print("Error occur when parsing HTML string to plain text")
            return ""
        }
    }
}
