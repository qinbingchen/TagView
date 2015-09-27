//
//  TagContainerView.swift
//  TagTest
//
//  Created by qin on 15/9/22.
//  Copyright © 2015年 qin. All rights reserved.
//

import UIKit

class TagContainerView: UIView, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    static let tagCellHeight: CGFloat = 30.0
    static let tagCellPadding: CGFloat = 8.0
    static let tagViewInteritemSpacingSpacing: CGFloat = 8.0
    static let tagViewLineSpacing: CGFloat = 8.0
    static let maxCollapsedTagViewRowCount = 3
    static let maxCollapsedTagViewHeight: CGFloat = 106.0
    static let switchButtonHeight: CGFloat = 30.0
    
    weak var delegate: TagContainerViewDelegate?
    
    private var tagView: UICollectionView!
    private var switchButton: UIButton!
    
    var tagViewHeightConstraint: NSLayoutConstraint!
    var switchButtonHeightConstraint: NSLayoutConstraint!
    
    var showAllTags = false {
        didSet {
            let (height, _) = TagContainerView.calculateHeightAndRowCountForData(data: tagData!)
            if showAllTags {
                tagViewHeightConstraint.constant = height
                switchButton.setTitle("collapse", forState: .Normal)
            } else {
                tagViewHeightConstraint.constant = min(TagContainerView.maxCollapsedTagViewHeight, height)
                switchButton.setTitle("expand", forState: .Normal)
            }
        }
    }
    
    var tagData: [String]? {
        didSet {
            tagView.reloadData()
            let (_, rowCount) = TagContainerView.calculateHeightAndRowCountForData(data: tagData!)
            showAllTags = showAllTags.boolValue
            if rowCount <= 3 {
                switchButtonHeightConstraint.constant = 0.0
            } else {
                switchButtonHeightConstraint.constant = TagContainerView.switchButtonHeight
            }
        }
    }
    
    class func calculateHeightAndRowCountForData(data tagData: [String]) -> (CGFloat, Int) {
        let maxWidth = UIScreen.mainScreen().bounds.width - TableViewTagCell.tableViewCellPadding * 2
        var rowCount = 1
        var stackedWidth: CGFloat = 0.0
        for tag in tagData {
            let textWidth = ceil(tag.sizeWithAttributes([NSFontAttributeName: UIFont.systemFontOfSize(17.0)]).width * 2.0) / 2.0
            let tagWidth = textWidth + TagContainerView.tagCellPadding * 2
            if stackedWidth + tagWidth > maxWidth {
                rowCount++
                stackedWidth = tagWidth
            } else {
                stackedWidth += tagWidth
            }
            stackedWidth += TagContainerView.tagViewInteritemSpacingSpacing
        }
        let height = CGFloat(rowCount) * TagContainerView.tagCellHeight + CGFloat(rowCount - 1) * TagContainerView.tagViewLineSpacing
        return (height, rowCount)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        let layout = UICollectionViewLeftAlignedLayout()
        layout.estimatedItemSize = CGSize(width: 0.0, height: 30.0)
        layout.minimumInteritemSpacing = TagContainerView.tagViewInteritemSpacingSpacing
        layout.minimumLineSpacing = TagContainerView.tagViewLineSpacing
        tagView = UICollectionView(frame: CGRectZero, collectionViewLayout: layout)
        tagView.dataSource = self
        tagView.delegate = self
        tagView.registerClass(TagCell.classForCoder(), forCellWithReuseIdentifier: "identifier")
        tagView.backgroundColor = UIColor.whiteColor()
        tagView.scrollEnabled = false
        
        switchButton = UIButton(type: .System)
        switchButton.setTitle("expand", forState: .Normal)
        switchButton.addTarget(self, action: Selector("switchTagView:"), forControlEvents: .TouchUpInside)
        switchButton.clipsToBounds = true
        
        self.translatesAutoresizingMaskIntoConstraints = false
        tagView.translatesAutoresizingMaskIntoConstraints = false
        switchButton.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(tagView)
        self.addSubview(switchButton)
        
        var constraints = [NSLayoutConstraint(item: tagView, attribute: .Top, relatedBy: .Equal,
            toItem: self, attribute: .Top, multiplier: 1.0, constant: 0.0)]
        constraints += [NSLayoutConstraint(item: tagView, attribute: .Left, relatedBy: .Equal,
            toItem: self, attribute: .Left, multiplier: 1.0, constant: 0.0)]
        constraints += [NSLayoutConstraint(item: tagView, attribute: .Right, relatedBy: .Equal,
            toItem: self, attribute: .Right, multiplier: 1.0, constant: 0.0)]
        constraints += [NSLayoutConstraint(item: tagView, attribute: .Bottom, relatedBy: .Equal,
            toItem: switchButton, attribute: .Top, multiplier: 1.0, constant: 0.0)]
        constraints += [NSLayoutConstraint(item: switchButton, attribute: .CenterX, relatedBy: .Equal,
            toItem: self, attribute: .CenterX, multiplier: 1.0, constant: 0.0)]
        let bottomConstraint = NSLayoutConstraint(item: switchButton, attribute: .Bottom, relatedBy: .Equal,
            toItem: self, attribute: .Bottom, multiplier: 1.0, constant: 0.0)
        bottomConstraint.priority = 750
        constraints += [bottomConstraint]
        switchButtonHeightConstraint = NSLayoutConstraint(item: switchButton, attribute: .Height, relatedBy: .Equal,
            toItem: nil, attribute: .NotAnAttribute, multiplier: 1.0, constant: TagContainerView.switchButtonHeight)
        constraints += [switchButtonHeightConstraint]
        tagViewHeightConstraint = NSLayoutConstraint(item: tagView, attribute: .Height, relatedBy: .Equal,
            toItem: nil, attribute: .NotAnAttribute, multiplier: 1.0, constant: TagContainerView.maxCollapsedTagViewHeight)
        constraints += [tagViewHeightConstraint]
        
        self.addConstraints(constraints)
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let tagData = tagData {
            return tagData.count
        } else {
            return 0
        }
    }

    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("identifier", forIndexPath: indexPath) as! TagCell
        cell.backgroundColor = UIColor.blackColor()
        cell.label.text = tagData![indexPath.item]
        return cell
    }
    
    func switchTagView(sender: UIButton) {
        showAllTags = !showAllTags
        delegate?.tagViewDidSwitch()
    }
    
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}

protocol TagContainerViewDelegate: class {
    
    func tagViewDidSwitch()
    
}
