//
//  UsageDataModel.swift
//  SphAssignment
//
//  Created by Nobin Thomas on 22/1/19.
//  Copyright © 2019 Nobin Thomas. All rights reserved.
//

import Foundation
import SwiftyJSON

class MobileDataResponse {
    var resource_id: String?
    var fields: [MobileDataField]?
    var records: [MobileDataRecord]?
    var link: MobileDataLinks?
    var limit: Int?
    var total: Int?
    
    init(responseObj: JSON) {
        self.resource_id = responseObj[APIKeys.resource_id].stringValue
        
        // Parsing fields
        self.fields = []
        for item in responseObj[APIKeys.fields].arrayValue {
            self.fields?.append(MobileDataField.init(field: item))
        }
        
        //Parsing Records
        self.records = []
        for item in responseObj[APIKeys.records].arrayValue {
            self.records?.append(MobileDataRecord.init(record: item))
        }
        
        // Parsing links
        self.link = MobileDataLinks.init(link: responseObj[APIKeys._links])
        
        // Parsing limit and total value
        self.limit = responseObj[APIKeys.limit].int
        self.total = responseObj[APIKeys.total].int
    }
}

class MobileDataField {
    var _id: Int?
    var type: String?
    
    init(field: JSON) {
        self._id = field[APIKeys.keyId].int
        self.type = field[APIKeys.type].stringValue
    }
}

class MobileDataRecord {
    var _id: Int?
    var volumeOfMobileData: Double?
    var quarter: String?
    
    init(record: JSON) {
        self._id = record[APIKeys._id].int
        self.volumeOfMobileData = record[APIKeys.volume_of_mobile_data].doubleValue
        self.quarter = record[APIKeys.quarter].stringValue
    }
    
    func getStringValue() -> String? {
        if let q = self.quarter?.split(separator: "-"), q.count > 0 {
            let qVal = "\(q[1])"
            return String(format: "%@ - %0.5f", qVal, self.volumeOfMobileData ?? 0)
        }
        return nil
    }
}

class MobileDataLinks {
    var start: String?
    var next: String?
    
    init(link: JSON) {
        self.start = link[APIKeys.start].stringValue
        self.next = link[APIKeys.next].stringValue
    }
}
