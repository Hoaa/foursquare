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

    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        name <- map["name"]
    }
}
