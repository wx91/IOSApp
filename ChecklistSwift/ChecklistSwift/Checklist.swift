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
        self.name = aDecoder.decodeObject(forKey: "Name") as? String
        self.iconName = aDecoder.decodeObject(forKey: "IconName") as? String
        self.items = aDecoder.decodeObject(forKey: "Items") as? Array
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(self.name, forKey: "Name")
        aCoder.encode(self.iconName, forKey: "IconName")
        aCoder.encode(self.items, forKey: "Items")
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
