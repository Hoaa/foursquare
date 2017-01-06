//
//  ListTransform.swift
//  FourSquare
//
//  Created by Duy Linh on 1/4/17.
//  Copyright © 2017 Duy Linh. All rights reserved.
//

import UIKit
import RealmSwift
import ObjectMapper

class ListTransform<T:Object> : TransformType where T:Mappable {
    
    typealias Object = List<T>
    typealias JSON = [[String:Any]]
    
    let mapper = Mapper<T>()
    
    func transformFromJSON(_ value: Any?) -> List<T>? {
        let result = List<T>()
        if let tempArr = value as? [Any] {
            for entry in tempArr {
                let mapper = Mapper<T>()
                let model : T = mapper.map(JSONObject: entry)!
                result.append(model)
            }
        }
        return result
    }
    
    func transformToJSON(_ value: Object?) -> JSON? {
        var results = [[String:Any]]()
        if let value = value {
            for obj in value {
                let json = mapper.toJSON(obj)
                results.append(json)
            }
        }
        return results
    }
}
