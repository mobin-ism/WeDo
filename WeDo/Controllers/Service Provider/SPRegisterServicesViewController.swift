//
//  SPRegisterServicesViewController.swift
//  WeDo
//
//  Created by Tanvir Hasan Piash on 15/9/18.
//  Copyright © 2018 Creativeitem. All rights reserved.
//

import UIKit
import SDWebImage

class SPRegisterServicesViewController: UIViewController {
    
    lazy var menu: Menu = {
        let slideMenu = Menu()
        slideMenu.spRegisterServicesVC = self
        return slideMenu
    }()
    
    lazy var companyButton : UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.clipsToBounds = true
        button.backgroundColor = UIColor(red:64/255, green:173/255, blue:93/255, alpha:0.9)
        button.setTitle("Company".localized(), for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = UIFont(name: OPENSANS_REGULAR, size: 12)
        button.tag = 1
        button.addTarget(self, action: #selector(navigationButtonTapped( _:)), for: .touchUpInside)
        return button
    }()
    
    lazy var addressButton : UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.clipsToBounds = true
        button.backgroundColor = UIColor(red:64/255, green:173/255, blue:93/255, alpha:0.9)
        button.setTitle("Address".localized(), for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = UIFont(name: OPENSANS_REGULAR, size: 12)
        button.tag = 2
        button.addTarget(self, action: #selector(navigationButtonTapped( _:)), for: .touchUpInside)
        return button
    }()
    
    lazy var dateTimeButton : UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.clipsToBounds = true
        button.backgroundColor = UIColor(red:64/255, green:173/255, blue:93/255, alpha:0.9)
        button.setTitle("Date & Time".localized(), for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = UIFont(name: OPENSANS_REGULAR, size: 12)
        button.tag = 3
        button.addTarget(self, action: #selector(navigationButtonTapped( _:)), for: .touchUpInside)
        return button
    }()
    
    lazy var servicesButton : UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.clipsToBounds = true
        button.backgroundColor = UIColor(red:64/255, green:173/255, blue:93/255, alpha:0.9)
        button.setTitle("Services".localized(), for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = UIFont(name: OPENSANS_REGULAR, size: 12)
        button.tag = 4
        button.addTarget(self, action: #selector(navigationButtonTapped( _:)), for: .touchUpInside)
        return button
    }()
    
    let backgroundImageView : UIImageView = {
        var imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .clear
        imageView.image = #imageLiteral(resourceName: "bigger-logo")
        return imageView
    }()
    
    lazy var tableView: UITableView = {
        let view = UITableView()
        view.backgroundColor = UIColor.clear
        view.allowsMultipleSelection = true
        view.delegate = self
        view.dataSource = self
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var object: SPServicesModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        tableView.register(SPServiceHeaderCell.self, forHeaderFooterViewReuseIdentifier: SPServiceHeaderCell.cellId)
        tableView.register(SimpleTableCell.self, forCellReuseIdentifier: SimpleTableCell.cellId)
        setNavigationBar()
        layout()
    }
    
    private func setNavigationBar() {
        navigationController?.navigationBar.barTintColor = NAVBAR_BG_COLOR
        let logo = UIImage(named: "logo.png")
        let imageView = UIImageView(image:logo)
        self.navigationItem.titleView = imageView
        //navigationItem.leftBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "back-icon"), style: .plain, target: self, action: #selector(backTapped))
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "menu"), style: .plain, target: self, action: #selector(menuIconTapped))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        Alert.checkInternetConnection(on: self)
        getServices()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        servicesButton.titleLabel?.font = UIFont(name: OPENSANS_BOLD, size: 12)
    }
    
    func layout() {
        setupBackgroundImageView()
        setupCompanyButton()
        setupAddressButton()
        setupDateTimeButton()
        setupServicesButton()
        setupTableView()
    }
    
    func setupBackgroundImageView() {
        view.addSubview(backgroundImageView)
        backgroundImageView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        backgroundImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 25).isActive = true
        backgroundImageView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.5).isActive = true
        backgroundImageView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8).isActive = true
    }
    
    func setupCompanyButton() {
        view.addSubview(companyButton)
        companyButton.topAnchor.constraint(equalTo: view.topAnchor, constant: Helper.barHeight+(self.navigationController?.navigationBar.frame.size.height)!).isActive = true
        companyButton.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        companyButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        companyButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.25).isActive = true
    }
    
    func setupAddressButton() {
        view.addSubview(addressButton)
        addressButton.topAnchor.constraint(equalTo: companyButton.topAnchor).isActive = true
        addressButton.leadingAnchor.constraint(equalTo: companyButton.trailingAnchor).isActive = true
        addressButton.heightAnchor.constraint(equalTo: companyButton.heightAnchor).isActive = true
        addressButton.widthAnchor.constraint(equalTo: companyButton.widthAnchor).isActive = true
    }
    
    func setupDateTimeButton() {
        view.addSubview(dateTimeButton)
        dateTimeButton.topAnchor.constraint(equalTo: companyButton.topAnchor).isActive = true
        dateTimeButton.leadingAnchor.constraint(equalTo: addressButton.trailingAnchor).isActive = true
        dateTimeButton.heightAnchor.constraint(equalTo: companyButton.heightAnchor).isActive = true
        dateTimeButton.widthAnchor.constraint(equalTo: companyButton.widthAnchor).isActive = true
    }
    
    func setupServicesButton() {
        view.addSubview(servicesButton)
        servicesButton.topAnchor.constraint(equalTo: companyButton.topAnchor).isActive = true
        servicesButton.leadingAnchor.constraint(equalTo: dateTimeButton.trailingAnchor).isActive = true
        servicesButton.heightAnchor.constraint(equalTo: companyButton.heightAnchor).isActive = true
        servicesButton.widthAnchor.constraint(equalTo: companyButton.widthAnchor).isActive = true
    }
    
    func setupTableView() {
        view.addSubview(tableView)
        tableView.topAnchor.constraint(equalTo: companyButton.bottomAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    @objc private func menuIconTapped() {
        self.menu.show(self)
    }
    
    @objc private func navigationButtonTapped(_ sender: UIButton) {
        switch sender.tag {
        case 1:
            navigationController?.pushViewController(SPRegisterCompanyViewController(), animated: false)
        case 2:
            navigationController?.pushViewController(SPRegisterAddressViewController(), animated: false)
        case 3:
            navigationController?.pushViewController(SPRegisterDateTimeViewController(), animated: false)
        default:
            print("current view controller")
        }
    }
    
    public func selectedViewControllerFromMenu(indexNumber : Int) {
        if  UserDefaults.standard.value(forKey: IS_SERVICE_PROVIDER) as! Bool == true {
            switch indexNumber {
            case 0:
                self.navigationController?.pushViewController(SPCurrentJobsViewController(), animated: true)
            case 1:
                self.navigationController?.pushViewController(SPCurrentJobsViewController(), animated: true)
            case 2:
                self.navigationController?.pushViewController(SPProfileViewController(), animated: true)
            case 3:
                self.navigationController?.pushViewController(SPServiceHistoryViewController(), animated: true)
            case 4:
                self.navigationController?.pushViewController(SPContactViewController(), animated: true)
            case 5:
                Alert.logOutConfirmationAlert(on: self)
            default:
                print("Wrong Index")
            }
        } else {
            switch indexNumber {
            case 0:
                self.navigationController?.pushViewController(HomeViewController(), animated: true)
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

extension SPRegisterServicesViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        guard let object = object else { return 1 }
        return object.services.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let object = object else { return 1 }
        return object.services[section].child.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SimpleTableCell.cellId, for: indexPath) as! SimpleTableCell
        guard let object = object else { return cell }
        cell.mainLabel.text = object.services[indexPath.section].child[indexPath.row].title
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Selected row \(indexPath.row) of section \(indexPath.section)")
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        print("Deselected row \(indexPath.row) of section \(indexPath.section)")
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let object = object else { return UIView() }
        let cell = tableView.dequeueReusableHeaderFooterView(withIdentifier: SPServiceHeaderCell.cellId) as! SPServiceHeaderCell
        cell.mainLabel.text = object.services[section].title
        cell.mainImageView.sd_setImage(with: URL(string: object.services[section].smallIconOne.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!))
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 72
    }
    
}

extension SPRegisterServicesViewController {
    
    func getServices() {
        guard let url = URL(string: "\(BASE_URL)api/v2/general/services?id=8&language=\(UserDefaults.standard.value(forKey: LANGUAGE) as! String)") else { return }
        HTTPRequestHandler.makeGetHttpRequest(url: url, parameter: [:]) { (response, error) in
            guard let response = response else { return }
            if let json = response.data {
                let decoder = JSONDecoder()
                do {
                    let data = try decoder.decode(SPServicesModel.self, from: json)
                    self.object = data
                    self.tableView.reloadData()
                } catch let err {
                    print(err)
                }
            }
        }
    }
    
}
