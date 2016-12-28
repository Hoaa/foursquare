//
//  Venue.swift
//  FourSquare
//
//  Created by Duy Linh on 12/27/16.
//  Copyright © 2016 Duy Linh. All rights reserved.
//

import Foundation
import RealmSwift
import ObjectMapper

class Venue: Object, Mappable {
    dynamic var id: String = ""
    dynamic var name: String = ""
    dynamic var rating: Double = 0.0
    dynamic var ratingColor: String = ""
    dynamic var isFavorite: Bool = false
    dynamic var isSaved: Bool = false
    dynamic var isHistory: Bool = false
    dynamic var thumbnail: Photo?
    dynamic var location: VenueLocation?
    dynamic var price: VenuePrice?
    
    var categories = RealmSwift.List<VenueCategory>()
    let photos = RealmSwift.List<Photo>()
    let tips = RealmSwift.List<VenueTip>()

    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        name <- map["name"]
        rating <- map["rating"]
        ratingColor <- map["ratingColor"]
        price <- map["price"]
        location <- map["location"]
    }
}
