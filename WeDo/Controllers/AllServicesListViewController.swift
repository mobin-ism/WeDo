//
//  AllServicesListViewController.swift
//  WeDo
//
//  Created by Creativeitem on 18/7/18.
//  Copyright © 2018 Creativeitem. All rights reserved.
//

import UIKit
import BouncyLayout
import SDWebImage
class AllServicesListViewController: UIViewController {
    
    var serviceParentId : Int?
    var listOfSubServices = [NSObject]()
    var listOfServices = [NSObject]()
    var selectedIndexPath : Int?
    var skipOneViewController : Bool = false
    let bouncyLayout = BouncyLayout(style: BouncyLayout.BounceStyle.regular)
    let verticalCellID = "AllServicesCell"
    let horizontalCellID = "serviceTypesCell"
    let serviceDescriptionOne = ServiceDescriptionOneViewController()
    lazy var verticalCollectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        
        let collection = UICollectionView(frame: .zero, collectionViewLayout: bouncyLayout)
        collection.backgroundColor = UIColor.clear
        collection.alwaysBounceVertical = true
        collection.showsVerticalScrollIndicator = false
        collection.delegate = self
        collection.dataSource = self
        collection.clipsToBounds = true
        collection.translatesAutoresizingMaskIntoConstraints = false
        return collection
    }()
    
    lazy var horizontalCollectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.backgroundColor = UIColor(red:0.98, green:0.98, blue:0.98, alpha:1.0)
        collection.alwaysBounceHorizontal = true
        collection.showsHorizontalScrollIndicator = false
        collection.delegate = self
        collection.dataSource = self
        collection.clipsToBounds = true
        collection.translatesAutoresizingMaskIntoConstraints = false
        //collection.isPagingEnabled = true
        return collection
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red:0.98, green:0.98, blue:0.98, alpha:1.0)
        verticalCollectionView.register(AllServicesListCollectionViewCell.self, forCellWithReuseIdentifier: verticalCellID)
        horizontalCollectionView.register(HorizontalCollectionViewCell.self, forCellWithReuseIdentifier: horizontalCellID)
        setNavigationBar()
        layout()
        
        self.makeDefaultInputOnUserDefaults()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        Alert.checkInternetConnection(on: self)
        
        if let serviceParentId = self.serviceParentId {
            self.getSubServices(serviceParentId: serviceParentId)
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        guard let selectedIndexPath = self.selectedIndexPath else { return }
        let indexPath = IndexPath(item: selectedIndexPath, section: 0)
        print(indexPath)
        //self.horizontalCollectionView.scrollToItem(at: indexPath, at: .right, animated: true)
    }
    
    private func setNavigationBar() {
        navigationController?.navigationBar.barTintColor = NAVBAR_BG_COLOR
        let logo = UIImage(named: "logo.png")
        let imageView = UIImageView(image:logo)
        self.navigationItem.titleView = imageView
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "back-icon"), style: .plain, target: self, action: #selector(backTapped))
    }
    
    func layout() {
        setupHorizontalCollectionView()
        setupVerticalCollectionView()
    }
    
    func setupHorizontalCollectionView() {
        view.addSubview(horizontalCollectionView)
        horizontalCollectionView.topAnchor.constraint(equalTo: view.topAnchor, constant: 30).isActive = true
        horizontalCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive = true
        horizontalCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10).isActive = true
        horizontalCollectionView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.3).isActive = true
    }
    
    func setupVerticalCollectionView() {
        view.addSubview(verticalCollectionView)
        verticalCollectionView.topAnchor.constraint(equalTo: horizontalCollectionView.bottomAnchor, constant: 20).isActive = true
        verticalCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -10).isActive = true
        verticalCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        verticalCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    }
    
    @objc func backTapped() {
        self.navigationController?.popViewController(animated: true)
    }
    
    func makeDefaultInputOnUserDefaults() {
        UserDefaults.standard.set("", forKey: DESCRIPTION)
        UserDefaults.standard.set(0.0, forKey: MARKED_LATITUDE)
        UserDefaults.standard.set(0.0, forKey: MARKED_LONGITUDE)
        UserDefaults.standard.set("", forKey: EXTRA_DIRECTION)
        UserDefaults.standard.set("", forKey: APARTMENT_NUMBER)
        UserDefaults.standard.set("", forKey: SELECTED_DATE)
        UserDefaults.standard.set("", forKey: SELECTED_TIME)
    }
}

extension AllServicesListViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if  collectionView == self.verticalCollectionView {
            return self.listOfSubServices.count
        }
        else {
            return self.listOfServices.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == self.verticalCollectionView {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: verticalCellID, for: indexPath) as? AllServicesListCollectionViewCell else {
                let cell = collectionView.cellForItem(at: indexPath)!
                return cell
            }
            if let data = self.listOfSubServices as? [SubServicesNSObject] {
                cell.imageView.sd_setImage(with: URL(string: data[indexPath.row].serviceIcon), placeholderImage: #imageLiteral(resourceName: "cloud-download"), options: [.continueInBackground], completed: nil)
                cell.mainText = data[indexPath.row].serviceTitle
            }
            return cell
        }
        else {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: horizontalCellID, for: indexPath) as? HorizontalCollectionViewCell else {
                let cell = collectionView.cellForItem(at: indexPath)!
                return cell
            }
            
            if let data = listOfServices as? [ServicesNSObject] {
                if  self.serviceParentId == data[indexPath.row].serviceId {
                    cell.backgroundColor = GREENISH_COLOR
                    cell.imageView.sd_setImage(with: URL(string: data[indexPath.row].serviceIconWhite), placeholderImage: #imageLiteral(resourceName: "cloud-download"), options: [.continueInBackground], completed: nil)
                    cell.mainText = "\(data[indexPath.row].serviceTitle)"
                    cell.titleLabel.textColor = GREENISH_COLOR
                    cell.layer.cornerRadius = 4
                }else {
                    cell.imageView.sd_setImage(with: URL(string: data[indexPath.row].serviceIconRegular), placeholderImage: #imageLiteral(resourceName: "cloud-download"), options: [.continueInBackground], completed: nil)
                    cell.mainText = "\(data[indexPath.row].serviceTitle)"
                    cell.backgroundColor = .white
                    cell.titleLabel.textColor = .black
                    cell.layer.cornerRadius = 4
                }
            }
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == self.verticalCollectionView {
            if let data = self.listOfSubServices as? [SubServicesNSObject] {
                UserDefaults.standard.set(data[indexPath.row].subServiceId, forKey: SUB_SERVICE_ID)
                UserDefaults.standard.set(data[indexPath.row].serviceTitle, forKey: SUB_SERVICE_TITLE)
                self.checkSkipViewController(subServiceId: data[indexPath.row].subServiceId)
            }
        }
        else {
            if let data = self.listOfServices as? [ServicesNSObject] {
                UserDefaults.standard.set(data[indexPath.row].serviceId, forKey: PARENT_SERVICE_ID)
                self.serviceParentId = data[indexPath.row].serviceId
                self.getSubServices(serviceParentId: data[indexPath.row].serviceId)
            }
        }
    }
}

extension AllServicesListViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == self.verticalCollectionView {
            let width: CGFloat = collectionView.frame.width
            let height: CGFloat = 100
            return CGSize(width: width, height: height)
        }
        else {
            let width: CGFloat = collectionView.frame.width / 3 - 16
            let height: CGFloat = 100
            return CGSize(width: width, height: height)
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        if  collectionView == self.verticalCollectionView {
            return 10
        }
        else {
            return 10
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        if  collectionView == self.verticalCollectionView {
            return 0
        }
        else {
            return 10
        }
    }
}

// api calls
extension AllServicesListViewController {
    func getSubServices(serviceParentId : Int) {
        guard let serviceParentId = self.serviceParentId else { return }
        guard let url = URL(string: "\(BASE_URL)api/v2/general/services?id=8&language=\(UserDefaults.standard.value(forKey: LANGUAGE) as! String)") else { return }
        HTTPRequestHandler.makeGetHttpRequest(url: url, parameter: [:]) { (response, nil) in
            guard let response = response else { return }
            
            if !self.listOfServices.isEmpty {
                self.listOfServices.removeAll()
            }
            
            if !self.listOfSubServices.isEmpty {
                self.listOfSubServices.removeAll()
            }
        
            if let json = response.data {
                let decoder = JSONDecoder()
                do {
                    let serviceList = try decoder.decode(Services.self, from: json)
                    for service in serviceList.services {
                        let container = ServicesNSObject(serviceId: service.id, serviceTtile: service.title, serviceIconRegular: service.smallIconOne.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!, serviceIconWhite: service.smallIconTwo.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!)
                        self.listOfServices.append(container)
                        
                        if  serviceParentId == service.id {
                            for subService in service.child {
                                let container2 = SubServicesNSObject(subServiceId: subService.id, serviceTtile: subService.title, serviceIcon: subService.smallIconOne.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!)
                                self.listOfSubServices.append(container2)
                            }
                        }
                    }
                    self.verticalCollectionView.reloadData()
                    self.horizontalCollectionView.reloadData()
                } catch let err {
                    print(err)
                }
            }
        }
    }
    
    // check if we have skip one view controller
    func checkSkipViewController(subServiceId: Int){
        guard let url2 = URL(string: "\(BASE_URL)api/v2/general/child/sub/services/\(subServiceId)") else { return }
        HTTPRequestHandler.makeGetHttpRequest(url: url2, parameter: [:]) { (response, nil) in
            guard let response = response else { return }
            if let json = response.data {
                let decoder = JSONDecoder()
                do {
                    let subServiceDetailsList = try decoder.decode(SubServiceDetails.self, from: json)
                    if  subServiceDetailsList.data.services.count > 0 {
                        self.navigationController?.pushViewController(self.serviceDescriptionOne, animated: true)
                    }
                    else {
                        let serviceDescriptionTwoVC = ServiceDescriptionTwoViewController()
                        serviceDescriptionTwoVC.skipServiceOneViewController = true
                        self.navigationController?.pushViewController(serviceDescriptionTwoVC, animated: true)
                    }
                } catch let err {
                    print(err)
                }
            }
        }
    }
}
