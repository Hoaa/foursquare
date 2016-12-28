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
    dynamic var ratingColorString: String = ""
    dynamic var isFavorite: Bool = false
    dynamic var didFavorite: Bool = false
    dynamic var isHistory: Bool = false
    dynamic var thumbnail: Photo?
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
        ratingColorString <- map["ratingColor"]
        price <- map["price"]
    }
}
