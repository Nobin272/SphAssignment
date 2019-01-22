//
//  DataUsageViewController.swift
//  SphAssignment
//
//  Created by Nobin Thomas on 22/1/19.
//  Copyright © 2019 Nobin Thomas. All rights reserved.
//

import UIKit

class DataUsageViewController: UIViewController {
    weak var tbViewKeeper: UITableView?
    
    let lbNoData: UILabel = {
        let lb          = UILabel()
        lb.text         = ConstantStrings.DataUsageView.NoData
        lb.font         = Constants.SPHFont.fontMedium15
        lb.isHidden     = false
        return lb
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        localization()
        //        btnScrollToTop.isHidden = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    func localization() {
        
    }
    
    func setUpSize() {
        
    }
    
    @IBAction func refresh(_ sender: Any) {

    }
}

