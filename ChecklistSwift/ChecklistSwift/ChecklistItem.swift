//
//  ChecklistItem.swift
//  ChecklistSwift
//
//  Created by 王享 on 15/12/25.
//  Copyright © 2015年 王享. All rights reserved.
//

import UIKit

class ChecklistItem: NSObject,NSCoding {
    
    var text:String?
    var checked:Bool?
    var shouldRemind:Bool?
    var dueDate:Date?
    
    override init(){
        super.init();
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(self.text, forKey: "Text")
        aCoder.encode(self.checked!, forKey: "Checked")
        aCoder.encode(self.dueDate,forKey: "DueDate")
        aCoder.encode(self.shouldRemind!, forKey: "ShouldRemind")
    }
    required init?(coder aDecoder: NSCoder) {
        self.text = aDecoder.decodeObject(forKey: "Text") as? String
        self.checked = aDecoder.decodeBool(forKey: "Checked")
        self.dueDate = aDecoder.decodeObject(forKey: "DueDate") as? Date
        self.shouldRemind = aDecoder.decodeBool(forKey: "ShouldRemind")
    }
    
    
    func toggleChecked(){
        self.checked! = !self.checked!
    }
}
