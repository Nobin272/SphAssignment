//
//  DisplayDataModel.swift
//  SphAssignment
//
//  Created by Nobin Thomas on 22/1/19.
//  Copyright © 2019 Nobin Thomas. All rights reserved.
//

import Foundation
class TableViewRecordModel {
    var year: String?
    var total: Double?
    var records: [MobileDataRecord]?
    var isDecrease: Bool?
    
    init(year: String?, total: Double?, records: [MobileDataRecord]?, isDecrease:Bool?) {
        self.year = year
        self.total = total
        self.records = records
        self.isDecrease = isDecrease
    }
    
    class func getTableViewRecords(responseItems: [MobileDataRecord]?) -> [TableViewRecordModel]  {
        var records: [String: [MobileDataRecord]] = [:]
        if let res = responseItems, let count = responseItems?.count, count > 0 {
            for item in res {
                if let y2 = item.quarter?.split(separator: "-")[0] {
                    let val = res.filter {
                        let y1 = $0.quarter?.split(separator: "-")[0]
                        return (y1 == y2)
                    }
                    records["\(y2)"] = val
                }
            }
        }
        
        var tableViewRecords: [TableViewRecordModel] = []
        var year:String
        var isDec:Bool = false
        var tot: Double = 0.0
        var pVal:Double = 0.0
        for (k, vals) in records {
            year = k
            isDec = false
            tot = 0.0
            pVal = 0.0
            for val in vals {
                if let q = val.volumeOfMobileData {
                    tot += q
                    if q < pVal {
                        isDec = true
                    }
                    pVal = q
                }
            }
            
            if tot != 0 {
                // Add new data record - to display in tableview
                tableViewRecords.append(TableViewRecordModel.init(year: year, total: tot, records: vals, isDecrease: isDec))
            }
        }
        return tableViewRecords.sorted(by:{
            if let y1 = $0.year, let y2 = $1.year  {
                return y1 < y2
            }
            return true
        })
    }
        
        
}
