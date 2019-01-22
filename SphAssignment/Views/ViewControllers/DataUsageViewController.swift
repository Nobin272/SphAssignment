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
    var tbData:[TableViewRecordModel]? = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        records = []
        tbData = []
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
        configureInfiniteTableView()
        tbViewResults.delegate = self
        tbViewResults.dataSource = self
    }
    
    func configureInfiniteTableView() {
        tbViewResults.infiniteScrollIndicatorView = CustomInfiniteIndicator(frame: CGRect(x: 0, y: 0, width: 24, height: 24))
        tbViewResults.infiniteScrollIndicatorMargin = 40
        tbViewResults.infiniteScrollTriggerOffset = 500
        tbViewResults.addInfiniteScroll { [weak self] (tableView) -> Void in
            self?.reloadNextItems()
        }
        tbViewResults.setShouldShowInfiniteScrollHandler { [weak self] (tableView) -> Bool in
            if let tot = MobileDataUsageStore.shared.total, let rec = self?.records?.count {
                return tot > rec
            }
            return true;
         }
        
        
        // load initial data
        tbViewResults.beginInfiniteScroll(true)
    }
    
    func reloadData() {
        MobileDataUsageStore.shared.delegate = self
        MobileDataUsageStore.shared.initMobileDataUsageStore()
    }
    
    func reloadNextItems() {
        MobileDataUsageStore.shared.delegate = self
        MobileDataUsageStore.shared.nextMobileDataUsageStore()
    }
    
    func didDataRefresh(items: [MobileDataRecord]) {
        DispatchQueue.main.async {
            self.records = items
            self.refreshTableView()
        }
    }
    
    func didDataChanged(newlyAdded: [MobileDataRecord]) {
        DispatchQueue.main.async {
            self.records?.append(contentsOf: newlyAdded)
            self.tbViewResults.finishInfiniteScroll()
            self.refreshTableView()
        }
    }
    
    func refreshTableView () {
        tbData = TableViewRecordModel.getTableViewRecords(responseItems: self.records)
        self.tbViewResults.reloadData()
    }
}

extension DataUsageViewController: UITableViewDelegate, UITableViewDataSource, DataEntryCellDelegate {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.Cell.DataEntryCell) as! DataEntryCell
        cell.record = tbData?[indexPath.row]
        cell.delegate = self
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        //return 3+
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tbData?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let title = "\(NSLocalizedString("DataUsageView.decreasePopup.info", comment: ""))"
        let record = tbData?[indexPath.row]
        let qCount = record?.records?.count ?? 0
        let message = "\(qCount) Quarters"
        
        let alert = Helper.showPopupMessage(title: title, message: message, btnTitle: nil)
        present(alert, animated: true, completion: nil)
    }
    
    // Data EntryCell image Tap
    func DataEntryCellDidTapImage(cell: DataEntryCell) {
        let title = "\(NSLocalizedString("DataUsageView.decreasePopup.title", comment: ""))"
        
        let alert = Helper.showPopupMessage(title: title, message: NSLocalizedString("DataUsageView.decreasePopup.message", comment: ""), btnTitle: nil)
        present(alert, animated: true, completion: nil)
    }
    
    
    func registerCells () {
        tbViewResults.register(UINib(nibName: Constants.Cell.DataEntryCell, bundle: Bundle.main), forCellReuseIdentifier: Constants.Cell.DataEntryCell)
    }
}
