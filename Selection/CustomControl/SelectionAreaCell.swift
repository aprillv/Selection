//
//  SelectionAreaCell.swift
//  Selection
//
//  Created by April on 3/13/16.
//  Copyright © 2016 BuildersAccess. All rights reserved.
//

import UIKit
import SDWebImage
class SelectionAreaCell: CiaCell {
    @IBOutlet var thumbnail: UIImageView!
    @IBOutlet var areaname: UILabel!
    @IBOutlet var des: UILabel!
    func setContentDetail(item : AssemblySelectionAreaObj){
        if let fs = item.fs,
            let areanameValue = item.selectionarea,
            let desValue = item.des{
                areaname.text = areanameValue
                des.text = desValue
                if fs == "False" {
                    thumbnail.hidden = true
                }else{
                    thumbnail.hidden = false
                    
                    thumbnail.sd_setImageWithURL(NSURL(string: "https://contractssl.buildersaccess.com/baselection_image?idcia=\(item.idcia!)&idassembly1=\(item.idassembly1!)&upc=\(item.upc!)&isthumbnail=1"))
                }
        }
    }
}
