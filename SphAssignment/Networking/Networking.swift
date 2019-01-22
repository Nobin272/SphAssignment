//
//  Networking.swift
//  SphAssignment
//
//  Created by Nobin Thomas on 22/1/19.
//  Copyright © 2019 Nobin Thomas. All rights reserved.
//

import Foundation

enum ServiceError: Error {
    case InvalidJSON
}

class ApiError: Swift.Error {
    let code: Int
    let description: String
    
    init(errorCode: Int, errorMessage: String) {
        self.code = errorCode
        self.description = errorMessage
    }
}

enum KeyApiResponse: String {
    case success = "Success"
    case error = "Error"
}

class Networking {
    static let shared: Networking = {
        let instance = Networking()
        return instance
    }()
    
    class func apiGet(urlString: String, callback: @escaping (String?, Any?) -> Void) {
        let fullUrl = "\(APIURL.baseURL)\(urlString)"
        // Set up the URL request
        guard let url = URL(string: fullUrl) else {
            print("Error: cannot create URL")
            return
        }
        let urlRequest = URLRequest(url: url)
        
        // set up the session
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        
        // make the request
        let task = session.dataTask(with: urlRequest) {
            (data, response, error) in
            // check for any errors
            guard error == nil else {
                print("error calling GET on /todos/1")
                print(error!)
                return
            }
            // make sure we got data
            guard let responseData = data else {
                print("Error: did not receive data")
                return
            }
            // parse the result as JSON, since that's what the API provides
            do {
                guard let responseObject = try JSONSerialization.jsonObject(with: responseData, options: [])
                    as? [String: Any] else {
                        print("error trying to convert data to JSON")
                        return
                }
                callback(KeyApiResponse.success.rawValue, responseObject)
            } catch  {
                print("error trying to convert data to JSON")
                return
            }
        }
        task.resume()
    }
}



