//
//  ServiceDetailsViewController.swift
//  WeDo
//
//  Created by Creativeitem on 18/7/18.
//  Copyright © 2018 Creativeitem. All rights reserved.
//

import UIKit
class ServiceDetailsViewController: UIViewController {
    
    lazy var serviceIconImageView : UIImageView = {
        var imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .clear
        imageView.image = #imageLiteral(resourceName: "dummy2")
        return imageView
    }()
    
    lazy var serviceTitle : UILabel = {
       var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.clipsToBounds = true
        label.textAlignment = .left
        label.text = "Cleaning"
        label.numberOfLines = 0
        label.textColor = UIColor.white
        return label
    }()
    
    lazy var serviceSubTitle : UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.clipsToBounds = true
        label.textAlignment = .left
        label.text = "Full House Cleaning"
        label.numberOfLines = 0
        label.textColor = UIColor.white
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
    let cellId = "serviceDetailsCell"
    let subServices = ["1 Bed Room", "2 Bed Room", "3 Bed Room"]
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        setNavigationBar()
        layout()
        
        tableView.register(ServiceDetailsCell.self, forCellReuseIdentifier: cellId)
    }
    
    private func setNavigationBar() {
        navigationController?.navigationBar.barTintColor = NAVBAR_BG_COLOR
        let logo = UIImage(named: "logo.png")
        let imageView = UIImageView(image:logo)
        self.navigationItem.titleView = imageView
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "back-icon"), style: .plain, target: self, action: #selector(backTapped))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Full Hosue Cleaning", style: .plain, target: self, action: #selector(rightBarButtonTapped))
        self.navigationItem.rightBarButtonItem?.tintColor = UIColor.white
    }
    
    func layout() {
        setupTableView()
    }
    
    func setupTableView() {
        view.addSubview(tableView)
        tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 40).isActive = true
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        tableView.heightAnchor.constraint(equalToConstant: 500).isActive = true
    }
    
    @objc func rightBarButtonTapped() {
        
    }
    
    @objc func backTapped() {
     self.navigationController?.popViewController(animated: true)
    }
}

extension ServiceDetailsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return subServices.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as? ServiceDetailsCell {
            cell.titleText = subServices[indexPath.row]
            cell.priceText = "101 AED"
            return cell
        } else {
            let cell = tableView.cellForRow(at: indexPath)!
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.frame.height * 0.15
    }
    
}
