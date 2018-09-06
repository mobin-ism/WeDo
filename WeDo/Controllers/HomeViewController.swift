//
//  HomeViewController.swift
//  WeDo
//
//  Created by Creativeitem on 17/7/18.
//  Copyright © 2018 Creativeitem. All rights reserved.
//

import UIKit
import BouncyLayout
import LIHImageSlider
import Alamofire
import SVProgressHUD
class HomeViewController: UIViewController {
    
    var listOfServices = [NSObject]()
    
    let bouncyLayout = BouncyLayout()
    var sliderVc1 : UIViewController!
    
    var sliderImages = [SliderImages]()
    lazy var slider: Slider = {
        let slider = Slider()
        return slider
    }()
    
    lazy var menu: Menu = {
        let slideMenu = Menu()
        slideMenu.homeController = self
        return slideMenu
    }()
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        //let collection = UICollectionView(frame: .zero, collectionViewLayout: bouncyLayout)
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.backgroundColor = UIColor.clear
        collection.alwaysBounceVertical = true
        collection.showsVerticalScrollIndicator = false
        collection.delegate = self
        collection.dataSource = self
        collection.clipsToBounds = true
        collection.translatesAutoresizingMaskIntoConstraints = false
        return collection
    }()
    
    let activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        indicator.activityIndicatorViewStyle = .gray
        indicator.clipsToBounds = true
        indicator.hidesWhenStopped = true
        indicator.translatesAutoresizingMaskIntoConstraints = false
        return indicator
    }()
    
    let serviceCellId = "ServiceCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        setNavigationBar()
        
        collectionView.register(ServiceCell.self, forCellWithReuseIdentifier: serviceCellId)
        for _ in 1...5 {
            let image = SliderImages(image: "dummy")
            sliderImages.append(image)
        }
        slider.dataSource = sliderImages
        self.layout()
        
        // API CALL
        if !Helper.Exists(key: AREA_ID) {
            self.selectAnAreaByDefaultForTheFirstTime()
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        Alert.checkInternetConnection(on: self)
        
        // API Call
        self.getServices()
    }
    
    
    private func layout() {
        /*setSlider()*/
        setLHIImageSlider()
        setCollectionView()
        setupActivityIndicator()
    }
    
    private func setNavigationBar() {
        navigationController?.navigationBar.barTintColor = NAVBAR_BG_COLOR
        let logo = UIImage(named: "logo.png")
        let imageView = UIImageView(image:logo)
        self.navigationItem.titleView = imageView
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "menu"), style: .plain, target: self, action: #selector(menuIconTapped))
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "settings"), style: .plain, target: self, action: #selector(customerSettings))
    }
    
    public func selectedViewControllerFromMenu(indexNumber : Int) {
        if  UserDefaults.standard.value(forKey: IS_LOGGED_IN) as! Bool {
            switch indexNumber {
            case 0:
                print("Current View Controller")
            case 1:
                self.navigationController?.pushViewController(ActiveOrderViewController(), animated: true)
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
                print("Current View Controller")
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
    
    private func setSlider() {
        view.addSubview(slider)
        if Helper.isIphoneX {
            slider.topAnchor.constraint(equalTo: view.topAnchor, constant: 100).isActive = true
        } else {
            slider.topAnchor.constraint(equalTo: view.topAnchor, constant: 80).isActive = true
        }
        
        slider.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        slider.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        if Helper.isIphoneX {
            slider.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.25).isActive = true
        } else {
            slider.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.3).isActive = true
        }
    }
    
    func setLHIImageSlider() {
        let y : CGFloat = Helper.barHeight + (self.navigationController?.navigationBar.frame.height)!
        let sliderHeight : CGFloat!
        
        if Helper.isIphoneX {
            sliderHeight = self.view.frame.height * 0.25
        } else {
            sliderHeight = self.view.frame.height * 0.3
        }
        
        let images: [UIImage] = [#imageLiteral(resourceName: "house-1"), #imageLiteral(resourceName: "house-2"), #imageLiteral(resourceName: "house-3"), #imageLiteral(resourceName: "house-4")]
        let slider1: LIHSlider = LIHSlider(images: images)
        
        // title for images
        /*slider1.sliderDescriptions = ["God Be Praised", "God Be Praised", "God Be Praised"]*/
        
        self.sliderVc1  = LIHSliderViewController(slider: slider1)
        self.addChildViewController(self.sliderVc1)
        self.view.addSubview(self.sliderVc1.view)
        self.sliderVc1.didMove(toParentViewController: self)
        self.sliderVc1.view.frame = CGRect(x: 0, y: y, width: self.view.frame.width, height: sliderHeight)
        
    }
    
    private func setCollectionView() {
        view.addSubview(collectionView)
        /*collectionView.topAnchor.constraint(equalTo: slider.bottomAnchor, constant: 16).isActive = true*/
        collectionView.topAnchor.constraint(equalTo: self.sliderVc1.view.bottomAnchor, constant: 16).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    private func setupActivityIndicator(){
        view.addSubview(activityIndicator)
        activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    
    @objc func menuIconTapped() {
        self.menu.show(self)
    }
    
    @objc func customerSettings() {
        self.navigationController?.pushViewController(CustomerSettingsViewController(), animated: false)
    }
}

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.listOfServices.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: serviceCellId, for: indexPath) as? ServiceCell else {
            let cell = collectionView.cellForItem(at: indexPath)!
            return cell
        }
        if let data = listOfServices as? [ServicesNSObject] {
            cell.imageView.sd_setImage(with: URL(string: data[indexPath.row].serviceIconRegular), placeholderImage: #imageLiteral(resourceName: "cloud-download"), options: [.continueInBackground], completed: nil)
            cell.mainText = "\(data[indexPath.row].serviceTitle)"
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let allServicesListOBJ = AllServicesListViewController()
        if let data = self.listOfServices as? [ServicesNSObject]{
            UserDefaults.standard.set(data[indexPath.row].serviceId, forKey: PARENT_SERVICE_ID)
            allServicesListOBJ.serviceParentId = data[indexPath.row].serviceId
            allServicesListOBJ.selectedIndexPath = indexPath.item
            self.navigationController?.pushViewController(allServicesListOBJ, animated: true)
        }
    }
}

extension HomeViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width: CGFloat = collectionView.frame.width / 3 - 16
        let height: CGFloat = width
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
}

// API CALLS
extension HomeViewController {
    func getServices() {
        guard let url = URL(string: "\(BASE_URL)api/v2/general/services?id=8&language=\(UserDefaults.standard.value(forKey: LANGUAGE) as! String)") else { return }
            
        HTTPRequestHandler.makeGetHttpRequest(url: url, parameter: [:]) { (response, nil) in
            guard let response = response else { return }
            
            if !self.listOfServices.isEmpty {
                self.listOfServices.removeAll()
            }
            
            if let json = response.data {
                let decoder = JSONDecoder()
                do {
                    let serviceList = try decoder.decode(Services.self, from: json)
                    for service in serviceList.services {
                        let container = ServicesNSObject(serviceId: service.id, serviceTtile: service.title, serviceIconRegular: service.smallIconOne.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!, serviceIconWhite: service.smallIconTwo.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!)
                        self.listOfServices.append(container)
                    }
                    
                    self.collectionView.reloadData()
                }catch let err {
                    print(err)
                }
            }
        }
    }
    
    func selectAnAreaByDefaultForTheFirstTime() {
        var isFirst = true
        guard let url = URL(string: "\(BASE_URL)api/v2/city?language=\(UserDefaults.standard.value(forKey: LANGUAGE) as! String)") else { return }
        HTTPRequestHandler.makeGetHttpRequest(url: url, parameter: [:]) { (response, nil) in
            guard let response = response else { return }
            
            if let json = response.data {
                let decoder = JSONDecoder()
                do {
                    let areaList = try decoder.decode(Area.self, from: json)
                    for area in areaList.data.city {
                        if isFirst {
                            UserDefaults.standard.set(area.id, forKey: AREA_ID)
                            UserDefaults.standard.set(area.name, forKey: AREA)
                        }
                        isFirst = false
                    }
                }catch let err {
                    print(err)
                }
            }
        }
    }
}
