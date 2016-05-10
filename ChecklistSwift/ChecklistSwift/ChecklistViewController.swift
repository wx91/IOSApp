//
//  ChecklistViewController.swift
//  ChecklistSwift
//
//  Created by 王享 on 15/12/28.
//  Copyright © 2015年 王享. All rights reserved.
//

import UIKit
protocol ChecklistViewControllerDelegate{
    
    func ChecklistViewControllerDidBack(controller:ChecklistViewController)
    
}

class ChecklistViewController: UITableViewController,ItemDetailViewControllerDelegate{
    
    var checklist:Checklist?
    var delegate:ChecklistViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = self.checklist!.name
        let backBarButtonItem:UIBarButtonItem = UIBarButtonItem.init(title: "Checklist", style: UIBarButtonItemStyle.Done, target: self, action: #selector(ChecklistViewController.BackAlllists))
        self.navigationItem.leftBarButtonItem=backBarButtonItem
        
        let addBarButtonItem:UIBarButtonItem = UIBarButtonItem.init(barButtonSystemItem: UIBarButtonSystemItem.Add, target: self, action: #selector(ChecklistViewController.AddChecklistItem))
        self.navigationItem.rightBarButtonItem=addBarButtonItem
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(self.checklist!.items == nil){
            return 0;
        }else{
            return self.checklist!.items!.count
        }
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let identifier:String = "cell"
        var cell:UITableViewCell? = tableView.dequeueReusableCellWithIdentifier(identifier)
        if(cell == nil) {
            cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: identifier)
        }
        let label1:UILabel = UILabel.init(frame:CGRectMake(10, 7, 20, 30))
        label1.tag=101
        cell!.contentView.addSubview(label1)
        let label2:UILabel = UILabel.init(frame: CGRectMake(30, 7, 240, 30))
        label2.tag=102
        cell!.contentView.addSubview(label2)
        
        let checklistitem:ChecklistItem = self.checklist!.items![indexPath.row]
        self.configureCheckmarkForCell(cell!, withChecklistItem: checklistitem)
        self.configureTextForCell(cell!, withChecklistItem: checklistitem)
        
        cell!.accessoryType=UITableViewCellAccessoryType.DetailDisclosureButton
        
        return cell!
    }
    
    func configureCheckmarkForCell(cell:UITableViewCell,withChecklistItem item:ChecklistItem){
        let label:UILabel = cell.viewWithTag(101) as! UILabel
        if (item.checked!) {
            label.text = "√";
        } else {
            label.text = "";
        }
        label.textColor = self.view.tintColor;
    }
    
    func configureTextForCell(cell:UITableViewCell,withChecklistItem item:ChecklistItem){
        let label:UILabel = cell.viewWithTag(102) as! UILabel
        label.text=item.text
    }

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let cell:UITableViewCell? = tableView.cellForRowAtIndexPath(indexPath)
        let item:ChecklistItem = self.checklist!.items![indexPath.row]
        item.toggleChecked()
        self.configureCheckmarkForCell(cell!, withChecklistItem: item)
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    override func tableView(tableView: UITableView, accessoryButtonTappedForRowWithIndexPath indexPath: NSIndexPath) {
        let controller:ItemDetailViewController = ItemDetailViewController.init(style:UITableViewStyle.Grouped);
        controller.delegate=self
        controller.itemToEdit=self.checklist!.items![indexPath.row]
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if(editingStyle == UITableViewCellEditingStyle.Delete){
            self.checklist!.items!.removeAtIndex(indexPath.row)
            self.tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Automatic)
        }
    }
    
    func AddChecklistItem(){
        let controller:ItemDetailViewController = ItemDetailViewController.init(style:UITableViewStyle.Grouped);
        controller.delegate=self
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    func BackAlllists(){
        self.delegate?.ChecklistViewControllerDidBack(self)
    }
    
    func itemDetailViewControllerDidCancel(controller:ItemDetailViewController){
        self.navigationController?.popToViewController(self, animated: true)
    }
    
    func itemDetailViewController(controller:ItemDetailViewController,didFinishAddingItem item:ChecklistItem){
        var newRowIndex:Int = 0
        if(self.checklist!.items == nil){
            self.checklist?.items = Array<ChecklistItem>()
        }else{
             newRowIndex = self.checklist!.items!.count
        }
        self.checklist!.items!.append(item)
        let indexPath = NSIndexPath(forItem: newRowIndex, inSection: 0)
        self.tableView.insertRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Automatic)
        self.navigationController?.popToViewController(self, animated: true)
        self.tableView.reloadData()
    }
    
    func itemDetailViewController(controller:ItemDetailViewController, didFinishEditingItem item:ChecklistItem){
        let index:Int = self.checklist!.items!.indexOf(item)!
        let indexPath = NSIndexPath(forItem: index, inSection: 0)
        let cell:UITableViewCell? = self.tableView.cellForRowAtIndexPath(indexPath)
        self.configureTextForCell(cell!, withChecklistItem: item)
        self.navigationController?.popToViewController(self, animated: true)
        self.tableView.reloadData()
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    


}
