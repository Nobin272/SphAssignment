//
//  APIConstants.swift
//  SphAssignment
//
//  Created by Nobin Thomas on 22/1/19.
//  Copyright © 2019 Nobin Thomas. All rights reserved.
//

import Foundation

struct APIURL {
    static let baseURL = "https://data.gov.sg"
}

struct APIParameter {
    static let initialSearch = "/api/action/datastore_search?resource_id=a807b7ab-6cad-4aa6-87d0-e283a7353a0f&limit=5"
    // Add new url params here
}

struct APIMessages {
    static let Error = "An error occured while processing your request"
}

struct APIKeys {
    static let success = "success"
    static let result = "result"
    static let resource_id = "resource_id"
    
    static let fields = "fields"
    static let type = "type"
    static let keyId = "id"
    
    static let records = "records"
    static let volume_of_mobile_data = "volume_of_mobile_data"
    static let quarter = "quarter"
    static let _id = "_id"
    
    static let _links = "_links"
    static let start = "start"
    static let next = "next"
    
    static let limit = "limit"
    static let total = "total"
}

enum ApiServiceType: Int {
    case ApiServiceFirst = 0
    case ApiServiceNext = 1
}
