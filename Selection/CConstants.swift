//
//  File.swift
//  Contract
//
//  Created by April on 11/23/15.
//  Copyright © 2015 HapApp. All rights reserved.
//

import UIKit

struct CConstants{
   
    
    static let BorderColor : UIColor = UIColor(red: 204/255.0, green: 204/255.0, blue: 204/255.0, alpha: 1)
    static let BackColor : UIColor = UIColor(red: 246/255.0, green: 246/255.0, blue: 246/255.0, alpha: 1)
    
    static let MsgTitle : String = "BA Selection"
    static let MsgOKTitle : String = "OK"
    static let MsgValidationTitle : String = "Validation Failed"
    static let MsgServerError : String = "Server Error, please try again later"
    static let MsgNetworkError : String = "Network Error, please check your network"
    
    static let UserInfoRememberMe :  String = "Login Remember Me"
    static let UserInfoEmail :  String = "Login Email"
    static let UserInfoPwd :  String = "Login Password"
    static let UserInfoPrintModel : String = "last print files"
    
    static let LoginingMsg = "   Logining...   "
    static let RequestMsg = "Requesting from server"
    static let SavedMsg = "Saving to the BA Server"
    static let SavedSuccessMsg = "Saved successfully."
    static let SavedFailMsg = "Saved fail."
    static let SendEmailSuccessfullMsg = "Sent email successfully."
    static let PrintSuccessfullMsg = "Print successfully."
    
    static let CheckedImgNm = "checked"
    static let CheckImgNm = "check"
    static let SuccessImageNm = "checkmark"
    static let FailImageNm = "fail"
    
    static let SegueToCiaList :  String = "CiaList"
    static let SegueToAssemblies : String = "show Assemblies"
//    static let SegueToSignaturePdf : String = "pdfSignature"
//    static let SegueToThridPartyFinacingAddendumPdf : String = "pdfThridPartyFinacingAddendum"
//    static let SegueToClosingMemo : String = "closingmemo"
//    static let SegueToDesignCenter : String = "designcenter"
//    static let SegueToAddendumA : String = "addenduma"
//    static let SegueToAddendumC : String = "addendumc"
//    
//    static let SegueToInformationAboutBrokerageServices : String = "InformationAboutBrokerageServices"
//    static let SegueToExhibitA : String = "exhibita"
//    static let SegueToExhibitB : String = "exhibitb"
//    static let SegueToExhibitC : String = "exhibitc"
    static let SegueToSelectionList : String = "show selection list"
    static let SegueToSelectionAreaList : String = "show selection area list"
    static let SegueToAddressModelPopover : String = "Address switch"
    static let SegueToOperationsPopover : String = "Show Operations"
    
    
    static let LoggedUserNameKey : String = "LoggedUserNameInDefaults"
    static let UserInfoCiaId : String = "CiaId"
    static let UserInfoCiaName : String = "CiaName"
    static let InstallAppLink : String = "itms-services://?action=download-manifest&url=https://www.buildersaccess.com/iphone/contract.plist"
    static let ServerURL : String = "https://contractssl.buildersaccess.com/"
    //validate login and get address list
    static let LoginServiceURL: String = "baslection_login.json"
    //check app version
    static let CheckUpdateServiceURL: String = "bacontract_version.json"
    //get assembly list
    static let AssemblyListServiceURL = "baslection_assemblylist.json"
    //get assembly selection list
    static let AssemblySelectionListServiceURL = "baslection_assembly.json"
    //get assembly selection area list
    static let AssemblySelectionAreaListServiceURL = "baslection_assemblyselection.json"
    // get Third Party Financing Addendum
//    static let ThirdPartyFinancingAddendumServiceURL = "bacontract_thirdPartyFinancingAddendum.json"
    //upload pdf
    static let ContractUploadPdfURL = "bacontract_upload.json"
   
    
    static let PdfFileNameContract = "BaseContract"
    static let PdfFileNameThirdPartyFinancingAddendum = "Third_Party_Financing_Addendum_TREC"
    static let PdfFileNameClosingMemo = "ClosingMemo"
    static let PdfFileNameDesignCenter = "DesignCenter"
    static let PdfFileNameEXHIBIT_A = "EXHIBIT_A"
    static let PdfFileNameEXHIBIT_B = "EXHIBIT_B"
    static let PdfFileNameEXHIBIT_C = "EXHIBIT_C_General"
    static let PdfFileNameINFORMATION_ABOUT_BROKERAGE_SERVICES = "INFORMATION_ABOUT_BROKERAGE_SERVICES"
    static let PdfFileNameAddendumA = "AddendumA"
    static let PdfFileNameAddendumC = "AddendumC"
    static let PdfFileNameAddendumC2 = "AddendumC2"
    
    static let PdfPageHeight : CGFloat = 976.688235
//    static let PdfPageMarginUserDefault = "pageHMargin"
    static let PdfFileNameContractPageCount = 9
    static let PdfFileNameThirdPartyFinancingAddendumPageCount = 2
    static let PdfFileNameClosingMemoPageCount = 1
    static let PdfFileNameDesignCenterPageCount = 1
    static let PdfFileNameEXHIBIT_APageCount = 1
    static let PdfFileNameEXHIBIT_BPageCount = 1
    static let PdfFileNameEXHIBIT_CPageCount = 3
    static let PdfFileNameINFORMATION_ABOUT_BROKERAGE_SERVICESPageCount = 2
    static let PdfFileNameAddendumAPageCount = 6
    static let PdfFileNameAddendumCPageCount = 1
    static let PdfFileNameAddendumC2PageCount = 2
    
    
    static let ControllerNameContract = "SignContractViewController"
    static let ControllerNameExhibitA = "ExhibitAViewController"
    static let ControllerNameExhibitB = "ExhibitBViewController"
    static let ControllerNameExhibitC = "ExhibitCGeneralViewController"
    static let ControllerNameAddendumA = "AddendumAViewController"
    static let ControllerNameAddendumC = "AddendumCViewController"
    static let ControllerNameClosingMemo = "ClosingMemoViewController"
    static let ControllerNameDesignCenter = "DesignCenterViewController"
    static let ControllerNameThirdPartyFinancingAddendum = "ThirdPartyFinacingAddendumViewController"
    static let ControllerNameINFORMATION_ABOUT_BROKERAGE_SERVICES = "InformationAboutBrokerageServicesViewController"
    static let ControllerNamePrint = "PDFPrintViewController"
    
    
    static let StoryboardName = "Main"
    
    static let ActionTitleAddendumC : String = "Addendum C"
    static let ActionTitleAddendumA : String = "Addendum A"
    static let ActionTitleClosingMemo : String = "Closing Memo"
    static let ActionTitleDesignCenter : String = "Design Center"
    static let ActionTitleContract : String = "Sign Contract"
    static let ActionTitleDraftContract : String = "Contract"
    static let ActionTitleThirdPartyFinancingAddendum : String = "Third Party Financing Addendum"
    static let ActionTitleEXHIBIT_A : String = "Exhibit A"
    static let ActionTitleEXHIBIT_B : String = "Exhibit B"
    static let ActionTitleEXHIBIT_C : String = "Exhibit C General"
//    static let ActionTitleINFORMATION_ABOUT_BROKERAGE_SERVICES = "Information about brokerage services"
    static let ActionTitleINFORMATION_ABOUT_BROKERAGE_SERVICES = "Information about Brokerage Services"
    static let ActionTitleGoContract : String = "Print Contract"
    static let ActionTitleGoDraft : String = "Print Draft"
    
    static let ApplicationColor  = UIColor(red: 0, green: 164/255.0, blue: 236/255.0, alpha: 1)
    static let SearchBarBackColor = UIColor(red: 238/255.0, green: 238/255.0, blue: 238/255.0, alpha: 1)
    static let ApplicationBarFontName  =  "Futura"
    static let ApplicationBarFontSize : CGFloat = 25.0
    static let ApplicationBarItemFontSize : CGFloat = 17.0
}



