//
//  JobRequestListViewController.swift
//  WeDo
//
//  Created by Creativeitem on 29/7/18.
//  Copyright © 2018 Creativeitem. All rights reserved.
//

import UIKit
class JobRequestListViewController: UIViewController {
    
    lazy var serviceTitleLabel : UILabel = {
       var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.clipsToBounds = true
        label.numberOfLines = 1
        label.text = "Full House Cleaning"
        label.font = UIFont(name: OPENSANS_REGULAR, size: 16)
        label.textColor = GREENISH_COLOR
        return label
    }()
    
    lazy var serviceDescription : UITextView = {
       var textview = UITextView()
        textview.translatesAutoresizingMaskIntoConstraints = false
        textview.clipsToBounds = true
        textview.font = UIFont(name: OPENSANS_REGULAR, size: 12)
        textview.textColor = UIColor.black
        textview.text = "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged."
        textview.isScrollEnabled = true
        textview.isUserInteractionEnabled = false
        return textview
    }()
    
    lazy var addressTitleLabel : UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.clipsToBounds = true
        label.font = UIFont(name: OPENSANS_REGULAR, size: 11)
        label.textColor = GREENISH_COLOR
        label.text = "Address"
        return label
    }()
    
    lazy var addressLabel : UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.clipsToBounds = true
        label.font = UIFont(name: OPENSANS_REGULAR, size: 12)
        label.textColor = UIColor.black
        label.text = "Sector No.: 3, Road No. 2, Uttara"
        return label
    }()
    
    lazy var dateTimeTitleLabel : UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.clipsToBounds = true
        label.font = UIFont(name: OPENSANS_REGULAR, size: 11)
        label.textColor = GREENISH_COLOR
        label.text = "Date and Time"
        return label
    }()
    
    lazy var dateLabel : UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.clipsToBounds = true
        label.font = UIFont(name: OPENSANS_REGULAR, size: 12)
        label.textColor = UIColor.black
        label.text = "22 July, 2017"
        return label
    }()
    
    lazy var timeLabel : UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.clipsToBounds = true
        label.font = UIFont(name: OPENSANS_REGULAR, size: 12)
        label.textColor = UIColor.black
        label.text = "1:30 PM"
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
        return table
    }()
    
    let cellId = "jobRequestTableViewCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        setNavigationBar()
        tableView.register(JobRequestListTableViewCell.self, forCellReuseIdentifier: cellId)
        layout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        Alert.checkInternetConnection(on: self)
    }
    
    private func setNavigationBar() {
        navigationController?.navigationBar.barTintColor = NAVBAR_BG_COLOR
        let logo = UIImage(named: "logo.png")
        let imageView = UIImageView(image:logo)
        self.navigationItem.titleView = imageView
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "back-icon"), style: .plain, target: self, action: #selector(backTapped))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Job Request List(15 Bids)", style: .plain, target: self, action: #selector(rightBarButtonTapped))
        self.navigationItem.rightBarButtonItem?.tintColor = UIColor.white
        self.navigationController?.navigationBar.shadowImage = UIImage()
    }
    
    func layout() {
        setupServiceTitleLabel()
        setupServiceDescriptionTextView()
        setupAddressTitleLabel()
        setupAddressLabel()
        setupDateAndTimeTitleLabel()
        setupDateLabel()
        setupTimeLabel()
        setupTableView()
    }
    
    func setupServiceTitleLabel() {
        let topAnchor = Helper.barHeight + (self.navigationController?.navigationBar.frame.size.height)! + 16
        view.addSubview(serviceTitleLabel)
        serviceTitleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: topAnchor).isActive = true
        serviceTitleLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16).isActive = true
        serviceTitleLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16).isActive = true
    }
    
    func setupServiceDescriptionTextView() {
        view.addSubview(serviceDescription)
        serviceDescription.topAnchor.constraint(equalTo: serviceTitleLabel.bottomAnchor, constant: 16).isActive = true
        serviceDescription.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16).isActive = true
        serviceDescription.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16).isActive = true
        serviceDescription.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.2).isActive = true
    }
    
    func setupAddressTitleLabel() {
        view.addSubview(addressTitleLabel)
        addressTitleLabel.topAnchor.constraint(equalTo: serviceDescription.bottomAnchor, constant: 16).isActive = true
        addressTitleLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16).isActive = true
    }
    
    func setupAddressLabel() {
        view.addSubview(addressLabel)
        addressLabel.topAnchor.constraint(equalTo: addressTitleLabel.bottomAnchor, constant: 5).isActive = true
        addressLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16).isActive = true
    }
    
    func setupDateAndTimeTitleLabel() {
        view.addSubview(dateTimeTitleLabel)
        dateTimeTitleLabel.centerYAnchor.constraint(equalTo: addressTitleLabel.centerYAnchor).isActive = true
        dateTimeTitleLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16).isActive = true
    }
    
    func setupDateLabel() {
        view.addSubview(dateLabel)
        dateLabel.topAnchor.constraint(equalTo: dateTimeTitleLabel.bottomAnchor, constant: 5).isActive = true
        dateLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16).isActive = true
    }
    
    func setupTimeLabel() {
        view.addSubview(timeLabel)
        timeLabel.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 5).isActive = true
        timeLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16).isActive = true
    }
    
    func setupTableView() {
        view.addSubview(tableView)
        tableView.topAnchor.constraint(equalTo: timeLabel.bottomAnchor, constant: 16).isActive = true
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -5).isActive = true
        
    }
    
    @objc func rightBarButtonTapped() {
    
    }
    
    @objc func backTapped() {
        self.navigationController?.popViewController(animated: true)
    }
    
}

extension JobRequestListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as? JobRequestListTableViewCell {
            cell.serviceImageView.image = #imageLiteral(resourceName: "dummy")
            cell.titleText = "Service Title"
            cell.subTitleText = "Total Comleted Job: 40"
            cell.serviceChargeText = "AED 350"
            cell.numberOfReviewText = "(10 Reviews)"
            return cell
        } else {
            let cell = tableView.cellForRow(at: indexPath)!
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       self.navigationController?.pushViewController(JobRequestDetails(), animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
}
