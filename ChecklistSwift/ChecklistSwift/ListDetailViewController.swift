//
//  ListDetailViewController.swift
//  ChecklistSwift
//
//  Created by 王享 on 15/12/28.
//  Copyright © 2015年 王享. All rights reserved.
//

import UIKit
protocol ListDetailViewControllerDelegate {
    
    func listDetailViewControllerDidCancel(_ controller:ListDetailViewController)
    
    func listDetailViewController(_ controller:ListDetailViewController,didFinishAddingChecklist checklist:Checklist)
    
    func listDetailViewController(_ controller:ListDetailViewController,didFinishEditingChecklist checklist:Checklist)
    
}


class ListDetailViewController: UITableViewController,UITextFieldDelegate,IconPickerViewControllerDelegate {

    var textField:UITextField?
    var label:UILabel?
    var iconImageView:UIImageView?
    var doneBarButton:UIBarButtonItem?
    var checklistToEdit:Checklist?
    var delegate:ListDetailViewControllerDelegate?
    
    var _name:String?
    var _iconName:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let cancelBarButtonItem:UIBarButtonItem=UIBarButtonItem.init(barButtonSystemItem: UIBarButtonSystemItem.cancel, target: self, action: #selector(ListDetailViewController.cancel))
        self.navigationItem.leftBarButtonItem = cancelBarButtonItem
        
        self.doneBarButton = UIBarButtonItem.init(barButtonSystemItem: UIBarButtonSystemItem.done, target: self, action: #selector(ListDetailViewController.done));
        self.navigationItem.rightBarButtonItem = self.doneBarButton
        
        if(self.checklistToEdit != nil){
            self.title = "Edit CheckList"
            _name = self.checklistToEdit?.name
            _iconName = self.checklistToEdit?.iconName
        }else{
            self.title = "Add CheckList"
            _iconName = "Folder"
        }
        self.iconImageView?.image = UIImage.init(named: _iconName!)
        self.textField?.delegate = self
        self.textField?.becomeFirstResponder()
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2;
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let idetidier:String = "Cell"
        var cell:UITableViewCell? = tableView.dequeueReusableCell(withIdentifier: idetidier)
        if(cell == nil ){
            cell = UITableViewCell.init(style: UITableViewCellStyle.default, reuseIdentifier: idetidier)
        }
        if indexPath.row == 0 {
            self.textField = UITextField.init(frame: CGRect(x: 10, y: 7, width: 300, height: 30))
            self.textField?.placeholder="Name of List"
            self.textField?.text = _name
            cell?.contentView.addSubview(self.textField!)
        }else{
            self.label = UILabel.init(frame:CGRect(x: 20, y: 11, width: 150, height: 20))
            self.label?.text = _iconName
            self.label?.textAlignment = NSTextAlignment.center
            cell?.contentView.addSubview(self.label!)
            
            self.iconImageView = UIImageView.init(frame: CGRect(x: 200, y: 4, width: 36, height: 36))
            if(_iconName != nil){
                self.iconImageView?.image=UIImage.init(named:_iconName!)
            }
            cell?.accessoryType = UITableViewCellAccessoryType.disclosureIndicator
            [cell?.contentView .addSubview(self.iconImageView!)]
        }
        return cell!
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if(indexPath.section==0&&indexPath.row==3){
            return 220.0
        }else{
            return UITableViewAutomaticDimension
        }
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if(indexPath.row == 1){
            let controller:IconPickerViewController = IconPickerViewController()
            controller.delegate=self
            self.navigationController?.pushViewController(controller, animated: true)
        }
    }
    

    func cancel(){
        self.delegate?.listDetailViewControllerDidCancel(self)
    }
    
    func done(){
        if(self.checklistToEdit == nil){
            checklistToEdit = Checklist.init();
            checklistToEdit?.name=self.textField?.text
            checklistToEdit?.iconName=_iconName
            self.delegate?.listDetailViewController(self, didFinishAddingChecklist: checklistToEdit!)
        }else{
            self.checklistToEdit?.name=self.textField?.text
            self.checklistToEdit?.iconName=_iconName
            self.delegate?.listDetailViewController(self, didFinishEditingChecklist: self.checklistToEdit!);
        }
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let newText:String = textField.text!;
        self.doneBarButton?.isEnabled = !newText.isEmpty
        return true
    }
    
    func iconPicker(_ picker:IconPickerViewController, didPickIcon iconName:String){
        _iconName = iconName;
        self.iconImageView!.image = UIImage.init(named: _iconName!)
        self.label!.text = _iconName;
        self.navigationController!.popViewController(animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
