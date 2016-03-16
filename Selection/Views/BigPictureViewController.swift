//
//  BigPictureViewController.swift
//  Selection
//
//  Created by April on 3/14/16.
//  Copyright © 2016 BuildersAccess. All rights reserved.
//

import UIKit
import SDWebImage
import MBProgressHUD

class BigPictureViewController: UIViewController {

    var imageUrl: NSURL? {
        didSet{
            self.loadImage()
        }
    }
    @IBOutlet var image: UIImageView!{
        didSet{
            self.loadImage()
        }
    }
    @IBOutlet var spinner: UIActivityIndicatorView!
    
    private func loadImage(){
        if let url = imageUrl {
            if image != nil {
//                print(url)
                let hud = MBProgressHUD.showHUDAddedTo(image, animated: true)
                //                hud.mode = .AnnularDeterminate
                hud.labelText = "Loading Picutre"
                hud.show(true)
                image.sd_setImageWithURL(url, completed: { (_, _, _, _) -> Void in
                    hud.hide(true)
                })
//                image.sd_setImageWithURL(url)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
//        self.title = "Print"
        view.superview?.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.2)
        //        view.superview?.bounds = CGRect(x: 0, y: 0, width: tableview.frame.width, height: 44 * CGFloat(5))
    }
    
    override var preferredContentSize: CGSize {
        
        get {
            
            return CGSize(width: 800, height: 700)
        }
        set { super.preferredContentSize = newValue }
    }
    
    private func setCornerRadius(btn : UIButton) {
        btn.layer.cornerRadius = 5.0
    }
    @IBOutlet var closeBtn: UIButton!{
        didSet{
            setCornerRadius(closeBtn)
        }
    }
    
    @IBOutlet var saveBtn: UIButton!{
        didSet{
            setCornerRadius(saveBtn)
        }
    }
    @IBAction func doSave(sender: UIButton) {
        if let img = image.image {
            UIImageWriteToSavedPhotosAlbum(img, self, "image:didFinishSavingWithError:contextInfo:", nil);
        }
    }
    
    func image(image: UIImage, didFinishSavingWithError error: NSError?, contextInfo:UnsafePointer<Void>) {
        if error == nil {
            
            
            var hud : MBProgressHUD?
            hud = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
            hud?.mode = .CustomView
            let image = UIImage(named: CConstants.SuccessImageNm)
            hud?.customView = UIImageView(image: image)
            hud?.labelText = CConstants.SavedSuccessMsg
            hud?.show(true)
            
            hud?.hide(true, afterDelay: 0.5)
            
        } else {
            var hud : MBProgressHUD?
            hud = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
            hud?.mode = .CustomView
            let image = UIImage(named: CConstants.FailImageNm)
            hud?.customView = UIImageView(image: image)
            hud?.labelText = CConstants.SavedFailMsg
            hud?.show(true)
            
            hud?.hide(true, afterDelay: 0.5)
        }
    }
    
    
    func afterSave(sender : AnyObject) {
//        print(sender)
    }
    @IBAction func doClose(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
}
