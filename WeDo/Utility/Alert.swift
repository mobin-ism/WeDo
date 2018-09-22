//
//  Alert.swift
//  WeDo
//
//  Created by Creativeitem on 6/8/18.
//  Copyright © 2018 Creativeitem. All rights reserved.
//

import Foundation
import UIKit
import Localize_Swift

struct Alert {
    
    public static func showBasicAlert(on vc : UIViewController, with title : String, message : String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Okay".localized(), style: UIAlertActionStyle.default, handler: nil))
        vc.present(alert, animated: true, completion: nil)
    }
        
    public static func checkInternetConnection(on vc: UIViewController) {
        if !Reachability.isConnectedToNetwork() {
          showBasicAlert(on: vc, with: "No Internet Connection", message: "Please check your internet connection")
        }
    }
    
    public static func logOutConfirmationAlert(on vc : UIViewController) {
        
        let alert = UIAlertController(title: "Are you sure?".localized(), message: "", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Logout".localized(), style: .default, handler: { action in
            //run your function here
            vc.navigationController?.pushViewController(HomeViewController(), animated: false)
            UserDefaults.standard.set(false, forKey: IS_LOGGED_IN)
            UserDefaults.standard.set(false, forKey: IS_SERVICE_PROVIDER)
        }))
        alert.addAction(UIAlertAction(title: "Cancel".localized(), style: .default, handler: { action in
            //run your function here
            
        }))
        vc.present(alert, animated: true, completion: nil)
    }
}
