//
//  HomeViewController.swift
//  WeDo
//
//  Created by Creativeitem on 17/7/18.
//  Copyright © 2018 Creativeitem. All rights reserved.
//

import UIKit
class HomeViewController: UIViewController {
    
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
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    private func layout() {
        setSlider()
        setCollectionView()
        setupActivityIndicator()
    }
    
    private func setNavigationBar() {
        navigationController?.navigationBar.barTintColor = NAVBAR_BG_COLOR
        let logo = UIImage(named: "logo.png")
        let imageView = UIImageView(image:logo)
        self.navigationItem.titleView = imageView
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "menu"), style: .plain, target: self, action: #selector(menuIconTapped))
    }
    
    private func setSlider() {
        view.addSubview(slider)
        slider.topAnchor.constraint(equalTo: view.topAnchor, constant: 80).isActive = true
        slider.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        slider.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        if Helper.isIphoneX {
            slider.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.25).isActive = true
        } else {
            slider.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.3).isActive = true
        }
    }
    
    private func setCollectionView() {
        view.addSubview(collectionView)
        collectionView.topAnchor.constraint(equalTo: slider.bottomAnchor, constant: 16).isActive = true
        collectionView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16).isActive = true
        collectionView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    private func setupActivityIndicator(){
        view.addSubview(activityIndicator)
        activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    
    @objc func menuIconTapped() {
        self.menu.show()
    }
}

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 12
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: serviceCellId, for: indexPath) as? ServiceCell else {
            let cell = collectionView.cellForItem(at: indexPath)!
            return cell
        }
        cell.mainImage = #imageLiteral(resourceName: "dummy2")
        cell.mainText = "Dummy"
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.navigationController?.pushViewController(AllServicesListViewController(), animated: true)
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
