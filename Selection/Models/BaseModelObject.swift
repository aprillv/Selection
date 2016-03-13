//
//  HapObject.swift
//  HappApp
//
//  Created by April on 11/12/15.
//  Copyright © 2015 lovetthomes. All rights reserved.
//

import Foundation

class BaseModelObject : NSObject{
    required init(dicInfo : [String: AnyObject]?){
        super.init()
        if let info = dicInfo {
            self.setValuesForKeysWithDictionary(info)
        }
        
    }
    
    private struct constants  {
        static let projectName : String = "Selection."
//        NSBundle.mainBundle().objectForInfoDictionaryKey("CFBundleName") as! String
        static let lastName : String = "ItemObj"
    
    }
    
    
    override func setValue(value0: AnyObject?, forKey key: String) {
        var skey : String
//        if key == "description" {
//            skey = "cdescription"
//        }else{
            skey = key
//        }
        print("\(skey)")
        
        if let value = value0{
            if let dic = value as? [Dictionary<String, AnyObject>]{
                var tmpArray : [BaseModelObject] = [BaseModelObject]()
                for tmp0 in dic{
                    
                    let anyobjecType: AnyObject.Type = NSClassFromString(GetCapitalFirstWord(skey)!)!
                    if anyobjecType is BaseModelObject.Type {
                        let vc = (anyobjecType as! BaseModelObject.Type).init(dicInfo: tmp0)
                        tmpArray.append(vc)
                    }
                }
                super.setValue(tmpArray, forKey: skey)
            }else{
                super.setValue(value, forKey: skey as String)
            }
        }
        
        
    }
    
    private func GetCapitalFirstWord(str : String?) -> String?{
        if let str0 = str {
            let index = str0.startIndex.advancedBy(1)
            let firstCapitalWord = str0.substringToIndex(index).capitalizedString
            print(constants.projectName + firstCapitalWord + str0.substringFromIndex(index) + constants.lastName)
            return constants.projectName + firstCapitalWord + str0.substringFromIndex(index) + constants.lastName
        }
        return nil
    }
}