//
//  ViewCatalog.swift
//  Selection
//
//  Created by April on 3/14/16.
//  Copyright © 2016 BuildersAccess. All rights reserved.
//

import UIKit

class ViewCatalog: BaseViewController, UICollectionViewDataSource, UICollectionViewDelegate, UIPrintInteractionControllerDelegate {

    @IBAction func DoPrint(sender: AnyObject) {
//        UIView* testView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 1024.0f, 768.0f)];
//        NSMutableData* pdfData = [NSMutableData data];
//        UIGraphicsBeginPDFContextToData(pdfData, CGRectMake(0.0f, 0.0f, 792.0f, 612.0f), nil);
//        UIGraphicsBeginPDFPage();
//        CGContextRef pdfContext = UIGraphicsGetCurrentContext();
//        CGContextScaleCTM(pdfContext, 0.773f, 0.773f);
//        [testView.layer renderInContext:pdfContext];
//        UIGraphicsEndPDFContext();
        
        let pdfData = NSMutableData()
        UIGraphicsBeginPDFContextToData(pdfData, CGRectMake(0.0, 0.0, 612.0, 792.0), nil)
        UIGraphicsBeginPDFPage()
        let pdfContext = UIGraphicsGetCurrentContext()
        CGContextScaleCTM(pdfContext, 0.773, 0.773)
        
        
        let printView = UIView(frame: CGRect(x: 0, y: 0, width: 768.0, height: 1024.0))
        
        var upc = UILabel(frame: CGRect(x: 8, y: 10, width: 740, height: 21))
        
        let userInfo = NSUserDefaults.standardUserDefaults()
        if let cianame = userInfo.valueForKey(CConstants.UserInfoCiaName) as? String  {
                upc.text = cianame
        }
        printView.addSubview(upc)
        upc = UILabel(frame: CGRect(x: 8, y: 32, width: 740, height: 21))
        upc.text = "Part Picture List"
        printView.addSubview(upc)
        for i in 0...self.selectionList!.count-1 {
            let item = self.selectionList![i]
            let view = UIView(frame: CGRectMake(CGFloat((i%3)*255)+4, CGFloat((i/3)*250) + 60, CGFloat(254), CGFloat(240)))
            view.layer.borderColor = CConstants.BorderColor.CGColor
            view.layer.borderWidth = 1.0
            let upc = UILabel(frame: CGRect(x: 8, y: 0, width: 246, height: 21))
            let name = UILabel(frame: CGRect(x: 8, y: 21, width: 246, height: 21))
            let image = UIImageView(frame: CGRect(x: 8, y: 42, width: 238, height: 196))
            upc.text = item.upc!
            name.text = item.selectionarea
            let indexpath = NSIndexPath(forItem: i, inSection: 0)
            if let cell = self.collectionListView.cellForItemAtIndexPath(indexpath) as? selectionImageCell {
            image.image = cell.pic.image
            }
            
            view.addSubview(upc)
            view.addSubview(name)
            view.addSubview(image)
            printView.addSubview(view)
//
            
        }
        printView.layer.renderInContext(pdfContext!)
        UIGraphicsEndPDFContext()
        
        if UIPrintInteractionController.canPrintData(pdfData) {
            
            let printInfo = UIPrintInfo(dictionary: nil)
            printInfo.jobName = "Part Picture List"
            printInfo.outputType = .Photo
            
            let printController = UIPrintInteractionController.sharedPrintController()
            printController.printInfo = printInfo
            printController.showsNumberOfCopies = false
            
            printController.printingItem = pdfData
            
            printController.presentAnimated(true, completionHandler: nil)
            printController.delegate = self
        }
    }
    func printInteractionControllerParentViewController(printInteractionController: UIPrintInteractionController) -> UIViewController {
        return self.navigationController!
    }
    func printInteractionControllerWillPresentPrinterOptions(printInteractionController: UIPrintInteractionController) {
        self.navigationController?.navigationBar.tintColor = UIColor(red: 0, green: 164/255.0, blue: 236/255.0, alpha: 1)
        self.navigationController?.topViewController?.navigationController?.navigationBar.tintColor = UIColor(red: 0, green: 164/255.0, blue: 236/255.0, alpha: 1)
    }
    @IBOutlet var collectionListView: UICollectionView!{
        didSet{
            if let _ = selectionList {
                collectionListView.reloadData()
            }
        }
    }
    
    var selectionList: [AssemblySelectionAreaObj]?{
        didSet{
            if collectionListView != nil {
                collectionListView.reloadData()
            }
        }
    }
    
    private struct constants{
    static let cellIdentifier = "selectionImageCell"
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(constants.cellIdentifier, forIndexPath: indexPath)
        if let cell1 = cell as? selectionImageCell {
            let item = selectionList![indexPath.row]
            cell1.upc.text = item.upc!
            cell1.name.text = item.selectionarea!
//            cell1.pic.sd_setImageWithURL(NSURL(string: "https://contractssl.buildersaccess.com/baselection_image?idcia=\(item.idcia!)&idassembly1=\(item.idassembly1!)&upc=\(item.upc!)&isthumbnail=0"))
           cell1.spinner.startAnimating()
            cell1.pic.sd_setImageWithURL(NSURL(string: "https://contractssl.buildersaccess.com/baselection_image?idcia=\(item.idcia!)&idassembly1=\(item.idassembly1!)&upc=\(item.upc!)&isthumbnail=0"), completed: { (_, _, _, _) -> Void in
                cell1.spinner.stopAnimating()
            })
        }
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return selectionList?.count ?? 0
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let userInfo = NSUserDefaults.standardUserDefaults()
        if let idcia = userInfo.valueForKey(CConstants.UserInfoCiaId),
            let cianame = userInfo.valueForKey(CConstants.UserInfoCiaName)  {
//        self.title = "\(idcia ) ~ \(cianame )"
                self.title = "\(cianame )"
        }
        
    }
    
}
