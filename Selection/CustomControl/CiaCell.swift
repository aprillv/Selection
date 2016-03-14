//
//  CiaCell.swift
//  Selection
//
//  Created by April on 3/12/16.
//  Copyright © 2016 BuildersAccess. All rights reserved.
//

import UIKit

class CiaCell: UITableViewCell {
    @IBOutlet var lbl: UILabel!
    override func setHighlighted(highlighted: Bool, animated: Bool) {
        self.setCellBackColor(highlighted)
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        self.setCellBackColor(selected)
    }
    
    private func setCellBackColor(sels: Bool){
        if sels {
            self.backgroundColor = CConstants.SearchBarBackColor
            self.contentView.backgroundColor = CConstants.SearchBarBackColor
        }else{
            self.backgroundColor = UIColor.whiteColor()
            self.contentView.backgroundColor = UIColor.whiteColor()
        }
    }

}
