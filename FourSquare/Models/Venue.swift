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
    dynamic var ratingSignals: Int = 0
    dynamic var section: String = ""
    dynamic var isFavorite: Bool = false
    dynamic var didFavorite: Bool = false
    dynamic var isSave: Bool = false
    dynamic var isHistory: Bool = false
    dynamic var favoriteTimestamp = Date()
    dynamic var saveTimestamp = Date()
    dynamic var historyTimestamp = Date()
    dynamic var thumbnail: Photo?
    dynamic var location: VenueLocation?
    dynamic var price: VenuePrice?
    
    var categories = RealmSwift.List<VenueCategory>()
    var photos = RealmSwift.List<VenuePhoto>()
    var tips = RealmSwift.List<VenueTip>()

    required convenience init?(map: Map) {
        self.init()
    }
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        name <- map["name"]
        rating <- map["rating"]
        ratingColorString <- map["ratingColor"]
        ratingSignals <- map["ratingSignals"]
        thumbnail <- map["featuredPhotos.items.0"]
        location <- map["location"]
        price <- map["price"]
        categories <- (map["categories"], ListTransform<VenueCategory>())
        photos <- (map["photos.groups.0.items"], ListTransform<VenuePhoto>())
        tips <- (map["tips.groups.0.items"], ListTransform<VenueTip>())
    }
}

extension Venue {
    var ratingColor: UIColor {
        return UIColor.hexToColor(hexString: self.ratingColorString)
    }
    
    func getCategoriesName() -> String {
        var categoriesName = ""
        for category in categories {
            if category != categories.last {
                categoriesName += category.categoryName + ", "
            } else {
                categoriesName += category.categoryName
            }
        }
        return categoriesName
    }
}
