//
//  VenueLocation.swift
//  FourSquare
//
//  Created by Duy Linh on 12/28/16.
//  Copyright © 2016 Duy Linh. All rights reserved.
//

import Foundation
import ObjectMapper
import RealmSwift

class VenueLocation: Object, Mappable {
    dynamic var latitude: Double = 0
    dynamic var longitude: Double = 0
    dynamic var distance: Int = 0
    dynamic var address: String = ""
    dynamic var city: String = ""
    dynamic var state: String = ""
    
    var venues = LinkingObjects(fromType: Venue.self, property: "location")
    
    var fullAddress: String {
        var result: String = ""
        if !address.isEmpty {
            result = result + "\(address)"
        }
        if !city.isEmpty {
            if address.isEmpty {
                result = result + "\(city)"
            } else {
                result = result + ", \(city)"
            }
        }
        if !state.isEmpty {
            if address.isEmpty && city.isEmpty {
                result = result + "\(state)"
            } else {
                result = result + ", \(state)"
            }
        }
        
        if address.isEmpty && city.isEmpty && state.isEmpty {
            result = Strings.NotAvailable
        }
        return result
    }
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        latitude <- map["lat"]
        longitude <- map["lng"]
        distance <- map["distance"]
        address <- map["address"]
        city <- map["city"]
        state <- map["state"]
    }
}
