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
        layout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        Alert.checkInternetConnection(on: self)
        getServices()
    }
    
    func layout() {
        setupBackgroundImageView()
        setupTableView()
    }
    
    func setupBackgroundImageView() {
        view.addSubview(backgroundImageView)
        backgroundImageView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        backgroundImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 25).isActive = true
        backgroundImageView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.5).isActive = true
        backgroundImageView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8).isActive = true
    }
    
    func setupTableView() {
        view.addSubview(tableView)
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
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
