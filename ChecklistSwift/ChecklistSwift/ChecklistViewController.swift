//
//  ChecklistViewController.swift
//  ChecklistSwift
//
//  Created by 王享 on 15/12/28.
//  Copyright © 2015年 王享. All rights reserved.
//

import UIKit
protocol ChecklistViewControllerDelegate{
    
    func ChecklistViewControllerDidBack(_ controller:ChecklistViewController)
    
}

class ChecklistViewController: UITableViewController,ItemDetailViewControllerDelegate{
    
    var checklist:Checklist?
    var delegate:ChecklistViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = self.checklist!.name
        let backBarButtonItem:UIBarButtonItem = UIBarButtonItem.init(title: "Checklist", style: UIBarButtonItemStyle.done, target: self, action: #selector(ChecklistViewController.BackAlllists))
        self.navigationItem.leftBarButtonItem=backBarButtonItem
        
        let addBarButtonItem:UIBarButtonItem = UIBarButtonItem.init(barButtonSystemItem: UIBarButtonSystemItem.add, target: self, action: #selector(ChecklistViewController.AddChecklistItem))
        self.navigationItem.rightBarButtonItem=addBarButtonItem
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(self.checklist!.items == nil){
            return 0;
        }else{
            return self.checklist!.items!.count
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier:String = "cell"
        var cell:UITableViewCell? = tableView.dequeueReusableCell(withIdentifier: identifier)
        if(cell == nil) {
            cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: identifier)
        }
        let label1:UILabel = UILabel.init(frame:CGRect(x: 10, y: 7, width: 20, height: 30))
        label1.tag=101
        cell!.contentView.addSubview(label1)
        let label2:UILabel = UILabel.init(frame: CGRect(x: 30, y: 7, width: 240, height: 30))
        label2.tag=102
        cell!.contentView.addSubview(label2)
        
        let checklistitem:ChecklistItem = self.checklist!.items![indexPath.row]
        self.configureCheckmarkForCell(cell!, withChecklistItem: checklistitem)
        self.configureTextForCell(cell!, withChecklistItem: checklistitem)
        
        cell!.accessoryType=UITableViewCellAccessoryType.detailDisclosureButton
        
        return cell!
    }
    
    func configureCheckmarkForCell(_ cell:UITableViewCell,withChecklistItem item:ChecklistItem){
        let label:UILabel = cell.viewWithTag(101) as! UILabel
        if (item.checked!) {
            label.text = "√";
        } else {
            label.text = "";
        }
        label.textColor = self.view.tintColor;
    }
    
    func configureTextForCell(_ cell:UITableViewCell,withChecklistItem item:ChecklistItem){
        let label:UILabel = cell.viewWithTag(102) as! UILabel
        label.text=item.text
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell:UITableViewCell? = tableView.cellForRow(at: indexPath)
        let item:ChecklistItem = self.checklist!.items![indexPath.row]
        item.toggleChecked()
        self.configureCheckmarkForCell(cell!, withChecklistItem: item)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        let controller:ItemDetailViewController = ItemDetailViewController.init(style:UITableViewStyle.grouped);
        controller.delegate=self
        controller.itemToEdit=self.checklist!.items![indexPath.row]
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if(editingStyle == UITableViewCellEditingStyle.delete){
            self.checklist!.items!.remove(at: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: UITableViewRowAnimation.automatic)
        }
    }
    
    func AddChecklistItem(){
        let controller:ItemDetailViewController = ItemDetailViewController.init(style:UITableViewStyle.grouped);
        controller.delegate=self
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    func BackAlllists(){
        self.delegate?.ChecklistViewControllerDidBack(self)
    }
    
    func itemDetailViewControllerDidCancel(_ controller:ItemDetailViewController){
        self.navigationController?.popToViewController(self, animated: true)
    }
    
    func itemDetailViewController(_ controller:ItemDetailViewController,didFinishAddingItem item:ChecklistItem){
        var newRowIndex:Int = 0
        if(self.checklist!.items == nil){
            self.checklist?.items = Array<ChecklistItem>()
        }else{
             newRowIndex = self.checklist!.items!.count
        }
        self.checklist!.items!.append(item)
        let indexPath = IndexPath(item: newRowIndex, section: 0)
        self.tableView.insertRows(at: [indexPath], with: UITableViewRowAnimation.automatic)
        self.navigationController?.popToViewController(self, animated: true)
        self.tableView.reloadData()
    }
    
    func itemDetailViewController(_ controller:ItemDetailViewController, didFinishEditingItem item:ChecklistItem){
        let index:Int = self.checklist!.items!.index(of: item)!
        let indexPath = IndexPath(item: index, section: 0)
        let cell:UITableViewCell? = self.tableView.cellForRow(at: indexPath)
        self.configureTextForCell(cell!, withChecklistItem: item)
        self.navigationController?.popToViewController(self, animated: true)
        self.tableView.reloadData()
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    


}
