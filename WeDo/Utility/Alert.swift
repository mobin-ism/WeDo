//
//  Alert.swift
//  WeDo
//
//  Created by Creativeitem on 6/8/18.
//  Copyright © 2018 Creativeitem. All rights reserved.
//

import Foundation
import UIKit

struct Alert {
    
    public static func showBasicAlert(on vc : UIViewController, with title : String, message : String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Okay", style: UIAlertActionStyle.default, handler: nil))
        vc.present(alert, animated: true, completion: nil)
    }
        
    public static func checkInternetConnection(on vc: UIViewController) {
        if !Reachability.isConnectedToNetwork() {
          showBasicAlert(on: vc, with: "No Internet Connection", message: "Please check your internet connection")
        }
    }
}
