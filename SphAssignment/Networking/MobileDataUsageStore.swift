//
//  MobileUsageDataStore.swift
//  SphAssignment
//
//  Created by Nobin Thomas on 22/1/19.
//  Copyright © 2019 Nobin Thomas. All rights reserved.
//

import Foundation
import SwiftyJSON

protocol MobileDataUsageStoreDelegate: class {
    func didDataRefresh(items: [MobileDataRecord])
    func didDataChanged(newlyAdded: [MobileDataRecord])
}

class MobileDataUsageStore {
    static let shared: MobileDataUsageStore = {
        let instance = MobileDataUsageStore()
        return instance
    }()
    
    var records: [MobileDataResponse]? = []
    var total: Int?
    var nextUrl: String?
    var delegate: MobileDataUsageStoreDelegate?
    var serviceType: ApiServiceType?
    
    // Store json file
    func processJsonAndStore(responseObject: Any) -> [MobileDataRecord]? {
        let json = JSON(responseObject)
        
        // validate json
        if let success = json[APIKeys.success].bool, success == true, let result = json[APIKeys.result].dictionary, result.count > 0 {
            let customResponeObject = MobileDataResponse.init(responseObj: json[APIKeys.result])
            records?.append(customResponeObject)
            total = customResponeObject.total
            nextUrl = customResponeObject.link?.next
            return customResponeObject.records
        }
        
        return nil
    }
}

// API calls
extension MobileDataUsageStore: APIServiceDelegate {
    func initMobileDataUsageStore() {
        APIServices.shared.delegate = self
        self.serviceType = ApiServiceType.ApiServiceFirst
        APIServices.shared.loadInitialService()
    }
    
    func nextMobileDataUsageStore() {
        APIServices.shared.delegate = self
        self.serviceType = ApiServiceType.ApiServiceNext
        if let next = nextUrl {
            APIServices.shared.loadService(nextUrl: next)
        } else {
            self.delegate?.didDataChanged(newlyAdded: [])
        }
    }
    
    
    func requestCompletedWithSuccess(response: Any) {
        print("API Success dele: \(response)")
        if let records = processJsonAndStore(responseObject: response) {
            if self.serviceType == ApiServiceType.ApiServiceFirst {                
                self.delegate?.didDataRefresh(items: records)
            } else if self.serviceType == ApiServiceType.ApiServiceNext {
                self.delegate?.didDataChanged(newlyAdded: records)
            }
        } else {
            print("Error occured while parsing the data dele")
        }
    }
    
    func requestCompletedWithError(message: String?) {
        print("Error occured dele: \(String(describing: message))")
    }
}
