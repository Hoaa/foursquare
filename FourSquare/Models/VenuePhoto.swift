//
//  VenuePhoto.swift
//  FourSquare
//
//  Created by nmint8m on 5.1.17.
//  Copyright © 2017 Duy Linh. All rights reserved.
//

import Foundation
import RealmSwift
import ObjectMapper

class VenuePhoto: Object, Mappable {
    dynamic var id: String = ""
    dynamic var prefix: String = ""
    dynamic var suffix: String = ""
    dynamic var width: Int = 0
    dynamic var height: Int = 0
    
    var venue = LinkingObjects(fromType: Venue.self, property: "photos")
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        prefix <- map["prefix"]
        suffix <- map["suffix"]
        width <- map["width"]
        height <- map["height"]
    }
}

extension VenuePhoto {
    var venuePhotoURL: URL? {
        if width < 300 || height < 300{
            return URL(string: prefix + "\(width)x\(height)" + suffix)
        }
        let scale = min(width / 300, height / 300)
        return URL(string: prefix + "\(width * scale)x\(height * scale)" + suffix)
    }
}
