//
//  ReportTableViewCell.swift
//  foucusTimer
//
//  Created by 永井涼 on 2021/06/17.
//

import UIKit

class ReportTableViewCell: UITableViewCell {


    @IBOutlet var view: UIView!
    @IBOutlet var treeImage: UIImageView!
    @IBOutlet var messageLabel: UILabel!
    @IBOutlet var treeBackGroundView: UIView!
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var timeLabel: UILabel!
    @IBOutlet var categoryLabel: UILabel!
    @IBOutlet var wordLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        view.layer.cornerRadius = 20
        treeBackGroundView.layer.cornerRadius = 25
        
    }
    
}
