//
//  ServiceDescriptionOneViewController.swift
//  WeDo
//
//  Created by Creativeitem on 19/7/18.
//  Copyright © 2018 Creativeitem. All rights reserved.
//

import UIKit
import SVProgressHUD

class ServiceDescriptionOneViewController: UIViewController {
    
    var subServiceTitle : String?
    
    lazy var backgroundImageView : UIImageView = {
        var imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .clear
        imageView.image = #imageLiteral(resourceName: "bigger-logo")
        return imageView
    }()
    
    lazy var serviceIconImageView : UIImageView = {
        var imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .clear
        
        return imageView
    }()
    
    lazy var serviceTitleLabel : UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.clipsToBounds = true
        label.textAlignment = .left
        
        label.numberOfLines = 0
        label.textColor = UIColor.black
        label.font = UIFont(name: OPENSANS_REGULAR, size: 16)
        return label
    }()
    
    lazy var serviceSubTitleLabel : UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.clipsToBounds = true
        label.textAlignment = .left
        
        label.numberOfLines = 0
        label.textColor = UIColor.gray
        label.font = UIFont(name: OPENSANS_REGULAR, size: 12)
        return label
    }()
    
    lazy var descriptionButton : UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.clipsToBounds = true
        button.backgroundColor = UIColor(red:64/255, green:173/255, blue:93/255, alpha:0.9)
        button.setTitle("Description", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = UIFont(name: OPENSANS_REGULAR, size: 12)
        button.tag = 1
        button.addTarget(self, action: #selector(navigationButtonTapped( _:)), for: .touchUpInside)
        return button
    }()
    
    lazy var locationButton : UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.clipsToBounds = true
        button.backgroundColor = UIColor(red:64/255, green:173/255, blue:93/255, alpha:0.9)
        button.setTitle("Location", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.titleLabel?.font = UIFont(name: OPENSANS_REGULAR, size: 12)
        button.tag = 2
        button.addTarget(self, action: #selector(navigationButtonTapped( _:)), for: .touchUpInside)
        return button
    }()
    
    lazy var dateAndTimeButton : UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.clipsToBounds = true
        button.backgroundColor = UIColor(red:64/255, green:173/255, blue:93/255, alpha:0.9)
        button.setTitle("Date and Time", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.titleLabel?.font = UIFont(name: OPENSANS_REGULAR, size: 12)
        button.tag = 3
        button.addTarget(self, action: #selector(navigationButtonTapped( _:)), for: .touchUpInside)
        return button
    }()
    
    lazy var paymentButton : UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.clipsToBounds = true
        button.backgroundColor = UIColor(red:64/255, green:173/255, blue:93/255, alpha:0.9)
        button.setTitle("Payment", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.titleLabel?.font = UIFont(name: OPENSANS_REGULAR, size: 12)
        button.tag = 4
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
    
    lazy var leftHorizontalLine : UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        view.backgroundColor = UIColor(red:0.62, green:0.62, blue:0.62, alpha:0.5)
        return view
    }()
    
    lazy var rightHorizontalLine : UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        view.backgroundColor = UIColor(red:0.62, green:0.62, blue:0.62, alpha:0.5)
        return view
    }()
    
    lazy var orLabel : UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.clipsToBounds = true
        label.textAlignment = .center
        label.text = "OR"
        label.numberOfLines = 0
        label.textColor = UIColor.black
        label.font = UIFont(name: OPENSANS_REGULAR, size: 15)
        return label
    }()
    
    lazy var postButton : UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.clipsToBounds = true
        button.backgroundColor = UIColor(red:0.17, green:0.67, blue:0.31, alpha:1.0)
        button.setTitle("POST YOUR JOB FOR BID", for: .normal)
        button.titleLabel?.font = UIFont(name: OPENSANS_REGULAR, size: 15)
        button.layer.cornerRadius = 5
        button.addTarget(self, action: #selector(handlePostButton), for: .touchUpInside)
        return button
    }()
    
    let cellId = "serviceDetailsCell"
    
    var jobIdList = [Int]()
    var jobTitleList = [String]()
    var jobRateList = [Int]()
    
    var serviceDescriptionTwoVC = ServiceDescriptionTwoViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        tableView.register(ServiceDetailsCell.self, forCellReuseIdentifier: cellId)
        layout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNavigationBar()
        self.serviceSubTitleLabel.text = UserDefaults.standard.value(forKey: SUB_SERVICE_TITLE) as? String
        self.getServiceAndSubServiceDetails(subServiceId: UserDefaults.standard.value(forKey: SUB_SERVICE_ID) as! Int)
    }
    
    private func setNavigationBar() {
        navigationController?.navigationBar.barTintColor = NAVBAR_BG_COLOR
        let logo = UIImage(named: "logo.png")
        let imageView = UIImageView(image:logo)
        self.navigationItem.titleView = imageView
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "back-icon"), style: .plain, target: self, action: #selector(backTapped))
        self.navigationController?.navigationBar.shadowImage = UIImage()
    }
    
    func layout() {
        setupBackgroundImageView()
        /*setupDescriptionButton()
        setupLocationButton()
        setupDateTimeButton()
        setupPaymentButton()*/
        setupServiceIconImageView()
        setupServiceTitleLabel()
        setupServiceSubTitleLabel()
        setupTableView()
        setupOrLabel()
        setupLeftHorizontalLine()
        setupRighttHorizontalLine()
        setupPostButton()
    }
    
    func setupBackgroundImageView() {
        view.addSubview(backgroundImageView)
        backgroundImageView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        backgroundImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 25).isActive = true
        backgroundImageView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.5).isActive = true
        backgroundImageView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8).isActive = true
    }
    
    func setupDescriptionButton() {
        view.addSubview(descriptionButton)
        descriptionButton.topAnchor.constraint(equalTo: view.topAnchor, constant: Helper.barHeight+(self.navigationController?.navigationBar.frame.size.height)!).isActive = true
        descriptionButton.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        descriptionButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        descriptionButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.25).isActive = true
    }
    
    func setupLocationButton() {
        view.addSubview(locationButton)
        locationButton.topAnchor.constraint(equalTo: view.topAnchor, constant: Helper.barHeight+(self.navigationController?.navigationBar.frame.size.height)!).isActive = true
        locationButton.leftAnchor.constraint(equalTo: descriptionButton.rightAnchor).isActive = true
        locationButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        locationButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.25).isActive = true
    }
    
    func setupDateTimeButton() {
        view.addSubview(dateAndTimeButton)
        dateAndTimeButton.topAnchor.constraint(equalTo: view.topAnchor, constant: Helper.barHeight+(self.navigationController?.navigationBar.frame.size.height)!).isActive = true
        dateAndTimeButton.leftAnchor.constraint(equalTo: locationButton.rightAnchor).isActive = true
        dateAndTimeButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        dateAndTimeButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.25).isActive = true
    }
    
    func setupPaymentButton() {
        view.addSubview(paymentButton)
        paymentButton.topAnchor.constraint(equalTo: view.topAnchor, constant: Helper.barHeight+(self.navigationController?.navigationBar.frame.size.height)!).isActive = true
        paymentButton.leftAnchor.constraint(equalTo: dateAndTimeButton.rightAnchor).isActive = true
        paymentButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        paymentButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.25).isActive = true
    }
    
    func setupServiceIconImageView() {
        view.addSubview(serviceIconImageView)
        serviceIconImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: Helper.barHeight+(self.navigationController?.navigationBar.frame.size.height)! + 20).isActive = true
        serviceIconImageView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16).isActive = true
        serviceIconImageView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        serviceIconImageView.widthAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    func setupServiceTitleLabel() {
        view.addSubview(serviceTitleLabel)
        serviceTitleLabel.topAnchor.constraint(equalTo: serviceIconImageView.topAnchor).isActive = true
        serviceTitleLabel.leftAnchor.constraint(equalTo: serviceIconImageView.rightAnchor, constant: 10).isActive = true
        
    }
    
    func setupServiceSubTitleLabel() {
        view.addSubview(serviceSubTitleLabel)
        serviceSubTitleLabel.topAnchor.constraint(equalTo: serviceTitleLabel.bottomAnchor, constant: 5).isActive = true
        serviceSubTitleLabel.leftAnchor.constraint(equalTo: serviceIconImageView.rightAnchor, constant: 10).isActive = true
    }
    
    func setupTableView() {
        view.addSubview(tableView)
        tableView.topAnchor.constraint(equalTo: serviceIconImageView.bottomAnchor, constant: 20).isActive = true
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        tableView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.33).isActive = true
    }
    
    func setupOrLabel() {
        view.addSubview(orLabel)
        orLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        orLabel.topAnchor.constraint(equalTo: tableView.bottomAnchor, constant: 20).isActive = true
    }
    
    func setupLeftHorizontalLine() {
        view.addSubview(leftHorizontalLine)
        leftHorizontalLine.centerYAnchor.constraint(equalTo: orLabel.centerYAnchor).isActive = true
        leftHorizontalLine.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 40).isActive = true
        leftHorizontalLine.rightAnchor.constraint(equalTo: orLabel.leftAnchor, constant: -16).isActive = true
        leftHorizontalLine.heightAnchor.constraint(equalToConstant: 1).isActive = true
    }
    
    func setupRighttHorizontalLine() {
        view.addSubview(rightHorizontalLine)
        rightHorizontalLine.centerYAnchor.constraint(equalTo: orLabel.centerYAnchor).isActive = true
        rightHorizontalLine.leftAnchor.constraint(equalTo: orLabel.rightAnchor, constant: 16).isActive = true
        rightHorizontalLine.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -40).isActive = true
        rightHorizontalLine.heightAnchor.constraint(equalToConstant: 1).isActive = true
    }
    
    func setupPostButton() {
        view.addSubview(postButton)
        postButton.topAnchor.constraint(equalTo: orLabel.bottomAnchor, constant: 20).isActive = true
        postButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16).isActive = true
        postButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16).isActive = true
        postButton.heightAnchor.constraint(equalToConstant: 60).isActive = true
    }
    @objc func backTapped() {
        //self.navigationController?.popViewController(animated: true)
        let viewControllers: [UIViewController] = self.navigationController!.viewControllers
        for aViewController in viewControllers {
            if aViewController is AllServicesListViewController {
                self.navigationController!.popToViewController(aViewController, animated: true)
            }
        }
    }
    
    @objc func navigationButtonTapped(_ sender: UIButton) {
        switch sender.tag {
        case 2:
            self.navigationController?.pushViewController(ServiceLocationOneViewController(), animated: false)
        case 3:
            self.navigationController?.pushViewController(ServiceDateAndTimeOneViewController(), animated: false)
        case 4:
            self.navigationController?.pushViewController(ServicePaymentOneViewController(), animated: false)
        default:
            print("current view controller")
        }
    }
    @objc func handlePostButton() {
        let serviceDescriptionTwoVC = ServiceDescriptionTwoViewController()
        serviceDescriptionTwoVC.skipServiceOneViewController = true
        self.navigationController?.pushViewController(serviceDescriptionTwoVC, animated: true)
    }
}

extension ServiceDescriptionOneViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.jobTitleList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as? ServiceDetailsCell {
            cell.titleText = self.jobTitleList[indexPath.row]
            cell.priceText = "\(self.jobRateList[indexPath.row]) AED"
            return cell
        } else {
            let cell = tableView.cellForRow(at: indexPath)!
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        UserDefaults.standard.set(self.jobIdList[indexPath.row], forKey: JOB_ID)
        self.navigationController?.pushViewController(serviceDescriptionTwoVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
}

// API Calls
extension ServiceDescriptionOneViewController {
    
    func getServiceAndSubServiceDetails(subServiceId: Int) {
        guard let url1 = URL(string: "\(BASE_URL)api/v2/general/services?id=8&language=\(UserDefaults.standard.value(forKey: LANGUAGE) as! String)") else { return }
        HTTPRequestHandler.makeGetHttpRequest(url: url1, parameter: [:]) { (response, nil) in
            guard let response = response else { return }
            
            if let json = response.data {
                let decoder = JSONDecoder()
                do {
                    let serviceList = try decoder.decode(Services.self, from: json)
                    for service in serviceList.services {
                        if  UserDefaults.standard.value(forKey: PARENT_SERVICE_ID) as! Int == service.id {
                            self.serviceTitleLabel.text = service.title
                            self.serviceIconImageView.sd_setImage(with: URL(string: service.smallIconOne))
                        }
                    }
                }catch let err {
                    print(err)
                }
            }
        }
        
        SVProgressHUD.setDefaultMaskType(.black)
        SVProgressHUD.show(withStatus: "Please Wait...")
        guard let url2 = URL(string: "\(BASE_URL)api/v2/general/child/sub/services/\(subServiceId)") else { return }
        HTTPRequestHandler.makeGetHttpRequest(url: url2, parameter: [:]) { (response, nil) in
            guard let response = response else { return }
            
            if !self.jobIdList.isEmpty {
                self.jobIdList.removeAll()
            }
            if !self.jobTitleList.isEmpty {
                self.jobTitleList.removeAll()
            }
            if !self.jobRateList.isEmpty {
                self.jobRateList.removeAll()
            }
            
            if let json = response.data {
                let decoder = JSONDecoder()
                do {
                    let subServiceDetailsList = try decoder.decode(SubServiceDetails.self, from: json)
                    for jobList in subServiceDetailsList.data.services {
                        
                        self.jobIdList.append(jobList.id)
                        self.jobTitleList.append(jobList.title)
                        self.jobRateList.append(jobList.rate)
                    }
                    self.tableView.reloadData()
                }catch let err {
                    print(err)
                }
            }
        }
        SVProgressHUD.dismiss()
    }
}
