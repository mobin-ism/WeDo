//
//  AllServicesListViewController.swift
//  WeDo
//
//  Created by Creativeitem on 18/7/18.
//  Copyright © 2018 Creativeitem. All rights reserved.
//

import UIKit
class AllServicesListViewController: UIViewController {
    
    let verticalCellID = "AllServicesCell"
    let horizontalCellID = "serviceTypesCell"
    
    lazy var verticalCollectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        
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
        return collection
    }()
    
    lazy var menu: Menu = {
        let slideMenu = Menu()
        slideMenu.allServicesListController = self
        return slideMenu
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red:0.98, green:0.98, blue:0.98, alpha:1.0)
        verticalCollectionView.register(AllServicesListCollectionViewCell.self, forCellWithReuseIdentifier: verticalCellID)
        horizontalCollectionView.register(HorizontalCollectionViewCell.self, forCellWithReuseIdentifier: horizontalCellID)
        layout()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNavigationBar()
    }
    private func setNavigationBar() {
        navigationController?.navigationBar.barTintColor = NAVBAR_BG_COLOR
        let logo = UIImage(named: "logo.png")
        let imageView = UIImageView(image:logo)
        self.navigationItem.titleView = imageView
        //navigationItem.leftBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "menu"), style: .plain, target: self, action: #selector(menuIconTapped))
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "back-icon"), style: .plain, target: self, action: #selector(backTapped))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "All Services", style: .plain, target: self, action: #selector(allServicesButtonTapped))
        self.navigationItem.rightBarButtonItem?.tintColor = UIColor.white
    }
    
    func layout() {
        setupHorizontalCollectionView()
        setupVerticalCollectionView()
    }
    
    func setupHorizontalCollectionView() {
        view.addSubview(horizontalCollectionView)
        horizontalCollectionView.topAnchor.constraint(equalTo: view.topAnchor, constant: 30).isActive = true
        horizontalCollectionView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10).isActive = true
        horizontalCollectionView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10).isActive = true
        horizontalCollectionView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.3).isActive = true
    }
    
    func setupVerticalCollectionView() {
        view.addSubview(verticalCollectionView)
        verticalCollectionView.topAnchor.constraint(equalTo: horizontalCollectionView.bottomAnchor, constant: 20).isActive = true
        verticalCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -10).isActive = true
        verticalCollectionView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        verticalCollectionView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
    }
    
    @objc func menuIconTapped() {
        self.menu.show()
    }
    
    @objc func backTapped() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func allServicesButtonTapped() {
        
    }
}

extension AllServicesListViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if  collectionView == self.verticalCollectionView {
            return 12
        }
        else {
            return 6
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == self.verticalCollectionView {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: verticalCellID, for: indexPath) as? AllServicesListCollectionViewCell else {
                let cell = collectionView.cellForItem(at: indexPath)!
                return cell
            }
            cell.mainImage = #imageLiteral(resourceName: "dummy2")
            cell.mainText = "Dummy"
            return cell
        }
        else {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: horizontalCellID, for: indexPath) as? HorizontalCollectionViewCell else {
                let cell = collectionView.cellForItem(at: indexPath)!
                return cell
            }
            cell.mainImage = #imageLiteral(resourceName: "dummy2")
            cell.mainText = "Dummy"
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == self.verticalCollectionView {
            self.navigationController?.pushViewController(ServiceDescriptionOneViewController(), animated: true)
        }
        else {
            
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
            return 0
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
