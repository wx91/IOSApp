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
        let addBarButtonItem:UIBarButtonItem = UIBarButtonItem(barButtonSystemItem:UIBarButtonSystemItem.add, target: self, action: #selector(AllListsViewController.AddChecklist))
        self.navigationItem.rightBarButtonItem = addBarButtonItem
    }
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1;
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(self.dataModel!.lists == nil){
            return 0
        }else{
            return self.dataModel!.lists!.count
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifer:String? = "Cell"
        var cell:UITableViewCell? = tableView.dequeueReusableCell(withIdentifier: identifer!)
        if cell == nil {
            cell = UITableViewCell(style: UITableViewCellStyle.subtitle, reuseIdentifier:identifer);
        }
        cell!.textLabel?.text="测试"
        let checklist:Checklist = self.dataModel!.lists![indexPath.row]
        cell!.textLabel?.text=checklist.name
        if checklist.iconName != nil {
            cell!.imageView?.image=UIImage(named: checklist.iconName!)
        }
        cell!.accessoryType=UITableViewCellAccessoryType.detailDisclosureButton
        let count:Int = checklist.countUncheckedItems()
        if checklist.items != nil {
            if checklist.items!.count == 0 {
                cell!.detailTextLabel?.text = "(No Items)"
            }
        }
        if count == 0 {
            cell!.detailTextLabel?.text = "全部搞定收工"
        }else{
            cell!.detailTextLabel?.text = "".appendingFormat("%d Remaining", count)
        }
        return cell!;
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let controller:ChecklistViewController = ChecklistViewController()
        let checklist:Checklist = self.dataModel!.lists![indexPath.row]
        controller.checklist = checklist
        controller.delegate=self
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        let controller:ListDetailViewController = ListDetailViewController.init(style:UITableViewStyle.grouped);
        controller.delegate=self
        let checklist:Checklist = self.dataModel!.lists![indexPath.row]
        controller.checklistToEdit=checklist
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCellEditingStyle.delete {
            self.dataModel!.lists!.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: UITableViewRowAnimation.automatic)
        }
    }
    
    func AddChecklist(){
        let controller:ListDetailViewController = ListDetailViewController.init(style:UITableViewStyle.grouped);
        controller.delegate=self
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    func ChecklistViewControllerDidBack(_ controller:ChecklistViewController){
        self.tableView.reloadData()
        self.navigationController?.popToViewController(self, animated: true)
    }
    
    func listDetailViewControllerDidCancel(_ controller:ListDetailViewController){
        self.navigationController?.popToViewController(self, animated: true)
    }
    
    func listDetailViewController(_ controller:ListDetailViewController,didFinishAddingChecklist checklist:Checklist){
        if(self.dataModel!.lists == nil){
            self.dataModel!.lists = Array<Checklist>();
        }
        self.dataModel?.lists?.append(checklist)
        
        self.tableView.reloadData()
        self.navigationController?.popToViewController(self, animated: true)
    }
    
    func listDetailViewController(_ controller:ListDetailViewController,didFinishEditingChecklist checklist:Checklist){
        self.tableView.reloadData()
        self.navigationController?.popToViewController(self, animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
