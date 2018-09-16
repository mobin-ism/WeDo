//
//  SPRegisterViewController.swift
//  WeDo
//
//  Created by Tanvir Hasan Piash on 15/9/18.
//  Copyright © 2018 Creativeitem. All rights reserved.
//

import UIKit
import Pager

class SPRegisterViewController: PagerController, PagerDataSource {
    
    var vc1 = SPRegisterCompanyViewController()
    var vc2 = SPRegisterAddressViewController()
    var vc3 = SPRegisterDateTimeViewController()
    var vc4 = SPRegisterServicesViewController()
    
    lazy var menu: Menu = {
        let slideMenu = Menu()
        slideMenu.spRegisterVC = self
        return slideMenu
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.dataSource = self
        
        self.setupPager(
            tabNames: ["Company".localized(), "Address".localized(), "Date & Timing".localized(), "Services".localized()],
            tabControllers: [vc1, vc2, vc3, vc4])
        customizeTab()
        setNavigationBar()
    }
    
    private func setNavigationBar() {
        navigationController?.navigationBar.barTintColor = NAVBAR_BG_COLOR
        let logo = UIImage(named: "logo.png")
        let imageView = UIImageView(image:logo)
        self.navigationItem.titleView = imageView
        //navigationItem.leftBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "back-icon"), style: .plain, target: self, action: #selector(backTapped))
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "menu"), style: .plain, target: self, action: #selector(menuIconTapped))
    }
    
    @objc func menuIconTapped() {
        self.menu.show(self)
    }
    
    func changeTabs(index: Int) {
        selectTabAtIndex(index)
    }
    
    func customizeTab() {
        indicatorColor = UIColor.white
        indicatorHeight = 2
        tabsViewBackgroundColor = GREENISH_COLOR
        contentViewBackgroundColor = UIColor.white
        
        startFromSecondTab = false
        centerCurrentTab = true
        tabLocation = PagerTabLocation.top
        tabHeight = 36
        tabOffset = 36
        tabWidth = 128
        fixFormerTabsPositions = false
        fixLaterTabsPosition = false
        animation = PagerAnimation.during
        selectedTabTextColor = UIColor.white
        tabsTextFont = UIFont.systemFont(ofSize: 12)
        // tabTopOffset = 10.0
        tabsTextColor = UIColor.black
        
    }
    
}
