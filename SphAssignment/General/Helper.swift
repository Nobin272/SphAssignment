//
//  Helper.swift
//  SphAssignment
//
//  Created by Nobin Thomas on 22/1/19.
//  Copyright © 2019 Nobin Thomas. All rights reserved.
//

import Foundation

class Helper {
    class func showPopupMessage(title: String, message: String, btnTitle:String?) -> UIAlertController {
        let alert = UIAlertController(title: title,
                                      message: message,
                                      preferredStyle: .alert)
        if let btn = btnTitle {
            alert.addAction(UIAlertAction(title: btn, style: .cancel, handler: nil))
        } else {
            alert.addAction(UIAlertAction(title: NSLocalizedString("DataUsageView.decreasePopup.dismiss", comment: ""), style: .cancel, handler: nil))
        }
        return alert;
    }
}
