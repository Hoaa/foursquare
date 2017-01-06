//
//  APIError.swift
//  FourSquare
//
//  Created by Duy Linh on 12/16/16.
//  Copyright © 2016 Duy Linh. All rights reserved.
//

import Foundation

// Common status codes
enum APIStatusCode: Int {
    case SUCCESS = 200
    case CREATED = 201
    case ACCEPTED = 202
    case UNAUTHORIZED = 401
    case FORBIDDEN = 403
    case NOTFOUND = 404
    case INTERNALSERVER = 500
    case MAINTENANCE = 503
    case UNKNOWN = 1001
    case CANCEL = -999
    case HOSTNAMENOTFOUND = -1003
    case NOINTERNETCONNECT = -1009
    case OBJECTREMOVED = -6003
}

class APIError: NSError {
    var message: String?
    var statusCode: Int?
    override var localizedDescription: String {
        if let message = self.message {
            return message
        } else {
            return super.localizedDescription
        }
    }

    init(message: String?, statusCode: Int?, error: NSError) {
        self.message = message
        self.statusCode = statusCode
        super.init(domain: error.domain, code: error.code, userInfo: error.userInfo)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
