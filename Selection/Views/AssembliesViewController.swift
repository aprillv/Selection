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

    @IBOutlet var searchBar: UISearchBar!
    @IBOutlet var tableview: UITableView!
    
    var assemblyList: [AssemblyItem]?
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
    
    private func getAssembliesFromServer(){
        let userInfo = NSUserDefaults.standardUserDefaults()
        if let email = userInfo.objectForKey(CConstants.UserInfoEmail) as? String,
            let pwd = userInfo.objectForKey(CConstants.UserInfoPwd) as? String,
            let ciaidValue = ciaid{
                let assemblyRequired = AssemblyRequired(email: email, password: pwd, ciaid: ciaidValue)
                
                let a = assemblyRequired.toDictionary()
                let hud = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
                //                hud.mode = .AnnularDeterminate
                hud.labelText = CConstants.RequestMsg
                
                Alamofire.request(.POST, CConstants.ServerURL + CConstants.AssemblyListServiceURL, parameters: a).responseJSON{ (response) -> Void in
                    //                    self.clearNotice()
                    hud.hide(true)
                    //                    self.progressBar?.dismissViewControllerAnimated(true){ () -> Void in
                    //                        self.spinner?.stopAnimating()
                    if response.result.isSuccess {
                        print(response.result.value)
                        if let rtnValue = response.result.value as? [[String: String]]{
                            self.assemblyList = [AssemblyItem]()
                            for o in rtnValue {
                                self.assemblyList?.append(AssemblyItem(dicInfo: o))
                            }
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
