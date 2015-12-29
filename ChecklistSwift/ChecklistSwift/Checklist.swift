//
//  Checklist.swift
//  ChecklistSwift
//
//  Created by 王享 on 15/12/25.
//  Copyright © 2015年 王享. All rights reserved.
//

import UIKit

class Checklist: NSObject,NSCoding{
    
    var name:String?
    
    var iconName:String?
    
    var items:Array<ChecklistItem>?
    
    override init(){
        super.init();
    }
    
    required init?(coder aDecoder: NSCoder){
        self.name = aDecoder.decodeObjectForKey("Name") as? String
        self.iconName = aDecoder.decodeObjectForKey("IconName") as? String
        self.items = aDecoder.decodeObjectForKey("Items") as? Array
    }
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(self.name, forKey: "Name")
        aCoder.encodeObject(self.iconName, forKey: "IconName")
        aCoder.encodeObject(self.items, forKey: "Items")
    }
    
    
    func countUncheckedItems() -> Int{
        var count:Int = 0
        if self.items != nil {
            for item:ChecklistItem in self.items! {
                if !item.checked! {
                    count += 1
                }
            }
        }
        return count
    }
}
