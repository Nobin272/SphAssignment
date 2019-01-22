//
//  DataUsageViewController.swift
//  SphAssignment
//
//  Created by Nobin Thomas on 22/1/19.
//  Copyright © 2019 Nobin Thomas. All rights reserved.
//

import UIKit

class DataUsageViewController: UIViewController {
    
    @IBOutlet weak var tbViewResults: UITableView!
    
    let lbNoData: UILabel = {
        let lb          = UILabel()
        lb.text         = ConstantStrings.DataUsageView.NoData
        lb.font         = Constants.SPHFont.fontMedium15
        lb.isHidden     = false
        return lb
    }()
    
    var records: [MobileDataRecord]? = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        records = []
        configureTable()
        reloadData()
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

extension DataUsageViewController: MobileDataUsageStoreDelegate {
    func configureTable() {
        tbViewResults.estimatedRowHeight = 153
        tbViewResults.rowHeight = UITableView.automaticDimension
        tbViewResults.separatorStyle = .none
        tbViewResults.backgroundColor = .clear
        registerCells()
        tbViewResults.delegate = self
        tbViewResults.dataSource = self
    }
    
    func reloadData() {
        MobileDataUsageStore.shared.delegate = self
        MobileDataUsageStore.shared.initMobileDataUsageStore()
    }
    
    func didDataRefresh(items: [MobileDataRecord]) {
        DispatchQueue.main.async {
            self.records = items
            self.tbViewResults.reloadData()
        }
    }
    
    func didDataChanged(newlyAdded: [MobileDataRecord]) {
        DispatchQueue.main.async {
            self.records = newlyAdded
            self.tbViewResults.reloadData()
        }
    }
}

extension DataUsageViewController: UITableViewDelegate, UITableViewDataSource, DataEntryCellDelegate {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.Cell.DataEntryCell) as! DataEntryCell
        cell.record = records?[indexPath.row]
        cell.delegate = self
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        //return 3+
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return records?.count ?? 0
    }
    
    // Data EntryCell image Tap
    func DataEntryCellDidTapImage(cell: DataEntryCell) {
        
    }
    
    
    func registerCells () {
        tbViewResults.register(UINib(nibName: Constants.Cell.DataEntryCell, bundle: Bundle.main), forCellReuseIdentifier: Constants.Cell.DataEntryCell)
    }
}
