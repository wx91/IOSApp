//
//  ItemDetailViewController.swift
//  ChecklistSwift
//
//  Created by 王享 on 15/12/28.
//  Copyright © 2015年 王享. All rights reserved.
//
//获取屏幕宽度
import UIKit

protocol ItemDetailViewControllerDelegate{
    
    func itemDetailViewControllerDidCancel(_ controller:ItemDetailViewController)
    
    func itemDetailViewController(_ controller:ItemDetailViewController,didFinishAddingItem item:ChecklistItem)
    
    func itemDetailViewController(_ controller:ItemDetailViewController, didFinishEditingItem item:ChecklistItem)
}
class ItemDetailViewController: UITableViewController {
    
    var doneBarButton:UIBarButtonItem?
    var textField:UITextField?
    var switchControl:UISwitch?
    var dueDateLabel:UILabel?
    var itemToEdit:ChecklistItem?
    var delegate:ItemDetailViewControllerDelegate?
    
    var _text:String?
    var _shouldRemind:Bool?
    var _datePickerVisible:Bool?
    var _dueDate:Date?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.textField?.becomeFirstResponder()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.isExclusiveTouch=true
        _datePickerVisible=false
        let cancelBarButton:UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.cancel, target: self, action: #selector(ItemDetailViewController.cancel))
        self.navigationItem.leftBarButtonItem=cancelBarButton;
        
         self.doneBarButton=UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.done, target: self, action: #selector(ItemDetailViewController.done))
         self.navigationItem.rightBarButtonItem=self.doneBarButton;
        
        if (self.itemToEdit != nil) {
            self.title="Edit Item"
            _text=self.itemToEdit!.text
            _shouldRemind=self.itemToEdit!.shouldRemind
            _dueDate=self.itemToEdit!.dueDate as Date?
        }else{
            self.title="Add Item"
            _shouldRemind=false;
            _dueDate=Date.init()
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if( section == 0 && _datePickerVisible!){
            return 4
        }else{
            return 3
        }
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let KScreenWidth = UIScreen.main.bounds.size.width;
        let identifier:String = "Cell"
        var cell:UITableViewCell? = tableView.dequeueReusableCell(withIdentifier: identifier)
        if(cell == nil){
            cell = UITableViewCell.init(style: UITableViewCellStyle.default, reuseIdentifier: identifier)
        }
        if(indexPath.row == 0){
            self.textField = UITextField.init(frame: CGRect(x: 10, y: 7, width: 300, height: 30))
            self.textField?.placeholder="Checklist of Name"
            self.textField?.text=_text
            cell?.contentView.addSubview(self.textField!)
        }else if (indexPath.row==1){
            let label:UILabel = UILabel.init(frame: CGRect(x: 10, y: 7, width: 100, height: 30))
            label.text="Remind Me"
            label.textAlignment=NSTextAlignment.center
            cell?.addSubview(label)
            
            self.switchControl = UISwitch.init(frame: CGRect(x: 250, y: 6, width: 51, height: 31))
            self.switchControl?.isOn=_shouldRemind!
            cell?.addSubview(self.switchControl!)
        }else if(indexPath.row == 2){
            let label:UILabel = UILabel.init(frame: CGRect(x: 10, y: 7, width: 80, height: 30))
            label.text="Due Date"
            label.textAlignment = NSTextAlignment.center
            cell?.contentView.addSubview(label)
            
            self.dueDateLabel = UILabel.init(frame: CGRect(x: 100, y: 7, width: 220, height: 30))
            self.dueDateLabel?.textAlignment=NSTextAlignment.center
            cell?.contentView.addSubview(self.dueDateLabel!)
            self.updateDueDateLabel()
        }else{
            cell?.selectionStyle=UITableViewCellSelectionStyle.none
            let datePicker = UIDatePicker.init(frame: CGRect(x: 0,y: 0,width: KScreenWidth,height: 216))
            datePicker.tag = 100
            cell?.contentView.addSubview(datePicker)
            datePicker.addTarget(self, action: #selector(ItemDetailViewController.dateChanged(_:)), for: UIControlEvents.valueChanged)
        }
        return cell!
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    override func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        if(indexPath.section==0&&indexPath.row==2){
            return indexPath;
        }else{
            return nil;
        }
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.tableView.deselectRow(at: indexPath, animated: true)
        self.textField?.resignFirstResponder()
        if (indexPath.section==0&&indexPath.row==2) {
            if (!_datePickerVisible!) {
                self.showDatePick()
            }else{
                self.hideDatePicker()
            }
        }
    }
    func cancel(){
        self.delegate?.itemDetailViewControllerDidCancel(self)
    }
    func done(){
        if (self.itemToEdit==nil) {
            self.itemToEdit = ChecklistItem.init()
            itemToEdit?.text=self.textField?.text
            itemToEdit?.checked=false
            self.itemToEdit?.shouldRemind=self.switchControl?.isOn
            itemToEdit?.dueDate=_dueDate
            self.delegate?.itemDetailViewController(self, didFinishAddingItem: self.itemToEdit!)
        }else{
            self.itemToEdit?.text=self.textField?.text
            self.itemToEdit?.shouldRemind=self.switchControl?.isOn
            self.itemToEdit?.dueDate=_dueDate
            self.delegate?.itemDetailViewController(self, didFinishEditingItem: self.itemToEdit!)
        }
    }
    /**
     显示选择的日期内容
     */
    func updateDueDateLabel(){
        let formatter:DateFormatter = DateFormatter.init()
        formatter.dateStyle=DateFormatter.Style.medium
        formatter.timeStyle=DateFormatter.Style.short
        self.dueDateLabel?.text=formatter.string(from: _dueDate!)
    }
    func dateChanged(_ datePicker:UIDatePicker){
        _dueDate = datePicker.date
        self.updateDueDateLabel()
    }
    
    func showDatePick(){
        _datePickerVisible=true
        let indexPathDateRow:IndexPath = IndexPath(row: 2, section: 0)
        let indexPathDatePicker:IndexPath = IndexPath(row: 3, section: 0)
        self.dueDateLabel?.tintColor=UIColor.blue
        self.tableView.beginUpdates()
        self.tableView.insertRows(at: [indexPathDatePicker], with: UITableViewRowAnimation.automatic)
        self.tableView.reloadRows(at: [indexPathDateRow], with: UITableViewRowAnimation.automatic)
        self.tableView.endUpdates()
        
        let datePickerCell:UITableViewCell? = self.tableView.cellForRow(at: indexPathDatePicker)
        let datePicker:UIDatePicker = datePickerCell!.viewWithTag(100) as! UIDatePicker
        datePicker.setDate(_dueDate!, animated: true)
    }
    
    func hideDatePicker(){
        if(_datePickerVisible!){
            _datePickerVisible = false
            let indexPathDateRow:IndexPath = IndexPath(row: 2, section: 0)
            let indexPathDatePicker:IndexPath = IndexPath(row: 3, section: 0)
            self.dueDateLabel!.textColor=UIColor.darkGray
            self.tableView.beginUpdates()
            self.tableView.deleteRows(at: [indexPathDatePicker], with: UITableViewRowAnimation.automatic)
            self.tableView.reloadRows(at: [indexPathDateRow], with: UITableViewRowAnimation.automatic)
            self.tableView.endUpdates()
        }
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}


