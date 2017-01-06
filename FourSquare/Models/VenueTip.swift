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
    dynamic var id: String = ""
//    dynamic var userTip: UserTip?
    dynamic var text: String = ""
    dynamic var createdAt: Double = 0
    dynamic var tipPhotoID: String = ""
    dynamic var tipPhotoPrefix: String = ""
    dynamic var tipPhotoSuffix: String = ""
    dynamic var tipPhotoWidth: Int = 0
    dynamic var tipPhotoHeight: Int = 0
    dynamic var userFirstName: String = ""
    dynamic var userLastName: String = ""
    dynamic var userPhotoPrefix: String = ""
    dynamic var userPhotoSuffix: String = ""
    dynamic var userPhotoWidth: Int = 0
    dynamic var userPhotoHeight: Int = 0
    
    var venue = LinkingObjects(fromType: Venue.self, property: "tips")
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        text <- map["text"]
        createdAt <- map["createdAt"]
        tipPhotoID <- map["photo.id"]
        tipPhotoPrefix <- map["photo.prefix"]
        tipPhotoSuffix <- map["photo.suffix"]
        tipPhotoWidth <- map["photo.width"]
        tipPhotoHeight <- map["photo.height"]
        userFirstName <- map["user.firstName"]
        userLastName <- map["user.lastName"]
        userPhotoPrefix <- map["user.photo.prefix"]
        userPhotoSuffix <- map["user.photo.suffix"]
        userPhotoWidth <- map["user.photo.width"]
        userPhotoHeight <- map["user.photo.height"]
    }
}

extension VenueTip {
    var tipPhotoURL: URL? {
        if tipPhotoID != "" {
            return URL(string: tipPhotoPrefix + "\(tipPhotoWidth)" + "x" + "\(tipPhotoHeight)" + tipPhotoSuffix)
        } else {
            return nil
        }
    }
    var userFullName: String {
        get {
            return userFirstName + " " + userLastName
        }
    }
    
    var userAvatarURL: URL? {
        return URL(string: userPhotoPrefix + "90x90" + userPhotoSuffix)
    }
}
