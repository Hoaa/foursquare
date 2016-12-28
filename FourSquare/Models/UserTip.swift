//
//  UserTip.swift
//  FourSquare
//
//  Created by Duy Linh on 12/28/16.
//  Copyright © 2016 Duy Linh. All rights reserved.
//

import UIKit
import ObjectMapper
import RealmSwift

class UserTip: Object, Mappable {
    dynamic var avatar: Photo?
    
    var venueTips = LinkingObjects(fromType: VenueTip.self, property: "userTip")
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        avatar <- map["photo"]
    }
}
