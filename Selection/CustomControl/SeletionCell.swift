//
//  SeletionCell.swift
//  Selection
//
//  Created by April on 3/13/16.
//  Copyright © 2016 BuildersAccess. All rights reserved.
//

import UIKit

class SeletionCell: CiaCell {
   

//    @IBOutlet var seperatorHeight: NSLayoutConstraint!
    @IBOutlet var pricelevel: UILabel!
    @IBOutlet var selectionName: UILabel!
    @IBOutlet var idSelection: UILabel!
    @IBOutlet var type: UILabel!
    @IBOutlet var priceBook: UILabel!
    
    func setContentDetail(item : AssemblySelectionObj){
        idSelection.text = item.idselection
        selectionName.text = item.selectionname
        type.text = item.type
        priceBook.text = item.pricebook
        pricelevel.text = item.pricelevel
    }
    
}
