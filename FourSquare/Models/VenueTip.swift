//
//  Photo.swift
//  FourSquare
//
//  Created by Duy Linh on 12/28/16.
//  Copyright © 2016 Duy Linh. All rights reserved.
//

import Foundation
import UIKit
import ObjectMapper
import RealmSwift

class VenueTip: Object, Mappable {
    dynamic var userTip: UserTip?
    dynamic var comment: String = ""
    dynamic var timeStamp: Double = 0
    dynamic var photo: Photo?
    
    var venues = LinkingObjects(fromType: Venue.self, property: "tips")
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        userTip <- map["user"]
        comment <- map["text"]
        timeStamp <- map["createdAt"]
        
    }
}
