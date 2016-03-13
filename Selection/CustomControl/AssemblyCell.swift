//
//  AssemblyCell.swift
//  Selection
//
//  Created by April on 3/12/16.
//  Copyright © 2016 BuildersAccess. All rights reserved.
//

import UIKit

class AssemblyCell: CiaCell {

    @IBOutlet var Selection: UILabel!
    @IBOutlet var AssemblyName: UILabel!
    @IBOutlet var CostCode: UILabel!
    @IBOutlet var IdAssembly: UILabel!
    
    func setContentDetail(item : AssemblyItem){
        IdAssembly.text = item.idnumber!
        AssemblyName.text = item.name!
        CostCode.text = item.idcostcode!
        Selection.text = item.categorygroup!
    }
}
