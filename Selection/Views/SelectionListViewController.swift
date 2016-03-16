//
//  SelectionListViewController.swift
//  Selection
//
//  Created by April on 3/13/16.
//  Copyright © 2016 BuildersAccess. All rights reserved.
//

import UIKit
import Alamofire
import MBProgressHUD

class SelectionListViewController: BaseViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {
    
//    @IBOutlet var seperatorHeight: NSLayoutConstraint!{
//        didSet{
//            seperatorHeight.constant = 1.0 / UIScreen.mainScreen().scale
//        }
//    }
    @IBOutlet var viewHeight: NSLayoutConstraint!{
        didSet{
        viewHeight.constant = 1.0 / UIScreen.mainScreen().scale
            view.updateConstraintsIfNeeded()
        }
    }
    @IBOutlet var txtField: UITextField!{
        didSet{
            txtField.text = ""
            txtField.placeholder = "Search"
            txtField.clearButtonMode = .WhileEditing
            txtField.layer.cornerRadius = 5.0
            txtField.leftViewMode = .Always
            txtField.leftView = UIImageView(image: UIImage(named: "search"))
            NSNotificationCenter.defaultCenter().addObserver(self, selector: "textFieldDidChange:", name: UITextFieldTextDidChangeNotification, object: txtField)
        }
        
    }
    
    func textFieldDidChange(notifications : NSNotification?){
        if let txt = txtField.text?.lowercaseString{
            if txt.isEmpty{
                selectionList = selectionListOrigin
            }else{
                selectionList = selectionListOrigin?.filter(){
                    //                    print($0)
                    return $0.idselection!.lowercaseString.containsString(txt)
                        || $0.selectionname!.lowercaseString.containsString(txt)
                        || $0.type!.lowercaseString.containsString(txt)
                        || $0.pricebook!.lowercaseString.containsString(txt)
                        || $0.pricelevel!.lowercaseString.containsString(txt)
                    
                    
                }
            }
        }else{
            selectionList = selectionListOrigin
        }
    }
    var refreshControl: UIRefreshControl?
    
    @IBOutlet var tableview: UITableView!{
        didSet{
            refreshControl = UIRefreshControl()
            refreshControl!.addTarget(self, action: "refresh:", forControlEvents: UIControlEvents.ValueChanged)
            tableview.addSubview(refreshControl!)
        }
    }
    func refresh(refreshControl: UIRefreshControl) {
        // Do your job, when done:
        self.getAssembliesFromServer()
    }
    
    var selectionListOrigin: [AssemblySelectionObj]? {
        didSet{
            if txtField.text == "" {
                selectionList = selectionListOrigin
            }else{
                self.textFieldDidChange(nil)
            }
        }
    }
    var selectionList: [AssemblySelectionObj]?{
        didSet{
            self.tableview.reloadData()
        }
    }
    var ciaid: String?
    var idassembly: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getAssembliesFromServer()
    }
    private struct constants{
        static let cellIdentifier = "selection cell"
        static let headcellIdentifier = "head cell"
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let cell = tableView.dequeueReusableCellWithIdentifier(constants.headcellIdentifier)
        cell?.backgroundColor = CConstants.BackColor
        return cell
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return selectionList?.count ?? 0
    }
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 44
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(constants.cellIdentifier, forIndexPath: indexPath)
        if let cell1 = cell as? SeletionCell{
            let item = selectionList![indexPath.row]
            cell1.setContentDetail(item)
        }
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.performSegueWithIdentifier(CConstants.SegueToSelectionAreaList, sender: selectionList![indexPath.row])
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let identifier = segue.identifier {
            switch identifier {
            case CConstants.SegueToSelectionAreaList:
                if let item = sender as? AssemblySelectionObj {
                    if let v = segue.destinationViewController as? SelectionAreaListViewController {
                        v.title = item.selectionname
                        v.ciaid = self.ciaid
                        v.idassembly = item.idassembly
                    }
                }
                
            default:
                break
            }
        }
    }
    
    private func getAssembliesFromServer(){
        let userInfo = NSUserDefaults.standardUserDefaults()
        if let email = userInfo.objectForKey(CConstants.UserInfoEmail) as? String,
            let pwd = userInfo.objectForKey(CConstants.UserInfoPwd) as? String,
            let ciaidValue = ciaid, idassemblyValue = idassembly{
                let assemblyRequired = AssemblySelectionRequired(email: email, password: pwd, ciaid: ciaidValue, idassembly: idassemblyValue)
                
                let a = assemblyRequired.toDictionary()
                
                var hud : MBProgressHUD?
                if !(self.refreshControl!.refreshing){
                    hud = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
                    hud?.labelText = CConstants.RequestMsg
                }
                
                
                Alamofire.request(.POST, CConstants.ServerURL + CConstants.AssemblySelectionListServiceURL, parameters: a).responseJSON{ (response) -> Void in
                    //                    self.clearNotice()
                    hud?.hide(true)
                    self.refreshControl?.endRefreshing()
                    //                    self.progressBar?.dismissViewControllerAnimated(true){ () -> Void in
                    //                        self.spinner?.stopAnimating()
                    if response.result.isSuccess {
//                        print(response.result.value)
                        if let rtnValue = response.result.value as? [[String: String]]{
                            var tmp = [AssemblySelectionObj]()
                            for o in rtnValue {
                                tmp.append(AssemblySelectionObj(dicInfo: o))
                            }
                            self.selectionListOrigin = tmp
                            self.tableview.reloadData()
                        }else{
                            
                            self.PopServerError()
                        }
                    }else{
                        
                        self.PopNetworkError()
                    }
                }
        }
        
        
        
    }
    
    // MARK: - Search Bar Deleagte
    
    
}
