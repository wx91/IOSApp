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
    var dueDate:NSDate?
    
    override init(){
        super.init();
    }
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(self.text, forKey: "Text")
        aCoder.encodeBool(self.checked!, forKey: "Checked")
        aCoder.encodeObject(self.dueDate,forKey: "DueDate")
        aCoder.encodeBool(self.shouldRemind!, forKey: "ShouldRemind")
    }
    required init?(coder aDecoder: NSCoder) {
        self.text = aDecoder.decodeObjectForKey("Text") as? String
        self.checked = aDecoder.decodeBoolForKey("Checked")
        self.dueDate = aDecoder.decodeObjectForKey("DueDate") as? NSDate
        self.shouldRemind = aDecoder.decodeBoolForKey("ShouldRemind")
    }
    
    
    func toggleChecked(){
        self.checked! = !self.checked!
    }
}
