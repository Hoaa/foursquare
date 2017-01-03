//
//  GMSDirectionAPIResponse.swift
//  FourSquare
//
//  Created by nmint8m on 28.12.16.
//  Copyright © 2016 Duy Linh. All rights reserved.
//

import Foundation
import ObjectMapper
import GoogleMaps

class GMSDirectionAPIResponse: Mappable {
    var status = ""
    var routes: [Route]?
    
    required init?(map: Map) { }
    
    func mapping(map: Map) {
        status <- map["status"]
        routes <- map["routes"]
    }
}
