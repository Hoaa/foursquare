//
//  APIService.swift
//  FourSquare
//
//  Created by Duy Linh on 12/16/16.
//  Copyright © 2016 Duy Linh. All rights reserved.
//

import Foundation
import Alamofire

class APIService {
    typealias APIRequestSuccess = (_ data: AnyObject?) -> Void
    typealias APIRequestFailure = (_ error: APIError?) -> Void
    typealias APIRequestCompletion = (_ success: Bool, _ result: AnyObject?, _ error: APIError?) -> Void

    class func request(method: HTTPMethod, uRLString: String, parameters: [String: AnyObject]? = nil, encoding: ParameterEncoding = JSONEncoding.default,
                       headers: [String: String]? = nil, completion: APIRequestCompletion?) -> Request? {
        var parametersBase: [String: AnyObject] = [:]
        if let parameters = parameters {
            parametersBase = parameters
        }
        parametersBase["client_id"] = APIKeys.CLIENT_ID as AnyObject?
        parametersBase["client_secret"] = APIKeys.CLIENT_SECRET as AnyObject?
        parametersBase["v"] = APIKeys.Version as AnyObject?
        
        let request = Alamofire.request(uRLString, method: method, parameters: parametersBase, encoding: encoding, headers: headers)
        request.validate().responseData { (response) in
            // WARN: - log response
            print("\n response.request -> \(response.request)") // original URL request
            print("\n response.response -> \(response.response)") // URL response
            print("\n response.result -> \(response.result)\n") // result of response

            if response.result.isSuccess {
                var json: Any?
                if let data = response.result.value {

                    json = try? JSONSerialization.jsonObject(with: data, options: .mutableContainers)
                }
                completion?(true, json as AnyObject?, nil)
            } else {
                guard let error = response.result.error, (error as NSError).code != APIStatusCode.CANCEL.rawValue else {
                    completion?(false, nil, nil)
                    return
                }
                var jsonError: Any?
                if let errorData = response.data {
                    jsonError = try? JSONSerialization.jsonObject(with: errorData, options: .mutableContainers)
                }

                var message: String?
                // get error message from api if exist
                if let value = jsonError as? [String: AnyObject] {
                    if let msg = value["error"]?["message"] as? String {
                        message = msg
                    }
                }

                let statusCode = response.response != nil ? response.response?.statusCode : (error as NSError).code
                let returnError = APIError(message: message, statusCode: statusCode, error: (error as NSError))
                print("returnError -> \(returnError)")
                completion?(false, nil, returnError)
            }
        }

        return request
    }

    @discardableResult class func requestGET(urlString: String, parameters: [String: AnyObject]? = nil, headers: [String: String]? = nil, completion: APIRequestCompletion?) -> Request? {
        return APIService.request(method: .get, uRLString: urlString, parameters: parameters, encoding: URLEncoding.default, headers: headers, completion: completion)
    }

    @discardableResult class func requestPOST(urlString: String, parameters: [String: AnyObject]? = nil, headers: [String: String]? = nil, completion: APIRequestCompletion?) -> Request? {
        return APIService.request(method: .post, uRLString: urlString, parameters: parameters, encoding: JSONEncoding.default, headers: headers, completion: completion)
    }

    @discardableResult class func requestPUT(urlString: String, parameters: [String: AnyObject]? = nil, headers: [String: String]? = nil, completion: APIRequestCompletion?) -> Request? {
        return APIService.request(method: .put, uRLString: urlString, parameters: parameters, encoding: JSONEncoding.default, headers: headers, completion: completion)
    }

    @discardableResult class func requestDELETE(urlString: String, parameters: [String: AnyObject]? = nil, headers: [String: String]? = nil, completion: APIRequestCompletion?) -> Request? {
        return APIService.request(method: .delete, uRLString: urlString, parameters: parameters, encoding: URLEncoding.default, headers: headers, completion: completion)
    }
}
