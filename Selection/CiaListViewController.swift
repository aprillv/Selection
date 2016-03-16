//
//  AdressListViewController.swift
//  Contract
//
//  Created by April on 11/19/15.
//  Copyright © 2015 HapApp. All rights reserved.
//

import UIKit
import Alamofire
import MBProgressHUD

class CiaListViewController: UITableViewController, UISearchBarDelegate {
    
//    var lastSelectedIndexPath : NSIndexPath?
   
    @IBOutlet var backItem: UIBarButtonItem!
//    @IBOutlet var switchItem: UIBarButtonItem!
    @IBOutlet var searchBar: UISearchBar!{
        didSet{
            
            
//            for iv in searchBar.subviews {
//                for iv1 in iv.subviews {
//                    if !iv1.isKindOfClass(UITextField){
//                        iv1.removeFromSuperview()
//                    }
////                    for iv2 in iv1.subviews {
////                        print(iv2)
//////                        iv2.removeFromSuperview()
////                    }
//                }
//            }
            
//            let txt = searchBar.valueForKey("_searchGround")
//            print(txt)
            
//            searchBar.placeholder = "Search"
////            searchBar.userInteractionEnabled = false
//            let txt1 = UITextField(frame: CGRect(x: 50, y: 12, width: searchBar.frame.width - 60, height: 22))
//            txt1.backgroundColor = UIColor.whiteColor()
//            searchBar.addSubview(txt1)
            
//            searchBar.placeholder = "     "
//            
//            if let txt = searchBar.valueForKey("_searchField") as? UITextField {
////                txt.backgroundColor = UIColor.whiteColor()
////                txt.leftViewMode = .Never
//////                txt.leftView = UIImageView(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
////                txt.rightViewMode = .Never
////                
//////                txt.background =  UIImage(named: "search")
//////                txt.leftView = UIImageView(image: UIImage(named: "search"))
//////               txt.addSubview(UIImageView(image: UIImage(named: "search")))
//////                txt.edd
////                txt.borderStyle = .None
////                txt.layer.borderColor = UIColor.clearColor().CGColor
////                
//                txt.textAlignment = .Left
////                txt.clearButtonMode = .Never
//            }
        }
    }
    @IBAction func doLogout(sender: AnyObject) {
        self.navigationController?.popViewControllerAnimated(true)
    }
//    var head : CiaListViewHeadView?
    var CiaListOrigin : [CialistItemObj]?{
        didSet{
            CiaList = CiaListOrigin
        }
    }
    
    var CiaList : [CialistItemObj]?{
        didSet{
            self.tableView.reloadData()
        }
    }
    
   
    
    
    @IBOutlet weak var LoginUserName: UIBarButtonItem!{
        didSet{
            let userInfo = NSUserDefaults.standardUserDefaults()
            LoginUserName.title = userInfo.objectForKey(CConstants.LoggedUserNameKey) as? String
        }
    }
    // MARK: - Constanse
    private struct constants{
        static let Title : String = "Select A Company"
        static let CellIdentifier : String = "Cia Cell Identifier"
       
    }
    
    
    
    // MARK: - life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.tag = 2
        self.navigationItem.hidesBackButton = true
        self.title = constants.Title
        
        self.tableView.reloadData()
        self.tableView.separatorInset = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8)
    }
    
    

    
    // MARK: - Search Bar Deleagte
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        if let txt = searchBar.text?.lowercaseString{
            if txt.isEmpty{
                CiaList = CiaListOrigin
            }else{
                CiaList = CiaListOrigin?.filter(){
                    
                    return $0.ciaid!.lowercaseString.containsString(txt)
                        || $0.cianame!.lowercaseString.containsString(txt)
                    
                    
                }
            }
        }else{
             CiaList = CiaListOrigin
        }
        
    }

    // MARK: - Table view data source
//    override func tableView(tableView1: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        
//        if tableView.tag == 2 {
//            let  heada = AddressListViewHeadView(frame: CGRect(x: 0, y: 0, width: tableView1.frame.width, height: 44))
//            let ddd = CiaNmArray?[CiaNm?[section] ?? ""]
//            heada.CiaNmLbl.text = ddd?.first?.cianame ?? ""
//            return heada
//        }else{
//            return nil
//        }
//       
//    }
//    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        if tableView.tag == 1 {
//            let ddd = CiaNmArray?[CiaNm?[section] ?? ""]
//            return ddd?.first?.cianame ?? ""
//        }else{
//            return nil
//        }
//    }
//    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
//        return CiaNm?.count ?? 1
//    }
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return CiaList?.count ?? 0
    }
//
//    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        return tableView.tag == 2 ? 66 : 30
//    }
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell: UITableViewCell;
        cell = tableView.dequeueReusableCellWithIdentifier(constants.CellIdentifier, forIndexPath: indexPath)
//        cell.separatorInset = UIEdgeInsetsZero
//        cell.layoutMargins = UIEdgeInsetsZero
//        cell.preservesSuperviewLayoutMargins = false
        if let cell1 = cell as? CiaCell {
            let item  = CiaList![indexPath.row]
            cell1.lbl.text = "\(item.ciaid!) ~ \(item.cianame!)"
        }
        
        return cell
        
    }
    
    
    
    private func callService(printModelNms: [String]){
//        var serviceUrl: String?
//        var printModelNm : String
//        if printModelNms.count == 1 {
//            printModelNm = printModelNms[0]
//        }else{
//            printModelNm = CConstants.ActionTitleAddendumC
//        }
//        switch printModelNm{
//        case CConstants.ActionTitleAddendumC:
//            serviceUrl = CConstants.AddendumCServiceURL
//       
//        default:
//            serviceUrl = CConstants.AddendumAServiceURL
//        }
//        
//        
//        if let indexPath = tableView.indexPathForSelectedRow {
//            let ddd = self.CiaNmArray?[self.CiaNm?[indexPath.section] ?? ""]
//            let item: ContractsItem = ddd![indexPath.row]
//            
////            print(ContractRequestItem(contractInfo: item).DictionaryFromObject())
//            let hud = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
//            //                hud.mode = .AnnularDeterminate
//            hud.labelText = CConstants.RequestMsg
//            Alamofire.request(.POST,
//                CConstants.ServerURL + serviceUrl!,
//                parameters: ContractRequestItem(contractInfo: item).DictionaryFromObject()).responseJSON{ (response) -> Void in
//                    hud.hide(true)
//                        if response.result.isSuccess {
//                            
//                            if let rtnValue = response.result.value as? [String: AnyObject]{
//                                if let msg = rtnValue["message"] as? String{
//                                    if msg.isEmpty{
//                                        switch printModelNm {
//                                        case CConstants.ActionTitleAddendumC:
////                                            if printModelNms.count == 1 {
////                                                let rtn = ContractAddendumC(dicInfo: rtnValue)
////                                                self.performSegueWithIdentifier(CConstants.SegueToAddendumC, sender: rtn)
////                                            }else{
//                                                let rtn = ContractAddendumC(dicInfo: rtnValue)
//                                                self.performSegueWithIdentifier(CConstants.SegueToPrintPdf, sender: rtn)
////                                            }
//                                        default:
//                                            self.tableView.deselectRowAtIndexPath(indexPath, animated: true)
//                                        }
//                                        
//                                        
//                                    }else{
//                                        self.tableView.deselectRowAtIndexPath(indexPath, animated: true)
//                                        self.PopMsgWithJustOK(msg: msg)
//                                    }
//                                }else{
//                                    self.tableView.deselectRowAtIndexPath(indexPath, animated: true)
//                                    self.PopMsgWithJustOK(msg: CConstants.MsgServerError)
//                                }
//                            }else{
//                                self.tableView.deselectRowAtIndexPath(indexPath, animated: true)
//                                self.PopMsgWithJustOK(msg: CConstants.MsgServerError)
//                            }
//                        }else{
//                            self.tableView.deselectRowAtIndexPath(indexPath, animated: true)
////                            self.spinner?.stopAnimating()
//                            self.PopMsgWithJustOK(msg: CConstants.MsgNetworkError)
//                        }
//                    }
//            
//            
//        }
    }
    
    
   
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {

       self.searchBar.resignFirstResponder()
        
        
        self.performSegueWithIdentifier(CConstants.SegueToAssemblies, sender: self.CiaList![indexPath.row])
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let identifier = segue.identifier {
            switch identifier {
            case CConstants.SegueToAssemblies:
                if let a = segue.destinationViewController as? AssembliesViewController {
                    if let item = sender as? CialistItemObj {
                        a.ciaid = item.ciaid
                        a.title = item.cianame!
                        
                        let userInfo = NSUserDefaults.standardUserDefaults()
                        userInfo.setValue(item.ciaid!, forKey: CConstants.UserInfoCiaId)
                        userInfo.setValue(item.cianame!, forKey: CConstants.UserInfoCiaName)
                    }
                }
            default:
                break;
            }
        }
    }
    
//    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
//        if let identifier = segue.identifier {
//            switch identifier {
//            case CConstants.SegueToPrintModel:
//                
//                if let controller = segue.destinationViewController as? PrintModelTableViewController {
//                   controller.delegate = self
//                }
//                break
//           
//            case CConstants.SegueToPrintPdf:
//                if let controller = segue.destinationViewController as? PDFPrintViewController {
//                    if let indexPath = tableView.indexPathForSelectedRow {
//                        let ddd = self.CiaNmArray?[self.CiaNm?[indexPath.section] ?? ""]
//                        let item: ContractsItem = ddd![indexPath.row]
//                        
//                        if let info = sender as? ContractAddendumC {
//                            controller.pdfInfo0 = info
//                            controller.addendumCpdfInfo = info
//                            controller.AddressList = self.AddressListOrigin
//                            controller.filesArray = self.filesNms!
//                            controller.contractInfo = item
//                            var itemList = [[String]]()
//                            var i = 0
//                            if let list = info.itemlist {
//                                for items in list {
//                                    
//                                    var itemList1 = [String]()
//                                    let textView = UITextView(frame: CGRect(x: 0, y: 0, width: 657.941, height: 13.2353))
//                                    textView.scrollEnabled = false
//                                    textView.font = UIFont(name: "Verdana", size: 11.0)
//                                    textView.text = items.xdescription!
//                                    textView.sizeToFit()
//                                    textView.layoutManager.enumerateLineFragmentsForGlyphRange(NSMakeRange(0, items.xdescription!.characters.count), usingBlock: { (rect, usedRect, textContainer, glyphRange, _) -> Void in
//                                        if  let a : NSString = items.xdescription! as NSString {
//                                            
//                                            i++
//                                            itemList1.append(a.substringWithRange(glyphRange))
//                                        }
//                                    })
//                                    //                            itemList1.append("april test")
//                                    itemList.append(itemList1)
//                                }
//                            }
//                            controller.addendumCpdfInfo!.itemlistStr = itemList
//                            
//                            //                        let pass = i > 19 ? CConstants.PdfFileNameAddendumC2 : CConstants.PdfFileNameAddendumC
//                            
//                            controller.page2 = i > 19
//                            //                        controller.initWithResource(pass)
//                            
//                        }else{
//                            
//                            
//                            let info = ContractPDFBaseModel(dicInfo: nil)
//                            info.code = item.code
//                            info.idcia = item.idcia
//                            info.idproject = item.idproject
//                            info.idnumber = item.idnumber
//                            info.idcity = item.idcity
//                            info.nproject = item.nproject
//                            controller.contractInfo = item
//                            controller.pdfInfo0 = info
//                            controller.AddressList = self.AddressListOrigin
//                            controller.filesArray = self.filesNms
//                            controller.page2 = false
//                        }
//                        self.tableView.deselectRowAtIndexPath(indexPath, animated: true)
//                    }
//                    
//                }
//            
//            default:
//                break;
//            }
//        }
//    }

    @IBAction func refreshCiaList(sender: UIRefreshControl) {
        
        self.getCiaListFromServer(sender)
    }
    
    private func getCiaListFromServer(sender: UIRefreshControl?){
        let userInfo = NSUserDefaults.standardUserDefaults()
        let email = userInfo.valueForKey(CConstants.UserInfoEmail) as? String
        let password = userInfo.valueForKey(CConstants.UserInfoPwd) as? String
        
        
        let loginUserInfo = LoginUserRequired(email: email!, password: password!)
        
        let a = loginUserInfo.toDictionary()
        var hud : MBProgressHUD?
        if sender == nil {
            hud = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
            hud?.labelText = CConstants.RequestMsg
        }
       
        Alamofire.request(.POST, CConstants.ServerURL + CConstants.LoginServiceURL, parameters: a).responseJSON{ (response) -> Void in
            if response.result.isSuccess {
                if let rtnValue = response.result.value as? [String: AnyObject]{
                    let rtn = LoginedUserObj(dicInfo: rtnValue)
                    
                    if rtn.found == "1"{
                       self.CiaListOrigin = rtn.cialist
                    }
                }
            }
            hud?.hide(true)
            sender?.endRefreshing()
                   }
        
    }
    
    private func PopMsgWithJustOK(msg msg1: String){
        
        let alert: UIAlertController = UIAlertController(title: CConstants.MsgTitle, message: msg1, preferredStyle: .Alert)
        
        //Create and add the OK action
        let oKAction: UIAlertAction = UIAlertAction(title: CConstants.MsgOKTitle, style: .Cancel) { Void in
            
        }
        alert.addAction(oKAction)
        
        
        //Present the AlertController
        self.presentViewController(alert, animated: true, completion: nil)
        
        
    }
    
    override func scrollViewWillBeginDragging(scrollView: UIScrollView) {
        self.searchBar.resignFirstResponder()
    }
  
    
   
    
    
}
