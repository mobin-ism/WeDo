//
//  LandingViewController.swift
//  WeDo
//
//  Created by Creativeitem on 17/7/18.
//  Copyright © 2018 Creativeitem. All rights reserved.
//

import UIKit
import Localize_Swift
class LandingViewController: UIViewController {
    
    lazy var landingScreenImageView : UIImageView = {
        var imageView = UIImageView()
        imageView.image = #imageLiteral(resourceName: "splash-screen")
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    override func viewDidLoad() {
        view.backgroundColor = UIColor.white
        self.layout()
        self.checkMandatoryUserDefaults()
    }
    
    func layout() {
        self.setLandingScreen()
    }
    
    func setLandingScreen() {
        view.addSubview(landingScreenImageView)
        landingScreenImageView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        landingScreenImageView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        landingScreenImageView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        landingScreenImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Hide the navigation bar on the this view controller
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0, execute: {
            self.navigationController?.pushViewController(HomeViewController(), animated: true)
        })
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    func checkMandatoryUserDefaults() {
        if !Helper.Exists(key: LANGUAGE) {
            UserDefaults.standard.set("en", forKey: LANGUAGE)
            UIView.appearance().semanticContentAttribute = .forceLeftToRight
            Localize.setCurrentLanguage("en")
        }else {
            if UserDefaults.standard.value(forKey: LANGUAGE) as! String == "en" {
                UIView.appearance().semanticContentAttribute = .forceLeftToRight
                Localize.setCurrentLanguage("en")
            }else if UserDefaults.standard.value(forKey: LANGUAGE) as! String == "ar" {
                UIView.appearance().semanticContentAttribute = .forceRightToLeft
                Localize.setCurrentLanguage("ar")
            }
        }
        
        if !Helper.Exists(key: IS_LOGGED_IN) {
            UserDefaults.standard.set( false, forKey: IS_LOGGED_IN)
        }
    }
}
