//
//  SPServiceHistoryViewController.swift
//  WeDo
//
//  Created by Tanvir Hasan Piash on 21/9/18.
//  Copyright © 2018 Creativeitem. All rights reserved.
//

import UIKit

class SPServiceHistoryViewController: UIViewController {
    
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
    
    var object: SPServiceHistoryModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        collectionView.register(SPJobCell.self, forCellWithReuseIdentifier: SPJobCell.cellId)
        setNavigationBar()
        layout()
        getServiceHistory()
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
    
    @objc private func backTapped() {
        navigationController?.popViewController(animated: true)
    }
    
}

extension SPServiceHistoryViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let object = object else { return 0 }
        return object.data.jobHistory.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SPJobCell.cellId, for: indexPath) as? SPJobCell else {
            let cell = UICollectionViewCell()
            return cell
        }
        if let object = object {
            let imageUrl = object.data.jobHistory[indexPath.item].serviceIcon.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!
            let title = object.data.jobHistory[indexPath.item].serviceTitle
            let address = object.data.jobHistory[indexPath.item].area ?? ""
            let date = object.data.jobHistory[indexPath.item].startDateTime
            cell.setupData(url: imageUrl, title: title, address: address, date: date)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let destination = SPServiceHistoryDetailsViewController()
        destination.selectedIndex = indexPath.item
        destination.object = object
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

extension SPServiceHistoryViewController {
    
    func getServiceHistory() {
        let id = UserDefaults.standard.value(forKey: SERVICE_PROVIDER_ID) as! Int
        guard let url = URL(string: "\(BASE_URL)api/v2/agent/job/history/\(id)") else { return }
        HTTPRequestHandler.makeGetHttpRequest(url: url, parameter: [:]) { (response, error) in
            guard let response = response else { return }
            if let json = response.data {
                let decoder = JSONDecoder()
                do {
                    let data = try decoder.decode(SPServiceHistoryModel.self, from: json)
                    self.object = data
                    self.collectionView.reloadData()
                } catch let err {
                    print(err.localizedDescription)
                }
            }
        }
    }
    
}
