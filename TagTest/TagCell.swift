//
//  TagCell.swift
//  TagTest
//
//  Created by qin on 15/9/23.
//  Copyright © 2015年 qin. All rights reserved.
//

import UIKit

class TagCell: UICollectionViewCell {
    
    var label: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        label = UILabel()
        label.textColor = UIColor.redColor()
        
        self.translatesAutoresizingMaskIntoConstraints = false
        label.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(label)
        
        var constraints = [NSLayoutConstraint(item: label, attribute: .CenterY, relatedBy: .Equal,
            toItem: self, attribute: .CenterY, multiplier: 1.0, constant: 0.0)]
        constraints += [NSLayoutConstraint(item: label, attribute: .Left, relatedBy: .Equal,
            toItem: self, attribute: .Left, multiplier: 1.0, constant: TagContainerView.tagCellPadding)]
        let rightConstraint = NSLayoutConstraint(item: self, attribute: .Right, relatedBy: .Equal,
            toItem: label, attribute: .Right, multiplier: 1.0, constant: TagContainerView.tagCellPadding)
        rightConstraint.priority = 750
        constraints += [rightConstraint]
        
        self.addConstraints(constraints)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
}
