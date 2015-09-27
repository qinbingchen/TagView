//
//  TableViewTagCell.swift
//  TagTest
//
//  Created by qin on 15/9/23.
//  Copyright © 2015年 qin. All rights reserved.
//

import UIKit

class TableViewTagCell: UITableViewCell {

    static let tableViewCellPadding: CGFloat = 8.0
    
    @IBOutlet weak var tagContailerView: TagContainerView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
