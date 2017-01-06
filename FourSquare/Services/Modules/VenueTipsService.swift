//
//  VenueTipService.swift
//  FourSquare
//
//  Created by nmint8m on 4.1.17.
//  Copyright © 2017 Duy Linh. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper

class VenueTipsService {
    typealias VenueTipsServiceCompletion = (_ success: Bool, _ error: APIError?) -> Void
    
    class func loadVenueTips(venueID: String, sort: String, offset: Int, limit: Int, completion: VenueTipsServiceCompletion?) {
        let urlString = APIPath.venueDetailURL + venueID + "/tips"
        var parameters = [String: AnyObject]()
        parameters["sort"] = sort as AnyObject?
        parameters["offset"] = offset as AnyObject?
        parameters["limit"] = limit as AnyObject?
        APIService.requestGET(urlString: urlString, parameters: parameters, headers: nil) { (success, data, error) in
            if success {
                parseVenueTip(json: data, venueID: venueID)
                completion?(true, nil)
            } else {
                completion?(false, error)
            }
        }
    }
}

extension VenueTipsService {
    static func parseVenueTip(json: AnyObject?, venueID: String) {
        guard let jsonData = json as? [String : Any] else { return }
        guard let metaData = jsonData["meta"] as? [String : Any] else { return }
        if let codeData = metaData["code"] as? Int {
            if codeData == 200 {
                guard let responseData = jsonData["response"] as? [String : Any] else { return }
                guard let tipsData = responseData["tips"] as? [String : Any] else { return }
                guard let itemsData = tipsData["items"] as? [[String : Any]] else { return }
                var tips: [VenueTip] = []
                for itemData in itemsData {
                    if let tip = Mapper<VenueTip>().map(JSON: itemData) {
                        tips.append(tip)
                    }
                }
                RealmManager.sharedInstance.updateVenueWithTips(venueID: venueID, tips: tips)
            } else {
                print("Error code: \(metaData["code"]). Reason: \(metaData["errorType"]). Detail: \(metaData["errorDetail"])")
            }
        }
    }
}
