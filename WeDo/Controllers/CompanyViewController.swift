//
//  CompanyViewController.swift
//  WeDo
//
//  Created by Al Mobin on 27/7/18.
//  Copyright © 2018 Creativeitem. All rights reserved.
//

import UIKit
class CompanyViewController: UIViewController {
    
    var listOfCompanies = [CompanyListNSObject]()
    let serviceDetailsVC = ServiceDetailsViewController()
    lazy var activeOrderButton : UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.clipsToBounds = true
        button.backgroundColor = UIColor(red:64/255, green:173/255, blue:93/255, alpha:0.9)
        button.setTitle("Active Order", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.titleLabel?.font = UIFont(name: OPENSANS_REGULAR, size: 12)
        button.tag = 1
        button.addTarget(self, action: #selector(navigationButtonTapped( _:)), for: .touchUpInside)
        return button
    }()
    
    lazy var orderHistoryButton : UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.clipsToBounds = true
        button.backgroundColor = UIColor(red:64/255, green:173/255, blue:93/255, alpha:0.9)
        button.setTitle("Order History", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.titleLabel?.font = UIFont(name: OPENSANS_REGULAR, size: 12)
        button.tag = 2
        button.addTarget(self, action: #selector(navigationButtonTapped( _:)), for: .touchUpInside)
        return button
    }()
    
    lazy var companyButton : UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.clipsToBounds = true
        button.backgroundColor = UIColor(red:64/255, green:173/255, blue:93/255, alpha:0.9)
        button.setTitle("Company", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = UIFont(name: OPENSANS_SEMIBOLD, size: 12)
        button.tag = 3
        button.addTarget(self, action: #selector(navigationButtonTapped( _:)), for: .touchUpInside)
        return button
    }()
    
    lazy var tableView: UITableView = {
        let table = UITableView()
        table.backgroundColor = UIColor.clear
        table.separatorColor = UIColor.black
        table.clipsToBounds = true
        table.translatesAutoresizingMaskIntoConstraints = false
        table.delegate = self
        table.dataSource = self
        return table
    }()
    
    let cellId = "companyTableViewCell"
    
    lazy var menu: Menu = {
        let slideMenu = Menu()
        slideMenu.companyVC = self
        return slideMenu
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        setNavigationBar()
        
        tableView.register(CompanyTableViewCell.self, forCellReuseIdentifier: cellId)
        
        layout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        Alert.checkInternetConnection(on: self)
        self.getCompanies()
    }
    
    private func setNavigationBar() {
        navigationController?.navigationBar.barTintColor = NAVBAR_BG_COLOR
        let logo = UIImage(named: "logo.png")
        let imageView = UIImageView(image:logo)
        self.navigationItem.titleView = imageView
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "menu"), style: .plain, target: self, action: #selector(menuIconTapped))
        self.navigationController?.navigationBar.shadowImage = UIImage()
    }
    
    func layout() {
        setupActiveButton()
        setupOrderHistoryButton()
        setupCompanyButton()
        setupTableView()
    }
    
    func setupActiveButton() {
        view.addSubview(activeOrderButton)
        activeOrderButton.topAnchor.constraint(equalTo: view.topAnchor, constant: Helper.barHeight+(self.navigationController?.navigationBar.frame.size.height)!).isActive = true
        activeOrderButton.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        activeOrderButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        activeOrderButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.33).isActive = true
    }
    
    func setupOrderHistoryButton() {
        view.addSubview(orderHistoryButton)
        orderHistoryButton.topAnchor.constraint(equalTo: view.topAnchor, constant: Helper.barHeight+(self.navigationController?.navigationBar.frame.size.height)!).isActive = true
        orderHistoryButton.leftAnchor.constraint(equalTo: activeOrderButton.rightAnchor).isActive = true
        orderHistoryButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        orderHistoryButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.33).isActive = true
    }
    
    func setupCompanyButton() {
        view.addSubview(companyButton)
        companyButton.topAnchor.constraint(equalTo: view.topAnchor, constant: Helper.barHeight+(self.navigationController?.navigationBar.frame.size.height)!).isActive = true
        companyButton.leftAnchor.constraint(equalTo: orderHistoryButton.rightAnchor).isActive = true
        companyButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        companyButton.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
    }
    
    func setupTableView() {
        view.addSubview(tableView)
        tableView.topAnchor.constraint(equalTo: activeOrderButton.bottomAnchor, constant: 16).isActive = true
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -16).isActive = true
    }
    @objc func navigationButtonTapped(_ sender: UIButton) {
        switch sender.tag {
        case 1:
            self.navigationController?.pushViewController(ActiveOrderViewController(), animated: false)
        case 2:
            self.navigationController?.pushViewController(OrderHistoryViewController(), animated: false)
        default:
            print("Current ViewController")
        }
    }
    @objc func menuIconTapped() {
        self.menu.show(self)
    }
    @objc func rightBarButtonTapped() {
        
    }
    
    public func selectedViewControllerFromMenu(indexNumber : Int) {
        if  UserDefaults.standard.value(forKey: IS_LOGGED_IN) as! Bool {
            switch indexNumber {
            case 0:
                self.navigationController?.pushViewController(HomeViewController(), animated: false)
            case 1:
                self.navigationController?.pushViewController(ActiveOrderViewController(), animated: false)
            case 2:
                self.navigationController?.pushViewController(NotificationViewController(), animated: true)
            case 3:
                self.navigationController?.pushViewController(OrderHistoryViewController(), animated: true)
            case 4:
                self.navigationController?.pushViewController(HelpAndFAQViewController(), animated: true)
            case 5:
                self.navigationController?.pushViewController(ContactUsViewController(), animated: true)
            case 6:
                self.navigationController?.pushViewController(EditProfileViewController(), animated: true)
            case 7:
                Alert.logOutConfirmationAlert(on: self)
            default:
                print("Wrong Index")
            }
        }else {
            switch indexNumber {
            case 0:
                self.navigationController?.pushViewController(HomeViewController(), animated: false)
            case 1:
                self.navigationController?.pushViewController(HelpAndFAQViewController(), animated: true)
            case 2:
                self.navigationController?.pushViewController(ContactUsViewController(), animated: true)
            case 3:
                self.navigationController?.pushViewController(LoginViewController(), animated: true)
            default:
                print("Wrong Index")
            }
        }
    }
}

extension CompanyViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as? CompanyTableViewCell {
            cell.serviceImageView.image = #imageLiteral(resourceName: "placeholder")
            cell.titleText = "Test"
            cell.subTitleText = "(Test Name)"
            cell.dateTimeText = "15th May, 2017 | 11:30 AM"
            cell.lastJobDateText = "25th May, 2018"
            return cell
        } else {
            let cell = tableView.cellForRow(at: indexPath)!
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
        self.navigationController?.pushViewController(JobRequestListViewController(), animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
}
// API CALLS
extension CompanyViewController {
    func getCompanies() {
        guard let url = URL(string: "\(BASE_URL)api/v2/member/job/by/company") else { return }
        HTTPRequestHandler.makeGetHttpRequest(url: url, parameter: [:]) { (response, nil) in
            guard let response = response else { return }
            
            if !self.listOfCompanies.isEmpty {
                self.listOfCompanies.removeAll()
            }
            print(response)
            if let json = response.data {
                let decoder = JSONDecoder()
                do {
//                    let activeOrderList = try decoder.decode(ActiveOrderModel.self, from: json)
//
//                    for eachOrder in activeOrderList.data.jobRequestList {
//                        let container = ActiveOrderNSObject(id: eachOrder.id, serviceId: eachOrder.serviceId, parentServiceTitle: eachOrder.parentServiceTitle, serviceTitle: eachOrder.serviceTitle, description: eachOrder.description ?? "", serviceIcon: eachOrder.serviceIcon ?? "https://rabota.a42.ru/front/img/no_image.jpg", status: eachOrder.status ?? "", startDateTime: eachOrder.startDateTime ?? "", bidAmount: eachOrder.bidAmount ?? 0 )
//                        self.listOfOrders.append(container)
//                    }
//
//                    self.tableView.reloadData()
//                    if self.listOfOrders.count == 0 {
//                        Alert.showBasicAlert(on: self, with: "No Order History Found", message: "There is no order history")
//                    }
                }catch let err {
                    print(err)
                }
            }
        }
    }
}
