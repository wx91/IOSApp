//
//  AllListsViewController.swift
//  ChecklistSwift
//
//  Created by 王享 on 15/12/25.
//  Copyright © 2015年 王享. All rights reserved.
//

import UIKit

class AllListsViewController: UITableViewController,ListDetailViewControllerDelegate,ChecklistViewControllerDelegate{

    var dataModel:DataModel?;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initSubView();
    }
    
    func initSubView(){
        let addBarButtonItem:UIBarButtonItem = UIBarButtonItem(barButtonSystemItem:UIBarButtonSystemItem.Add, target: self, action: #selector(AllListsViewController.AddChecklist))
        self.navigationItem.rightBarButtonItem = addBarButtonItem
    }
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1;
    }
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(self.dataModel!.lists == nil){
            return 0
        }else{
            return self.dataModel!.lists!.count
        }
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let identifer:String? = "Cell"
        var cell:UITableViewCell? = tableView.dequeueReusableCellWithIdentifier(identifer!)
        if cell == nil {
            cell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier:identifer);
        }
        cell!.textLabel?.text="测试"
        let checklist:Checklist = self.dataModel!.lists![indexPath.row]
        cell!.textLabel?.text=checklist.name
        if checklist.iconName != nil {
            cell!.imageView?.image=UIImage(named: checklist.iconName!)
        }
        cell!.accessoryType=UITableViewCellAccessoryType.DetailDisclosureButton
        let count:Int = checklist.countUncheckedItems()
        if checklist.items != nil {
            if checklist.items!.count == 0 {
                cell!.detailTextLabel?.text = "(No Items)"
            }
        }
        if count == 0 {
            cell!.detailTextLabel?.text = "全部搞定收工"
        }else{
            cell!.detailTextLabel?.text = "".stringByAppendingFormat("%d Remaining", count)
        }
        return cell!;
    }
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let controller:ChecklistViewController = ChecklistViewController()
        let checklist:Checklist = self.dataModel!.lists![indexPath.row]
        controller.checklist = checklist
        controller.delegate=self
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    override func tableView(tableView: UITableView, accessoryButtonTappedForRowWithIndexPath indexPath: NSIndexPath) {
        let controller:ListDetailViewController = ListDetailViewController.init(style:UITableViewStyle.Grouped);
        controller.delegate=self
        let checklist:Checklist = self.dataModel!.lists![indexPath.row]
        controller.checklistToEdit=checklist
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == UITableViewCellEditingStyle.Delete {
            self.dataModel!.lists!.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Automatic)
        }
    }
    
    func AddChecklist(){
        let controller:ListDetailViewController = ListDetailViewController.init(style:UITableViewStyle.Grouped);
        controller.delegate=self
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    func ChecklistViewControllerDidBack(controller:ChecklistViewController){
        self.tableView.reloadData()
        self.navigationController?.popToViewController(self, animated: true)
    }
    
    func listDetailViewControllerDidCancel(controller:ListDetailViewController){
        self.navigationController?.popToViewController(self, animated: true)
    }
    
    func listDetailViewController(controller:ListDetailViewController,didFinishAddingChecklist checklist:Checklist){
        if(self.dataModel!.lists == nil){
            self.dataModel!.lists = Array<Checklist>();
        }
        self.dataModel?.lists?.append(checklist)
        
        self.tableView.reloadData()
        self.navigationController?.popToViewController(self, animated: true)
    }
    
    func listDetailViewController(controller:ListDetailViewController,didFinishEditingChecklist checklist:Checklist){
        self.tableView.reloadData()
        self.navigationController?.popToViewController(self, animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
