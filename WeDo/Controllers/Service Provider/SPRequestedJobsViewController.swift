//
//  SPRequestedJobsViewController.swift
//  WeDo
//
//  Created by Tanvir Hasan Piash on 16/9/18.
//  Copyright © 2018 Creativeitem. All rights reserved.
//

import UIKit

class SPRequestedJobsViewController: UIViewController {
    
    lazy var menu: Menu = {
        let slideMenu = Menu()
        slideMenu.spRequestedJobsVC = self
        return slideMenu
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
    
    lazy var currentJobsButton : UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.clipsToBounds = true
        button.backgroundColor = UIColor(red:64/255, green:173/255, blue:93/255, alpha:0.9)
        button.setTitle("Current Jobs".localized(), for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = UIFont(name: OPENSANS_REGULAR, size: 12)
        button.tag = 1
        button.addTarget(self, action: #selector(navigationButtonTapped( _:)), for: .touchUpInside)
        return button
    }()
    
    lazy var newJobsButton : UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.clipsToBounds = true
        button.backgroundColor = UIColor(red:64/255, green:173/255, blue:93/255, alpha:0.9)
        button.setTitle("New Jobs".localized(), for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = UIFont(name: OPENSANS_REGULAR, size: 12)
        button.tag = 2
        button.addTarget(self, action: #selector(navigationButtonTapped( _:)), for: .touchUpInside)
        return button
    }()
    
    lazy var requestedJobsButton : UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.clipsToBounds = true
        button.backgroundColor = UIColor(red:64/255, green:173/255, blue:93/255, alpha:0.9)
        button.setTitle("Requested Jobs".localized(), for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = UIFont(name: OPENSANS_REGULAR, size: 12)
        button.tag = 3
        button.addTarget(self, action: #selector(navigationButtonTapped( _:)), for: .touchUpInside)
        return button
    }()
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.backgroundColor = UIColor.clear
        view.showsVerticalScrollIndicator = false
        view.alwaysBounceVertical = true
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        view.delegate = self
        view.dataSource = self
        return view
    }()
    
    var serviceProviderDashboardData: SPDashboardModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        collectionView.register(SPJobCell.self, forCellWithReuseIdentifier: SPJobCell.cellId)
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
        getServiceProviderDashboard()
    }
    
    override func viewDidLayoutSubviews() {
        requestedJobsButton.titleLabel?.font = UIFont(name: OPENSANS_BOLD, size: 12)
    }
    
    private func layout() {
        setupBackgroundImageView()
        setupCurrentJobsButton()
        setupNewJobsButton()
        setupRequestedJobsButton()
        setupCollectionView()
    }
    
    func setupBackgroundImageView() {
        view.addSubview(backgroundImageView)
        backgroundImageView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        backgroundImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 25).isActive = true
        backgroundImageView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.5).isActive = true
        backgroundImageView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8).isActive = true
    }
    
    func setupCurrentJobsButton() {
        view.addSubview(currentJobsButton)
        currentJobsButton.topAnchor.constraint(equalTo: view.topAnchor, constant: Helper.barHeight+(self.navigationController?.navigationBar.frame.size.height)!).isActive = true
        currentJobsButton.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        currentJobsButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        currentJobsButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.33).isActive = true
    }
    
    func setupNewJobsButton() {
        view.addSubview(newJobsButton)
        newJobsButton.topAnchor.constraint(equalTo: currentJobsButton.topAnchor).isActive = true
        newJobsButton.leadingAnchor.constraint(equalTo: currentJobsButton.trailingAnchor).isActive = true
        newJobsButton.heightAnchor.constraint(equalTo: currentJobsButton.heightAnchor).isActive = true
        newJobsButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.33).isActive = true
    }
    
    func setupRequestedJobsButton() {
        view.addSubview(requestedJobsButton)
        requestedJobsButton.topAnchor.constraint(equalTo: currentJobsButton.topAnchor).isActive = true
        requestedJobsButton.leadingAnchor.constraint(equalTo: newJobsButton.trailingAnchor).isActive = true
        requestedJobsButton.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        requestedJobsButton.heightAnchor.constraint(equalTo: currentJobsButton.heightAnchor).isActive = true
    }
    
    func setupCollectionView() {
        view.addSubview(collectionView)
        collectionView.topAnchor.constraint(equalTo: currentJobsButton.bottomAnchor).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    @objc private func menuIconTapped() {
        self.menu.show(self)
    }
    
    @objc private func navigationButtonTapped(_ sender: UIButton) {
        switch sender.tag {
        case 1:
            navigationController?.pushViewController(SPCurrentJobsViewController(), animated: false)
        case 2:
            navigationController?.pushViewController(SPNewJobsViewController(), animated: false)
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
        }
    }
    
}

extension SPRequestedJobsViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let serviceProviderDashboardData = serviceProviderDashboardData else { return 0 }
        return serviceProviderDashboardData.data.jobRequestList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SPJobCell.cellId, for: indexPath) as? SPJobCell else {
            let cell = UICollectionViewCell()
            return cell
        }
        if let data = serviceProviderDashboardData {
            cell.setupData(url: data.data.jobRequestList[indexPath.item].serviceIcon.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!, title: data.data.jobRequestList[indexPath.item].serviceTitle, address: data.data.jobRequestList[indexPath.item].area ?? "", date: data.data.jobRequestList[indexPath.item].startDateTime)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let destination = SPRequestedJobDetailsViewController()
        destination.selectedIndex = indexPath.item
        destination.object = self.serviceProviderDashboardData
        navigationController?.pushViewController(destination, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width
        return CGSize(width: width, height: 100)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
}

extension SPRequestedJobsViewController {
    
    func getServiceProviderDashboard() {
        let id = UserDefaults.standard.value(forKey: SERVICE_PROVIDER_ID) as! Int
        guard let url = URL(string: "\(BASE_URL)api/v2/agent/dashboard/\(id)") else { return }
        HTTPRequestHandler.makeGetHttpRequest(url: url, parameter: [:]) { (response, error) in
            guard let response = response else { return }
            if let json = response.data {
                let decoder = JSONDecoder()
                do {
                    let dashboardData = try decoder.decode(SPDashboardModel.self, from: json)
                    self.serviceProviderDashboardData = dashboardData
                    self.collectionView.reloadData()
                } catch let err {
                    print(err)
                }
            }
        }
    }
    
}
