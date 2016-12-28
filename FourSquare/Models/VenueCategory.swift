//
//  VenueCategory.swift
//  FourSquare
//
//  Created by Duy Linh on 12/28/16.
//  Copyright © 2016 Duy Linh. All rights reserved.
//

import Foundation
import ObjectMapper
import RealmSwift

class VenueCategory: Object, Mappable {
    dynamic var categoryName: String = ""
    
    var venues = LinkingObjects(fromType: Venue.self, property: "categories")
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        categoryName <- map["name"]
    }
}