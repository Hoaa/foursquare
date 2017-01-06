//
//  VenueDetailService.swift
//  FourSquare
//
//  Created by nmint8m on 3.1.17.
//  Copyright © 2017 Duy Linh. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper

class VenueDetailService {
    typealias VenueDetailServiceCompletion = (_ success: Bool, _ error: APIError?) -> Void
    
    class func loadVenueDetail(venueID: String, completion: VenueDetailServiceCompletion?) {
        let urlString = APIPath.venueDetailURL + venueID
        APIService.requestGET(urlString: urlString, parameters: nil, headers: nil) { (success, data, error) in
            if success {
                parseVenueDetail(json: data)
                completion?(true, nil)
            } else {
                completion?(false, error)
            }
        }
    }
}

extension VenueDetailService {
    static func parseVenueDetail(json: AnyObject?) {
        // Check if code of meta is 200 --> right response
        guard let jsonData = json as? [String : Any] else { return }
        guard let metaData = jsonData["meta"] as? [String : Any] else { return }
        if let codeData = metaData["code"] as? Int {
            if codeData == 200 {
                guard let responseData = jsonData["response"] as? [String : Any] else { return }
                guard let venueData = responseData["venue"] as? [String : Any] else { return }
                if let venue = Mapper<Venue>().map(JSON: venueData) {
                    RealmManager.sharedInstance.updateVenueDetail(venue: venue)
                }
            } else {
                print("Error code: \(metaData["code"]). Reason: \(metaData["errorType"]). Detail: \(metaData["errorDetail"])")
            }
        }
    }
}
