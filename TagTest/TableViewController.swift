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
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        self.tableView.estimatedRowHeight = 200.0
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
        // Configure the cell...

        return cell
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tagViewDidSwitch() {
        UIView.setAnimationsEnabled(false)
        tableView.beginUpdates()
        tableView.endUpdates()
        UIView.setAnimationsEnabled(true)
    }
    
    func didDeleteCellAtIndexPath(indexPath: NSIndexPath) {
        print(indexPath)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
