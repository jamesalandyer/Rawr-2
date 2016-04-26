//
//  RestartVC.swift
//  Rawr 2
//
//  Created by James Dyer on 4/24/16.
//  Copyright © 2016 James Dyer. All rights reserved.
//

import UIKit
import Alamofire

class RestartVC: UIViewController {
    
    //Outlets
    @IBOutlet weak var quoteLbl: UILabel!
    @IBOutlet weak var authorLbl: UILabel!
    
    //Properties
    var quote: String?
    var author: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Quote of The Day
        let url = NSURL(string: "http://quotes.rest/qod.json?category=inspire")!
        Alamofire.request(.GET, url).responseJSON { response in
            let result = response.result
            if let dict = result.value as? Dictionary<String, AnyObject> {
                if let cont = dict["contents"] as? Dictionary<String, AnyObject> {
                    if let quotes = cont["quotes"] as? [Dictionary<String, AnyObject>] {
                        if let quoteCon = quotes[0] as? Dictionary<String, AnyObject> {
                            if let quoteTxt = quoteCon["quote"] as? String {
                                self.quote = quoteTxt
                            }
                            if let authorTxt = quoteCon["author"] as? String {
                                self.author = authorTxt
                            }
                        }
                    }
                }
            }
            
        }
    }
    
    override func viewDidAppear(animated: Bool) {
        if quote != nil && author != nil {
            quoteLbl.text = quote!.uppercaseString
            authorLbl.text = "- \(author!.uppercaseString)"
        }
    }
   
}
