//
//  AssembliesViewController.swift
//  Selection
//
//  Created by April on 3/12/16.
//  Copyright © 2016 BuildersAccess. All rights reserved.
//

import UIKit
import Alamofire
import MBProgressHUD

class AssembliesViewController: BaseViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {

//    @IBOutlet var seperatorHeight: NSLayoutConstraint!{
//        didSet{
//            seperatorHeight.constant = 1.0 / UIScreen.mainScreen().scale
//        }
//    }
    
    @IBOutlet var viewheight: NSLayoutConstraint!{
        didSet{
            viewheight.constant = 1.0 / UIScreen.mainScreen().scale
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
    // MARK: - textField Did Change
    func textFieldDidChange(notifications : NSNotification?){
        if let txt = txtField.text?.lowercaseString{
            if txt.isEmpty{
                assemblyList = assemblyListOrigin
            }else{
                assemblyList = assemblyListOrigin?.filter(){
                    //                    print($0)
                    return $0.idnumber!.lowercaseString.containsString(txt)
                        || $0.idcostcode!.lowercaseString.containsString(txt)
                        || $0.name!.lowercaseString.containsString(txt)
                        || $0.categorygroup!.lowercaseString.containsString(txt)
                    
                    
                }
            }
        }else{
            assemblyList = assemblyListOrigin
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
    
    var assemblyListOrigin: [AssemblyItem]? {
        didSet{
            if txtField.text == "" {
                assemblyList = assemblyListOrigin
            }else{
                self.textFieldDidChange(nil)
            }
        }
    }
    var assemblyList: [AssemblyItem]?{
        didSet{
           self.tableview.reloadData()
        }
    }
    var ciaid: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getAssembliesFromServer()
    }
    private struct constants{
        static let cellIdentifier = "assembly cell"
        static let headcellIdentifier = "head cell"
    }
   
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let cell = tableView.dequeueReusableCellWithIdentifier(constants.headcellIdentifier)
        cell?.backgroundColor = CConstants.BackColor
        return cell
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return assemblyList?.count ?? 0
    }
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 44
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(constants.cellIdentifier, forIndexPath: indexPath)
        if let cell1 = cell as? AssemblyCell{
        let item = assemblyList![indexPath.row]
            cell1.setContentDetail(item)
        }
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.performSegueWithIdentifier(CConstants.SegueToSelectionList, sender: self.assemblyList![indexPath.row])
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let identifier = segue.identifier {
            switch identifier{
            case CConstants.SegueToSelectionList:
                if let item = sender as? AssemblyItem{
                    if let v = segue.destinationViewController as? SelectionListViewController {
//                        v.title = "\(item.idnumber!) ~ \(item.name!)"
                        v.title = "\(item.name!)"
                        v.ciaid = self.ciaid
                        v.idassembly = item.idnumber
                    }
                }
            default:
                break;
            }
        }
    }
    
    private func getAssembliesFromServer(){
        let userInfo = NSUserDefaults.standardUserDefaults()
        if let email = userInfo.objectForKey(CConstants.UserInfoEmail) as? String,
            let pwd = userInfo.objectForKey(CConstants.UserInfoPwd) as? String,
            let ciaidValue = ciaid{
                let assemblyRequired = AssemblyRequired(email: email, password: pwd, ciaid: ciaidValue)
                
                let a = assemblyRequired.toDictionary()
                
                var hud : MBProgressHUD?
                if !(self.refreshControl!.refreshing){
                    hud = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
                    hud?.labelText = CConstants.RequestMsg
                }
                
                
                Alamofire.request(.POST, CConstants.ServerURL + CConstants.AssemblyListServiceURL, parameters: a).responseJSON{ (response) -> Void in
                    //                    self.clearNotice()
                    hud?.hide(true)
                    self.refreshControl?.endRefreshing()
                    //                    self.progressBar?.dismissViewControllerAnimated(true){ () -> Void in
                    //                        self.spinner?.stopAnimating()
                    if response.result.isSuccess {
//                        print(response.result.value)
                        if let rtnValue = response.result.value as? [[String: String]]{
                            var tmp = [AssemblyItem]()
                            for o in rtnValue {
                                tmp.append(AssemblyItem(dicInfo: o))
                            }
                            self.assemblyListOrigin = tmp
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
    
    
}
