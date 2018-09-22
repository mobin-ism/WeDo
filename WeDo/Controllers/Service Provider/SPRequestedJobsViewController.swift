//
//  SPRequestedJobsViewController.swift
//  WeDo
//
//  Created by Tanvir Hasan Piash on 16/9/18.
//  Copyright © 2018 Creativeitem. All rights reserved.
//

import UIKit

class SPRequestedJobsViewController: UIViewController {
    
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
        layout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        Alert.checkInternetConnection(on: self)
        getServiceProviderDashboard()
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
        collectionView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
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
        DispatchQueue.main.async {
            let destination = SPRequestedJobDetailsViewController()
            destination.selectedIndex = indexPath.item
            destination.object = self.serviceProviderDashboardData
            self.present(destination, animated: true, completion: nil)
        }
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
