//
//  IconPickerViewController.swift
//  ChecklistSwift
//
//  Created by 王享 on 15/12/28.
//  Copyright © 2015年 王享. All rights reserved.
//

import UIKit
protocol IconPickerViewControllerDelegate{
    func iconPicker(_ picker:IconPickerViewController, didPickIcon iconName:String)
}

class IconPickerViewController: UITableViewController {
    
    var icons:Array<String>?
    var delegate:IconPickerViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title="Chonse Icon"
        self.icons=["No Icon","Appointments","Birthdays","Chores","Drinks","Folder",
            "Groceries","Inbox","Photos","Trips"]
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.icons!.count;
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let identifier:String = "Cell"
        var cell:UITableViewCell? = tableView.dequeueReusableCell(withIdentifier: identifier)
        if cell == nil {
            cell = UITableViewCell.init(style: UITableViewCellStyle.default, reuseIdentifier: identifier)
        }
        let icon:String = self.icons![indexPath.row];
        cell!.textLabel!.text=icon;
        cell!.imageView!.image = UIImage.init(named:icon)
        return cell!
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let iconName:String  = self.icons![indexPath.row]
        [self.delegate!.iconPicker(self, didPickIcon: iconName)]
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
