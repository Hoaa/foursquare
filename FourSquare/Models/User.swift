//
//  User.swift
//  FourSquare
//
//  Created by Duy Linh on 12/28/16.
//  Copyright © 2016 Duy Linh. All rights reserved.
//

import UIKit
import ObjectMapper
import RealmSwift

class User: Object, Mappable {
    dynamic var id: String = ""
    dynamic var firstName: String = ""
    dynamic var lastName: String = ""
    dynamic var avatar: Photo?
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        firstName <- map["firstName"]
        lastName <- map["lastName"]
        avatar <- map["photo"]
    }
}

// MARK: - User Extension

extension User {
    func getFullName() -> String {
        return "\(firstName), \(lastName)"
    }
}
