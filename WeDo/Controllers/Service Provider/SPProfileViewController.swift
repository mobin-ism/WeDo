//
//  SPProfileViewController.swift
//  WeDo
//
//  Created by Tanvir Hasan Piash on 20/9/18.
//  Copyright © 2018 Creativeitem. All rights reserved.
//

import UIKit

class SPProfileViewController: UIViewController {
    
    let backgroundImageView : UIImageView = {
        var imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .clear
        imageView.image = #imageLiteral(resourceName: "bigger-logo")
        return imageView
    }()
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.backgroundColor = UIColor.clear
        view.showsVerticalScrollIndicator = false
        view.alwaysBounceVertical = true
        view.delegate = self
        view.dataSource = self
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var menu: Menu = {
        let slideMenu = Menu()
        slideMenu.spProfileVC = self
        return slideMenu
    }()
    
    let items = ["Basic Information".localized(), "Service Information".localized(), "Service History".localized(), "Account".localized()]
    var spProfileData: SPProfileModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        setNavigationBar()
        collectionView.register(SPProfileItemCell.self, forCellWithReuseIdentifier: SPProfileItemCell.cellId)
        layout()
        getServiceProviderProfile()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        Alert.checkInternetConnection(on: self)
    }
    
    private func layout() {
        setupBackgroundImageView()
        setupCollectionView()
    }
    
    func setupBackgroundImageView() {
        view.addSubview(backgroundImageView)
        backgroundImageView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        backgroundImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 25).isActive = true
        backgroundImageView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.5).isActive = true
        backgroundImageView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8).isActive = true
    }
    
    func setupCollectionView() {
        view.addSubview(collectionView)
        collectionView.topAnchor.constraint(equalTo: view.topAnchor, constant: 100).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
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
    
    public func selectedViewControllerFromMenu(indexNumber : Int) {
        if  UserDefaults.standard.value(forKey: IS_SERVICE_PROVIDER) as! Bool == true {
            switch indexNumber {
            case 0:
                self.navigationController?.pushViewController(SPHomeViewController(), animated: true)
            case 1:
                self.navigationController?.pushViewController(SPCurrentJobsViewController(), animated: true)
            case 2:
                print("current page")
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

extension SPProfileViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SPProfileItemCell.cellId, for: indexPath) as! SPProfileItemCell
        cell.setupCell(title: items[indexPath.item])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch indexPath.item {
        case 0:
            let destination = SPBasicInformationViewController()
            destination.object = spProfileData
            navigationController?.pushViewController(destination, animated: true)
        case 1:
            break
        case 2:
            navigationController?.pushViewController(SPServiceHistoryViewController(), animated: true)
        case 3:
            navigationController?.pushViewController(SPAccountViewController(), animated: true)
        default:
            print("undefined index")
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 50)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
}

extension SPProfileViewController {
    
    func getServiceProviderProfile() {
        let id = UserDefaults.standard.value(forKey: SERVICE_PROVIDER_ID) as! Int
        guard let url = URL(string: "\(BASE_URL)api/v2/agent/profile/\(id)") else { return }
        HTTPRequestHandler.makeGetHttpRequest(url: url, parameter: [:]) { (response, error) in
            guard let response = response else { return }
            if let json = response.data {
                let decoder = JSONDecoder()
                do {
                    let profileData = try decoder.decode(SPProfileModel.self, from: json)
                    self.spProfileData = profileData
                } catch let err {
                    print(err)
                }
            }
        }
    }
    
}
