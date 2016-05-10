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
    
    func itemDetailViewControllerDidCancel(controller:ItemDetailViewController)
    
    func itemDetailViewController(controller:ItemDetailViewController,didFinishAddingItem item:ChecklistItem)
    
    func itemDetailViewController(controller:ItemDetailViewController, didFinishEditingItem item:ChecklistItem)
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
    var _dueDate:NSDate?
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.textField?.becomeFirstResponder()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.exclusiveTouch=true
        _datePickerVisible=false
        let cancelBarButton:UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Cancel, target: self, action: #selector(ItemDetailViewController.cancel))
        self.navigationItem.leftBarButtonItem=cancelBarButton;
        
         self.doneBarButton=UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Done, target: self, action: #selector(ItemDetailViewController.done))
         self.navigationItem.rightBarButtonItem=self.doneBarButton;
        
        if (self.itemToEdit != nil) {
            self.title="Edit Item"
            _text=self.itemToEdit!.text
            _shouldRemind=self.itemToEdit!.shouldRemind
            _dueDate=self.itemToEdit!.dueDate
        }else{
            self.title="Add Item"
            _shouldRemind=false;
            _dueDate=NSDate.init()
        }
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if( section == 0 && _datePickerVisible!){
            return 4
        }else{
            return 3
        }
    }
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let KScreenWidth = UIScreen.mainScreen().bounds.size.width;
        let identifier:String = "Cell"
        var cell:UITableViewCell? = tableView.dequeueReusableCellWithIdentifier(identifier)
        if(cell == nil){
            cell = UITableViewCell.init(style: UITableViewCellStyle.Default, reuseIdentifier: identifier)
        }
        if(indexPath.row == 0){
            self.textField = UITextField.init(frame: CGRectMake(10, 7, 300, 30))
            self.textField?.placeholder="Checklist of Name"
            self.textField?.text=_text
            cell?.contentView.addSubview(self.textField!)
        }else if (indexPath.row==1){
            let label:UILabel = UILabel.init(frame: CGRectMake(10, 7, 100, 30))
            label.text="Remind Me"
            label.textAlignment=NSTextAlignment.Center
            cell?.addSubview(label)
            
            self.switchControl = UISwitch.init(frame: CGRectMake(250, 6, 51, 31))
            self.switchControl?.on=_shouldRemind!
            cell?.addSubview(self.switchControl!)
        }else if(indexPath.row == 2){
            let label:UILabel = UILabel.init(frame: CGRectMake(10, 7, 80, 30))
            label.text="Due Date"
            label.textAlignment = NSTextAlignment.Center
            cell?.contentView.addSubview(label)
            
            self.dueDateLabel = UILabel.init(frame: CGRectMake(100, 7, 220, 30))
            self.dueDateLabel?.textAlignment=NSTextAlignment.Center
            cell?.contentView.addSubview(self.dueDateLabel!)
            self.updateDueDateLabel()
        }else{
            cell?.selectionStyle=UITableViewCellSelectionStyle.None
            let datePicker = UIDatePicker.init(frame: CGRectMake(0,0,KScreenWidth,216))
            datePicker.tag = 100
            cell?.contentView.addSubview(datePicker)
            datePicker.addTarget(self, action: #selector(ItemDetailViewController.dateChanged(_:)), forControlEvents: UIControlEvents.ValueChanged)
        }
        return cell!
    }
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    override func tableView(tableView: UITableView, willSelectRowAtIndexPath indexPath: NSIndexPath) -> NSIndexPath? {
        if(indexPath.section==0&&indexPath.row==2){
            return indexPath;
        }else{
            return nil;
        }
    }
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.tableView.deselectRowAtIndexPath(indexPath, animated: true)
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
            self.itemToEdit?.shouldRemind=self.switchControl?.on
            itemToEdit?.dueDate=_dueDate
            self.delegate?.itemDetailViewController(self, didFinishAddingItem: self.itemToEdit!)
        }else{
            self.itemToEdit?.text=self.textField?.text
            self.itemToEdit?.shouldRemind=self.switchControl?.on
            self.itemToEdit?.dueDate=_dueDate
            self.delegate?.itemDetailViewController(self, didFinishEditingItem: self.itemToEdit!)
        }
    }
    /**
     显示选择的日期内容
     */
    func updateDueDateLabel(){
        let formatter:NSDateFormatter = NSDateFormatter.init()
        formatter.dateStyle=NSDateFormatterStyle.MediumStyle
        formatter.timeStyle=NSDateFormatterStyle.ShortStyle
        self.dueDateLabel?.text=formatter.stringFromDate(_dueDate!)
    }
    func dateChanged(datePicker:UIDatePicker){
        _dueDate = datePicker.date
        self.updateDueDateLabel()
    }
    
    func showDatePick(){
        _datePickerVisible=true
        let indexPathDateRow:NSIndexPath = NSIndexPath(forRow: 2, inSection: 0)
        let indexPathDatePicker:NSIndexPath = NSIndexPath(forRow: 3, inSection: 0)
        self.dueDateLabel?.tintColor=UIColor.blueColor()
        self.tableView.beginUpdates()
        self.tableView.insertRowsAtIndexPaths([indexPathDatePicker], withRowAnimation: UITableViewRowAnimation.Automatic)
        self.tableView.reloadRowsAtIndexPaths([indexPathDateRow], withRowAnimation: UITableViewRowAnimation.Automatic)
        self.tableView.endUpdates()
        
        let datePickerCell:UITableViewCell? = self.tableView.cellForRowAtIndexPath(indexPathDatePicker)
        let datePicker:UIDatePicker = datePickerCell!.viewWithTag(100) as! UIDatePicker
        datePicker.setDate(_dueDate!, animated: true)
    }
    
    func hideDatePicker(){
        if(_datePickerVisible!){
            _datePickerVisible = false
            let indexPathDateRow:NSIndexPath = NSIndexPath(forRow: 2, inSection: 0)
            let indexPathDatePicker:NSIndexPath = NSIndexPath(forRow: 3, inSection: 0)
            self.dueDateLabel!.textColor=UIColor.darkGrayColor()
            self.tableView.beginUpdates()
            self.tableView.deleteRowsAtIndexPaths([indexPathDatePicker], withRowAnimation: UITableViewRowAnimation.Automatic)
            self.tableView.reloadRowsAtIndexPaths([indexPathDateRow], withRowAnimation: UITableViewRowAnimation.Automatic)
            self.tableView.endUpdates()
        }
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}


