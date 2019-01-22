//
//  APIServices.swift
//  SphAssignment
//
//  Created by Nobin Thomas on 22/1/19.
//  Copyright © 2019 Nobin Thomas. All rights reserved.
//

import Foundation

protocol APIServiceDelegate {
    func requestCompletedWithSuccess(response:Any)
    func requestCompletedWithError(message:String?)
}

class APIServices {
    static let shared: APIServices = {
        let instance = APIServices()
        return instance
    }()
    
    var delegate:APIServiceDelegate?
    func loadInitialService() {
        Networking.apiGet(urlString: APIParameter.initialSearch, callback: { (response, responseObject) in
            if let res = response, res == KeyApiResponse.success.rawValue, let ob = responseObject{
                // Success in API response
                self.delegate?.requestCompletedWithSuccess(response:ob)
            } else {
                // Throw error
                self.delegate?.requestCompletedWithError(message: APIMessages.Error)
            }
        })
    }
    
    
    // TODO --
    func loadService(nextUrl: String) {
        Networking.apiGet(urlString: nextUrl, callback: { (response, responseObject) in
            if let res = response, res == KeyApiResponse.success.rawValue, let ob = responseObject{
                // Success in API response
                self.delegate?.requestCompletedWithSuccess(response:ob)
            } else {
                // Throw error
                self.delegate?.requestCompletedWithError(message: APIMessages.Error)
            }
        })
    }
}
