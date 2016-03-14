//
//  SelectionAreaListViewController.swift
//  Selection
//
//  Created by April on 3/13/16.
//  Copyright © 2016 BuildersAccess. All rights reserved.
//

import UIKit
import Alamofire
import MBProgressHUD


class SelectionAreaListViewController: BaseViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate, UIGestureRecognizerDelegate, UIPopoverPresentationControllerDelegate {
    
    @IBOutlet var searchBar: UISearchBar!{
        didSet{
            searchBar.text = ""
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
    
    var selectionListOrigin: [AssemblySelectionAreaObj]? {
        didSet{
            if searchBar.text == "" {
                selectionList = selectionListOrigin
            }else{
                self.searchBar(searchBar, textDidChange: searchBar.text!)
            }
        }
    }
    var selectionList: [AssemblySelectionAreaObj]?{
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
        static let cellIdentifier = "selection area cell"
        static let headcellIdentifier = "head cell"
        static let segueToBigPicture = "show big picture"
        static let segueToViewCatalog = "show view catalog"
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
        if let cell1 = cell as? SelectionAreaCell{
            let item = selectionList![indexPath.row]
            item.idcia = self.ciaid
            cell1.thumbnail.tag = indexPath.row
            cell1.superActionView = self
            cell1.setContentDetail(item)
        }
        return cell
    }
    
    private func getAssembliesFromServer(){
        let userInfo = NSUserDefaults.standardUserDefaults()
        if let email = userInfo.objectForKey(CConstants.UserInfoEmail) as? String,
            let pwd = userInfo.objectForKey(CConstants.UserInfoPwd) as? String,
            let ciaidValue = ciaid, idassemblyValue = idassembly{
                let assemblyRequired = AssemblySelectionAreaRequired(email: email, password: pwd, ciaid: ciaidValue, idassembly: idassemblyValue)
                
                let a = assemblyRequired.toDictionary()
                
                var hud : MBProgressHUD?
                if !(self.refreshControl!.refreshing){
                    hud = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
                    hud?.labelText = CConstants.RequestMsg
                }
                
                
                Alamofire.request(.POST, CConstants.ServerURL + CConstants.AssemblySelectionAreaListServiceURL, parameters: a).responseJSON{ (response) -> Void in
                    //                    self.clearNotice()
                    hud?.hide(true)
                    self.refreshControl?.endRefreshing()
                    //                    self.progressBar?.dismissViewControllerAnimated(true){ () -> Void in
                    //                        self.spinner?.stopAnimating()
                    if response.result.isSuccess {
//                        print(response.result.value)
                        if let rtnValue = response.result.value as? [[String: String]]{
                            var tmp = [AssemblySelectionAreaObj]()
                            for o in rtnValue {
                                tmp.append(AssemblySelectionAreaObj(dicInfo: o))
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
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        if let txt = searchBar.text?.lowercaseString{
            if txt.isEmpty{
                selectionList = selectionListOrigin
            }else{
                selectionList = selectionListOrigin?.filter(){
                    //                    print($0)
                    return $0.selectionarea!.lowercaseString.containsString(txt)
                        || $0.des!.lowercaseString.containsString(txt)
                    
                    
                }
            }
        }else{
            selectionList = selectionListOrigin
        }
        
    }
    
    @IBAction func imageTapped(sender: UITapGestureRecognizer) {
        
        let tag = sender.view?.tag ?? 0
        let item = selectionList![tag]
        self.performSegueWithIdentifier(constants.segueToBigPicture, sender: item)
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let identifier = segue.identifier {
            switch identifier {
            case constants.segueToViewCatalog:
                if let vc = segue.destinationViewController as? ViewCatalog {
                    vc.selectionList = self.selectionListOrigin?.filter(){
                        return $0.fs == "True"
                    }
                }
            case constants.segueToBigPicture:
//                if let ppc = tvc.popoverPresentationController {
//                    ppc.delegate = self
//                    tvc.AddressListOrigin = self.AddressList
//                    tvc.delegate = self
//                }
                
                if let item = sender as? AssemblySelectionAreaObj,
                let vc = segue.destinationViewController as? BigPictureViewController{
                    
                   
                    
                    let url = NSURL(string: "https://contractssl.buildersaccess.com/baselection_image?idcia=\(item.idcia!)&idassembly1=\(item.idassembly1!)&upc=\(item.upc!)&isthumbnail=0")
                    vc.imageUrl = url
                        
                        
                        
                        
                }
            default:
                break
            }
        }
    }
    
}