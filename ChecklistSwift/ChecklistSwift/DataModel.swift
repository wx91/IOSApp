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
        if let dirs:[String] = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.allDomainsMask, true) {
            let dir:String = dirs[0]
            return dir;
        }
    }
    func dataFilePath() -> String{
        let path = self.documentsDirectory()
        return path + "/Checklists.plist";
    }
    func saveChecklists(){
        let data:NSMutableData = NSMutableData()
        let archiver:NSKeyedArchiver = NSKeyedArchiver.init(forWritingWith: data)
        archiver.finishEncoding()
        data.write(toFile: self.dataFilePath(), atomically:true)
    }
    
    func loadChecklists() {
        let path:String = self.dataFilePath()
        if FileManager.default.fileExists(atPath: path){
            let data:Data = try! Data(contentsOf: URL(fileURLWithPath: path));
            let unarchiver:NSKeyedUnarchiver = NSKeyedUnarchiver(forReadingWith: data)
            self.lists = unarchiver.decodeObject(forKey: "Checklists") as? Array<Checklist>
            unarchiver.finishDecoding()
        }else{
            let checklist:Checklist = Checklist();
            self.lists = Array<Checklist>(repeating: checklist,count: 1);
        }
    }
}
