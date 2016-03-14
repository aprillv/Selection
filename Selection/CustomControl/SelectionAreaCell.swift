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

    
    @IBOutlet var spinner: UIActivityIndicatorView!
    var superActionView : AnyObject?{
        didSet{
            toADDClockInTap()
        }
    }
    
    private func toADDClockInTap(){
        if let _ = superActionView, let _ = thumbnail {
            let tapGestureRecognizer = UITapGestureRecognizer(target:superActionView!, action:Selector("imageTapped:"))
            thumbnail.userInteractionEnabled = true
            tapGestureRecognizer.numberOfTapsRequired = 1
            thumbnail.addGestureRecognizer(tapGestureRecognizer)
        }
    }
    
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
                    
                    spinner.startAnimating()
                    thumbnail.sd_setImageWithURL(NSURL(string: "https://contractssl.buildersaccess.com/baselection_image?idcia=\(item.idcia!)&idassembly1=\(item.idassembly1!)&upc=\(item.upc!)&isthumbnail=1"), completed: { (_, _, _, _) -> Void in
                        self.spinner.stopAnimating()
                    })
//                    thumbnail.sd_setImageWithURL(NSURL(string: "https://contractssl.buildersaccess.com/baselection_image?idcia=\(item.idcia!)&idassembly1=\(item.idassembly1!)&upc=\(item.upc!)&isthumbnail=1"))
                }
        }
    }
}
