//
//  Menu.swift
//  WeDo
//
//  Created by Al Mobin on 18/7/18.
//  Copyright © 2018 Creativeitem. All rights reserved.
//

import UIKit
import Localize_Swift
class Menu: NSObject {
    
    var homeController = HomeViewController()
    var registerVC = RegisterViewController()
    var loginVC = LoginViewController()
    var activeOrderVC = ActiveOrderViewController()
    var orderhistoryVC = OrderHistoryViewController()
    var companyVC = CompanyViewController()
    var notificationVC = NotificationViewController()
    var faqVC = HelpAndFAQViewController()
    var contactUsVC = ContactUsViewController()
    var editProfileVC = EditProfileViewController()
    var spCurrentJobsVC = SPCurrentJobsViewController()
    var spNewJobsVC = SPNewJobsViewController()
    var spRequestedJobsVC = SPRequestedJobsViewController()
    var spLoginVerifyVC = SPLoginVerifyViewController()
    var spProfileVC = SPProfileViewController()
    var spContactVC = SPContactViewController()
    var spRegisterCompanyVC = SPRegisterCompanyViewController()
    var spRegisterAddressVC = SPRegisterAddressViewController()
    var spRegisterDateTimeVC = SPRegisterDateTimeViewController()
    var spRegisterServicesVC = SPRegisterServicesViewController()
    
    var frequentlyAskedVC = FaqViewController()
    
    var calledFrom : String!
    
    lazy var backgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red:0.89, green:0.89, blue:0.89, alpha:0.7)
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        view.alpha = 0
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(hide)))
        return view
    }()
    
    let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        view.clipsToBounds = true
        return view
    }()
    
    let welcomeLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = UIColor.white
        label.font = UIFont(name: OPENSANS_REGULAR, size: 15)
        label.numberOfLines = 0
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let nametLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = UIColor.white
        
        label.font = UIFont(name: OPENSANS_BOLD, size: 20)
        label.numberOfLines = 0
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = #imageLiteral(resourceName: "bigger-logo")
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = UIColor(red:0.22, green:0.70, blue:0.37, alpha:1.0)
        return imageView
    }()
    
    let copyrightLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = UIColor.black
        label.font = UIFont(name: OPENSANS_REGULAR, size: 12)
        label.numberOfLines = 0
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var tableView: UITableView = {
        let table = UITableView()
        table.backgroundColor = UIColor.clear
        table.separatorColor = UIColor.black
        table.clipsToBounds = true
        table.translatesAutoresizingMaskIntoConstraints = false
        table.delegate = self
        table.dataSource = self
        table.showsVerticalScrollIndicator = false
        return table
    }()
    
    let cellId = "MenuCell"
    let menuItemsForLoggedOut = ["Home".localized(), "Help & FAQ".localized(), "Contact Us".localized(), "Login".localized()]
    let menuItemsForLoggedIn  = ["Home".localized(), "My Order".localized(), "Notification".localized(), "Order History".localized(), "Help & FAQ".localized(), "Contact Us".localized(), "Edit Profile".localized(), "Logout".localized()]
    let menuItemsForLoggedInSP = ["Home".localized(), "Current Jobs".localized(), "Profile".localized(), "Service History".localized(), "Contact Us".localized(), "Logout".localized()]
    
    override init() {
        super.init()
        tableView.register(MenuCell.self, forCellReuseIdentifier: cellId)
    }
    
    func show(_ vc: UIViewController) {
        self.calledFrom = self.getClassName(vc)
        if UserDefaults.standard.value(forKey: IS_LOGGED_IN) as! Bool {
            self.welcomeLabel.text = "Welcome".localized()
            if UserDefaults.standard.value(forKey: IS_SERVICE_PROVIDER) as! Bool == true {
                self.nametLabel.text = "\(UserDefaults.standard.value(forKey: COMPANY_NAME) as! String)"
            } else {
                self.nametLabel.text = "\(UserDefaults.standard.value(forKey: MEMBER_NAME) as! String)"
            }
        }
        setupSubViews()
        self.tableView.reloadData()
    }
    
    func getClassName(_ vc : UIViewController) -> String {
        var firstPartOfString : String!
        firstPartOfString = String(describing: vc)
        var secondPartOfString = String(firstPartOfString.dropFirst(6))
        if let colonRange = secondPartOfString.range(of: ":") {
            secondPartOfString.removeSubrange(colonRange.lowerBound..<secondPartOfString.endIndex)
        }
        return secondPartOfString
    }
    func myCommonMethod(_ aViewController: UIViewController?) {
        if type(of: aViewController) == NSClassFromString("MyFirstController") {
            
        } else if type(of: aViewController) == NSClassFromString("MySecondController") {
            
        }
    }
    
    func setupSubViews() {
        // adding the background view
        if let window = UIApplication.shared.keyWindow {
            window.addSubview(backgroundView)
            UIView.animate(withDuration: 0.33, animations: {
                self.backgroundView.alpha = 1
            })
            // constraints
            backgroundView.topAnchor.constraint(equalTo: window.topAnchor).isActive = true
            backgroundView.leadingAnchor.constraint(equalTo: window.leadingAnchor).isActive = true
            backgroundView.trailingAnchor.constraint(equalTo: window.trailingAnchor).isActive = true
            backgroundView.bottomAnchor.constraint(equalTo: window.bottomAnchor).isActive = true
            
            // adding the container view
            setupContainerView(window: window)
        }
    }
    
    func setupContainerView(window: UIWindow) {
        window.addSubview(containerView)
        let width = window.frame.width * 0.85
        if UserDefaults.standard.value(forKey: LANGUAGE) as! String == "ar" {
           containerView.frame = CGRect(x: window.frame.width, y: 0, width: width, height: window.frame.height)
        } else {
            containerView.frame = CGRect(x: -window.frame.width, y: 0, width: width, height: window.frame.height)
        }
        
        setupLogoImageView()
        setupWelcomeLabel()
        setupNameLabel()
        setupCopyrightLabels()
        setupTableView()
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.9, initialSpringVelocity: 1, options: .curveEaseIn, animations: {
            if UserDefaults.standard.value(forKey: LANGUAGE) as! String == "ar" {
                self.containerView.frame = CGRect(x: window.frame.width - width, y: 0, width: self.containerView.frame.width, height: self.containerView.frame.height)
            } else {
                self.containerView.frame = CGRect(x: 0, y: 0, width: self.containerView.frame.width, height: self.containerView.frame.height)
            }
        }, completion: nil)
    }
    
    func setupLogoImageView() {
        containerView.addSubview(logoImageView)
        let width = containerView.frame.width
        
        logoImageView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor).isActive = true
        logoImageView.topAnchor.constraint(equalTo: containerView.topAnchor).isActive = true
        logoImageView.widthAnchor.constraint(equalToConstant: width).isActive = true
        logoImageView.heightAnchor.constraint(equalToConstant: 200).isActive = true
    }
    
    func setupWelcomeLabel() {
        containerView.addSubview(welcomeLabel)
        welcomeLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 70).isActive = true
        welcomeLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20).isActive = true
    }
    func setupNameLabel() {
        containerView.addSubview(nametLabel)
        nametLabel.topAnchor.constraint(equalTo: welcomeLabel.bottomAnchor).isActive = true
        nametLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20).isActive = true
    }
    func setupCopyrightLabels() {
        containerView.addSubview(copyrightLabel)
        copyrightLabel.text = "WeDo   |   2018"
        copyrightLabel.centerXAnchor.constraint(equalTo: containerView.centerXAnchor).isActive = true
        copyrightLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -30).isActive = true
        copyrightLabel.widthAnchor.constraint(equalTo: containerView.widthAnchor, multiplier: 0.9).isActive = true
        copyrightLabel.heightAnchor.constraint(equalToConstant: 14).isActive = true
    }
    
    func setupTableView() {
        containerView.addSubview(tableView)
        tableView.centerXAnchor.constraint(equalTo: logoImageView.centerXAnchor).isActive = true
        tableView.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 30).isActive = true
        tableView.bottomAnchor.constraint(equalTo: copyrightLabel.topAnchor, constant: -20).isActive = true
        tableView.widthAnchor.constraint(equalTo: containerView.widthAnchor, multiplier: 0.9).isActive = true
    }
    
    @objc func hide() {
        if let window = UIApplication.shared.keyWindow {
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.9, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                if UserDefaults.standard.value(forKey: LANGUAGE) as! String == "ar" {
                    self.containerView.frame = CGRect(x: window.frame.width, y: 0, width: self.containerView.frame.width, height: self.containerView.frame.height)
                } else {
                    self.containerView.frame = CGRect(x: -window.frame.width, y: 0, width: self.containerView.frame.width, height: self.containerView.frame.height)
                }
                self.backgroundView.alpha = 0
            }, completion: nil)
        }
    }
}

extension Menu: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if UserDefaults.standard.value(forKey: IS_LOGGED_IN) as! Bool {
            if UserDefaults.standard.value(forKey: IS_SERVICE_PROVIDER) as! Bool == true {
                return menuItemsForLoggedInSP.count
            } else {
                return menuItemsForLoggedIn.count
            }
        } else {
            return menuItemsForLoggedOut.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as? MenuCell {
            if UserDefaults.standard.value(forKey: IS_LOGGED_IN) as! Bool {
                if UserDefaults.standard.value(forKey: IS_SERVICE_PROVIDER) as! Bool == true {
                    cell.titleText = menuItemsForLoggedInSP[indexPath.row]
                } else {
                    if  indexPath.row == 1 || indexPath.row == 2 || indexPath.row == 3 {
                        cell.titleLabel.font = UIFont(name: OPENSANS_BOLD, size: 15)
                    }
                    cell.titleText = menuItemsForLoggedIn[indexPath.row]
                }
            }else {
                cell.titleText = menuItemsForLoggedOut[indexPath.row]
            }
            return cell
        } else {
            let cell = tableView.cellForRow(at: indexPath)!
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        hide()
        switch self.calledFrom {
        case "HomeViewController":
            self.homeController.selectedViewControllerFromMenu(indexNumber: indexPath.row)
        case "RegisterViewController":
            self.registerVC.selectedViewControllerFromMenu(indexNumber: indexPath.row)
        case "LoginViewController":
            self.loginVC.selectedViewControllerFromMenu(indexNumber: indexPath.row)
        case "ActiveOrderViewController":
            self.activeOrderVC.selectedViewControllerFromMenu(indexNumber: indexPath.row)
        case "OrderHistoryViewController":
            self.orderhistoryVC.selectedViewControllerFromMenu(indexNumber: indexPath.row)
        case "CompanyViewController":
            self.companyVC.selectedViewControllerFromMenu(indexNumber: indexPath.row)
        case "NotificationViewController":
            self.notificationVC.selectedViewControllerFromMenu(indexNumber: indexPath.row)
        case "HelpAndFAQViewController":
            self.faqVC.selectedViewControllerFromMenu(indexNumber: indexPath.row)
        case "ContactUsViewController":
            self.contactUsVC.selectedViewControllerFromMenu(indexNumber: indexPath.row)
        case "EditProfileViewController":
            self.editProfileVC.selectedViewControllerFromMenu(indexNumber: indexPath.row)
        case "SPLoginVerifyViewController":
            self.spLoginVerifyVC.selectedViewControllerFromMenu(indexNumber: indexPath.row)
        case "SPProfileViewController":
            self.spProfileVC.selectedViewControllerFromMenu(indexNumber: indexPath.row)
        case "SPContactViewController":
            self.spContactVC.selectedViewControllerFromMenu(indexNumber: indexPath.row)
        case "SPCurrentJobsViewController":
            self.spCurrentJobsVC.selectedViewControllerFromMenu(indexNumber: indexPath.row)
        case "SPNewJobsViewController":
            self.spNewJobsVC.selectedViewControllerFromMenu(indexNumber: indexPath.row)
        case "SPRequestedJobsViewController":
            self.spRequestedJobsVC.selectedViewControllerFromMenu(indexNumber: indexPath.row)
        case "SPRegisterCompanyViewController":
            self.spRegisterCompanyVC.selectedViewControllerFromMenu(indexNumber: indexPath.row)
        case "SPRegisterAddressViewController":
            self.spRegisterAddressVC.selectedViewControllerFromMenu(indexNumber: indexPath.row)
        case "SPRegisterDateTimeViewController":
            self.spRegisterDateTimeVC.selectedViewControllerFromMenu(indexNumber: indexPath.row)
        case "SPRegisterServicesViewController":
            self.spRegisterServicesVC.selectedViewControllerFromMenu(indexNumber: indexPath.row)
        default:
            print("Call from mars")
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 55
    }
    
}
