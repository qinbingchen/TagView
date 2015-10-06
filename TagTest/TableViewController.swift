//
//  TableViewController.swift
//  TagTest
//
//  Created by qin on 15/9/23.
//  Copyright © 2015年 qin. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController, TagContainerViewDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.estimatedRowHeight = 200.0
    }

    // MARK: - Table view data source

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("tagCell", forIndexPath: indexPath) as! TableViewTagCell
        cell.tagContailerView.delegate = self
        cell.tagContailerView.tagData = ["PHP", "Java", "C++", "Swift", "Haskel", "Prolog", "PHP", "Java", "C++", "Swift", "Haskel", "PHP", "Java", "C++", "Swift", "Haskel", "Prolog", "PHP", "Java", "C++", "Swift", "Haskel"]
        
        if indexPath.row % 2 == 1 {
            cell.tagContailerView.showSwitchButton = false
        }

        return cell
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    // MARK: - Tag Container View Delegate
    
    func tagContainerView(tagContainerView: TagContainerView, didSelectItemAtIndex indexPath: NSIndexPath) {
        print("didSelectItemAtIndex: \(indexPath)")
        
        if indexPath.row == (tagContainerView.tagData!.count - 1) { //Click the last tag, namely AddTagButton
            tagContainerView.tagData?.insert("new \(tagContainerView.tagData!.count)", atIndex: 0)
        }
    }
}
