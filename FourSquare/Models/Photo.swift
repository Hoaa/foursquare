//
//  Photo.swift
//  FourSquare
//
//  Created by Duy Linh on 12/28/16.
//  Copyright © 2016 Duy Linh. All rights reserved.
//

import Foundation
import ObjectMapper
import RealmSwift

class Photo: Object, Mappable {
    dynamic var prefix: String = ""
    dynamic var suffix: String = ""
    dynamic var width: Int = 0
    dynamic var height: Int = 0
    
    var venues = LinkingObjects(fromType: Venue.self, property: "thumbnail")
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        prefix <- map["prefix"]
        suffix <- map["suffix"]
        width <- map["width"]
        height <- map["height"]
    }
}

// MARK: - Photo Extension

extension Photo {
    var avatarPath: URL? {
        let width = 90
        let height = 90
        let path = prefix + "\(width)" + "x" + "\(height)" + suffix
        return URL(string: path)
    }
    
    var thumbnailPath: URL? {
        let path = prefix + "800x600" + suffix
        return URL(string: path)
    }
    
    var photoPathString: String {
        return prefix + "\(width)" + "x" + "\(height)" + suffix
    }
}
