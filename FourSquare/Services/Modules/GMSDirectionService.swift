//
//  GMSDirectionService.swift
//  FourSquare
//
//  Created by nmint8m on 5.1.17.
//  Copyright © 2017 Duy Linh. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper
import GoogleMaps

class GMSDirectionAPIService {
    typealias GMSDirectionAPIRequestCompletion = (_ success: Bool, _ result: AnyObject?) -> Void
    
    class func request(method: HTTPMethod, urlString: String,
                       parameters: [String: AnyObject]? = nil,
                       encoding: ParameterEncoding = JSONEncoding.default,
                       headers: [String: String]? = nil,
                       completion: GMSDirectionAPIRequestCompletion?) -> Request? {
        var parametersBase: [String: AnyObject] = [:]
        if let parameters = parameters {
            parametersBase = parameters
        }
        parametersBase["key"] = APIKeys.GMSDirectionAPIKey as AnyObject?
        
        let request = Alamofire.request(urlString, method: method, parameters: parameters, encoding: encoding, headers: headers)
        request.validate().responseData { (response) in
            if response.result.isSuccess {
                var json: Any?
                if let data = response.result.value {
                    json = try? JSONSerialization.jsonObject(with: data, options: .mutableContainers)
                }
                completion?(true, json as AnyObject?)
            } else {
                completion?(false, nil)
            }
        }
        return request
    }
    
    @discardableResult class func requestGET(urlString: String, parameters: [String: AnyObject]? = nil, headers: [String: String]? = nil, completion: GMSDirectionAPIRequestCompletion?) -> Request? {
        return GMSDirectionAPIService.request(method: .get, urlString: urlString, parameters: parameters, encoding: URLEncoding.default, headers: headers, completion: completion)
    }
}

class GMSDirectionService {
    class func loadDirection(startLocation: CLLocationCoordinate2D, endLocation: CLLocationCoordinate2D, completion: @escaping (_ success: Bool, _ route: Route?) -> Void) {
        let urlString = APIPath.gmsDirectionURL
        var parameters = [String : AnyObject]()
        parameters["origin"] = "\(startLocation.latitude),\(startLocation.longitude)" as AnyObject?
        parameters["destination"] = "\(endLocation.latitude),\(endLocation.longitude)" as AnyObject?
        GMSDirectionAPIService.requestGET(urlString: urlString, parameters: parameters, headers: nil) { (success, data) in
            if success {
                let route = parseGMSDirectionResponse(json: data)
                completion(true, route)
            } else {
                completion(false, nil)
            }
        }
    }
}

extension GMSDirectionService {
    static func parseGMSDirectionResponse(json: AnyObject?) -> Route? {
        guard let jsonData = json as? [String : Any] else { return nil }
        if let gmsDirectionAPIResponse = Mapper<GMSDirectionAPIResponse>().map(JSON: jsonData) {
            if gmsDirectionAPIResponse.status == "OK" {
                return gmsDirectionAPIResponse.routes?[0]
            }
        }
        return nil
    }
}

