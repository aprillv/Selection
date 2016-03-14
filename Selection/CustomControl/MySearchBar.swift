//
//  MySearchBar.swift
//  Selection
//
//  Created by April on 3/14/16.
//  Copyright © 2016 BuildersAccess. All rights reserved.
//

import UIKit

class MySearchBar: UISearchBar {
    override func layoutSubviews() {
        super.layoutSubviews()
        if let l = getTextFieldLabel() {
            l.addObserver(self, forKeyPath: "frame", options: .New, context: nil)
        }
        if let i = getIcon() {
            i.addObserver(self, forKeyPath: "frame", options: .New, context: nil)
        }
    }
    
    override func observeValueForKeyPath(keyPath: String?, ofObject object: AnyObject?, change: [String : AnyObject]?, context:     UnsafeMutablePointer<Void>) {
        
        if let l = object as? UILabel {
            l.removeObserver(self, forKeyPath: "frame")
            l.frame = CGRect(x: 29, y: 1, width: 323, height: 25)
            l.addObserver(self, forKeyPath: "frame", options: .New, context: nil)
        }
        
        if let i = object as? UIImageView {
            i.removeObserver(self, forKeyPath: "frame")
            i.frame = CGRect(x: 8, y: 7.5, width: 13, height: 13)
            i.addObserver(self, forKeyPath: "frame", options: .New, context: nil)
        }
    }
    
    func getTextFieldLabel() -> UILabel? {
        for v in self.allSubViews(self) {
            if NSStringFromClass(v.dynamicType) == "UISearchBarTextFieldLabel" {
                return v as? UILabel
            }
        }
        return nil
    }
    
    func getIcon() -> UIImageView? {
        for v in self.allSubViews(self) {
            if NSStringFromClass(v.dynamicType) == "UIImageView" {
                return v as? UIImageView
            }
        }
        return nil
    }
    
    func allSubViews( v : UIView!) -> [UIView] {
        var views : [UIView] = []
        views += v.subviews
        for s in v.subviews {
            views += allSubViews(s)
        }
        return views
    }
}
