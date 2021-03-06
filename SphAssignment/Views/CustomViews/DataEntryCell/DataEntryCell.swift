//
//  DataEntryCell.swift
//  SphAssignment
//
//  Created by Nobin Thomas on 22/1/19.
//  Copyright © 2019 Nobin Thomas. All rights reserved.
//

import UIKit
protocol DataEntryCellDelegate {
    func DataEntryCellDidTapImage(cell: DataEntryCell)
}

class DataEntryCell: UITableViewCell {
    @IBOutlet weak var vLine        : UIView!
    @IBOutlet weak var lbYear       : UILabel!
    @IBOutlet weak var lbTotal      : UILabel!
    @IBOutlet weak var btNotifyIcon: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        bindUI()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    var delegate:DataEntryCellDelegate?
    
    var record: TableViewRecordModel? {
        didSet {
            self.setRecordValues(_record: record)
            layoutIfNeeded()
        }
    }
    
    func bindUI() {
        selectionStyle              = .none
    }
    
    func setRecordValues(_record: TableViewRecordModel?) {
        if let year = _record?.year {
            lbYear.text = year
        }
        
        if let tot = _record?.total {
            let totalStr = String(format: "%.5f", tot)
            lbTotal.text = "Total: \(totalStr)"
        }
        
        if _record?.isDecrease == true {
            btNotifyIcon.isHidden = true
        } else {
            btNotifyIcon.isHidden = false
        }
    }

    @IBAction func btnTapNotifiyIcon(_ sender: Any) {
        self.delegate?.DataEntryCellDidTapImage(cell: self)
    }
}
