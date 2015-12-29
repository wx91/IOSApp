//
//  DataModel.swift
//  ChecklistSwift
//
//  Created by 王享 on 15/12/25.
//  Copyright © 2015年 王享. All rights reserved.
//

import UIKit

class DataModel: NSObject {
    
    var lists:Array<Checklist>?
    
    override init(){
        super.init()
        self.loadChecklists()
    }
    
    func documentsDirectory() -> String{
        if let dirs:[String] = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.AllDomainsMask, true) {
            let dir:String = dirs[0]
            return dir;
        }
    }
    func dataFilePath() -> String{
        let path = self.documentsDirectory()
        return path.stringByAppendingString("/Checklists.plist");
    }
    func saveChecklists(){
        let data:NSMutableData = NSMutableData()
        let archiver:NSKeyedArchiver = NSKeyedArchiver.init(forWritingWithMutableData: data)
        archiver.finishEncoding()
        data.writeToFile(self.dataFilePath(), atomically:true)
    }
    
    func loadChecklists() {
        let path:String = self.dataFilePath()
        if NSFileManager.defaultManager().fileExistsAtPath(path){
            let data:NSData = NSData(contentsOfFile: path)!;
            let unarchiver:NSKeyedUnarchiver = NSKeyedUnarchiver(forReadingWithData: data)
            self.lists = unarchiver.decodeObjectForKey("Checklists") as? Array<Checklist>
            unarchiver.finishDecoding()
        }else{
            let checklist:Checklist = Checklist();
            self.lists = Array<Checklist>(count:1,repeatedValue:checklist);
        }
    }
}
