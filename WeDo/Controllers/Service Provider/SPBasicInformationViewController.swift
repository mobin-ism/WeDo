//
//  SPBasicInformationViewController.swift
//  WeDo
//
//  Created by Tanvir Hasan Piash on 21/9/18.
//  Copyright © 2018 Creativeitem. All rights reserved.
//

import UIKit
import SDWebImage

class SPBasicInformationViewController: UIViewController {
    
    let backgroundImageView : UIImageView = {
        var imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .clear
        imageView.image = #imageLiteral(resourceName: "bigger-logo")
        return imageView
    }()
    
    lazy var scrollView: UIScrollView = {
        let scroll = UIScrollView(frame: .zero)
        scroll.keyboardDismissMode = .interactive
        scroll.backgroundColor = UIColor.clear
        scroll.delegate = self
        scroll.translatesAutoresizingMaskIntoConstraints = false
        scroll.isUserInteractionEnabled = true
        scroll.isScrollEnabled = true
        scroll.showsVerticalScrollIndicator = true
        return scroll
    }()
    
    let view1: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 5
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.init(white: 0.9, alpha: 0.9).cgColor
        view.backgroundColor = UIColor.clear
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let view2: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 5
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.init(white: 0.9, alpha: 0.9).cgColor
        view.backgroundColor = UIColor.clear
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let view3: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 5
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.init(white: 0.9, alpha: 0.9).cgColor
        view.backgroundColor = UIColor.clear
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let topImageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.backgroundColor = UIColor.clear
        view.showsVerticalScrollIndicator = false
        view.alwaysBounceVertical = false
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        view.delegate = self
        view.dataSource = self
        return view
    }()
    
    let title2: UILabel = {
        let label = UILabel()
        label.text = "Average Rating".localized()
        label.textAlignment = .center
        label.textColor = UIColor.black
        label.font = UIFont(name: OPENSANS_REGULAR, size: 12)
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let title3: UILabel = {
        let label = UILabel()
        label.text = "Total Job Done".localized()
        label.textAlignment = .center
        label.textColor = UIColor.black
        label.font = UIFont(name: OPENSANS_REGULAR, size: 12)
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let value2: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = GREENISH_COLOR
        label.font = UIFont(name: OPENSANS_BOLD, size: 18)
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let value3: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = GREENISH_COLOR
        label.font = UIFont(name: OPENSANS_BOLD, size: 18)
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let reviewsLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = UIColor.lightGray
        label.font = UIFont(name: OPENSANS_REGULAR, size: 11)
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let items = ["Company name".localized(), "Phone no.".localized(), "Email".localized(), "Address".localized()]
    var itemValues = [String]()
    var object: SPProfileModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        setNavigationBar()
        collectionView.register(SPCustomerDetailCell.self, forCellWithReuseIdentifier: SPCustomerDetailCell.cellId)
        layout()
        setupData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        Alert.checkInternetConnection(on: self)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        view.layoutIfNeeded()
        var contentHeight: CGFloat = 0
        for view in scrollView.subviews {
            contentHeight = contentHeight + view.frame.size.height
        }
        scrollView.contentSize = CGSize(width: view.frame.width, height: contentHeight + 60)
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
        setupScrollView()
        setupView1()
        setupView2()
        setupView3()
        setupTopImageView()
        setupCollectionView()
        setupTitle2()
        setupTitle3()
        setupValue2()
        setupValue3()
        setupReviewsLabel()
    }
    
    func setupData() {
        guard let object = object else { return }
        topImageView.sd_setImage(with: URL(string: object.data.basicInformation.companyLogo.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!), placeholderImage: #imageLiteral(resourceName: "cloud-download"))
        itemValues = [object.data.basicInformation.companyName, object.data.basicInformation.phoneNumber, object.data.basicInformation.companyEmail, object.data.basicInformation.companyAddress]
        collectionView.reloadData()
        value2.text = "\(object.data.basicInformation.rating)"
        value3.text = "\(object.data.basicInformation.totalJobDone)"
        reviewsLabel.text = "(\(object.data.basicInformation.totalReviews) Reviews)"
    }
    
    func setupBackgroundImageView() {
        view.addSubview(backgroundImageView)
        backgroundImageView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        backgroundImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 25).isActive = true
        backgroundImageView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.5).isActive = true
        backgroundImageView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8).isActive = true
    }
    
    func setupScrollView() {
        view.addSubview(scrollView)
        scrollView.topAnchor.constraint(equalTo: view.topAnchor, constant: 100).isActive = true
        scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    func setupView1() {
        scrollView.addSubview(view1)
        view1.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        view1.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
        view1.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 60).isActive = true
        view1.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.4).isActive = true
    }
    
    func setupView2() {
        scrollView.addSubview(view2)
        view2.topAnchor.constraint(equalTo: view1.bottomAnchor, constant: 16).isActive = true
        view2.leadingAnchor.constraint(equalTo: view1.leadingAnchor, constant: 16).isActive = true
        view2.widthAnchor.constraint(equalTo: view1.widthAnchor, multiplier: 0.43).isActive = true
        view2.heightAnchor.constraint(equalTo: view1.widthAnchor, multiplier: 0.43).isActive = true
    }
    
    func setupView3() {
        scrollView.addSubview(view3)
        view3.topAnchor.constraint(equalTo: view2.topAnchor).isActive = true
        view3.trailingAnchor.constraint(equalTo: view1.trailingAnchor, constant: -16).isActive = true
        view3.widthAnchor.constraint(equalTo: view1.widthAnchor, multiplier: 0.43).isActive = true
        view3.heightAnchor.constraint(equalTo: view1.widthAnchor, multiplier: 0.43).isActive = true
    }
    
    func setupTopImageView() {
        scrollView.addSubview(topImageView)
        topImageView.centerYAnchor.constraint(equalTo: view1.topAnchor).isActive = true
        topImageView.centerXAnchor.constraint(equalTo: view1.centerXAnchor).isActive = true
        topImageView.widthAnchor.constraint(equalTo: view1.widthAnchor, multiplier: 0.3).isActive = true
        topImageView.heightAnchor.constraint(equalTo: view1.widthAnchor, multiplier: 0.3).isActive = true
    }
    
    func setupCollectionView() {
        view1.addSubview(collectionView)
        collectionView.leadingAnchor.constraint(equalTo: view1.leadingAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: view1.trailingAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view1.bottomAnchor).isActive = true
        collectionView.topAnchor.constraint(equalTo: topImageView.bottomAnchor, constant: 24).isActive = true
        
    }
    
    func setupTitle2() {
        view2.addSubview(title2)
        title2.centerXAnchor.constraint(equalTo: view2.centerXAnchor).isActive = true
        title2.topAnchor.constraint(equalTo: view2.topAnchor, constant: 24).isActive = true
    }
    
    func setupTitle3() {
        view3.addSubview(title3)
        title3.centerXAnchor.constraint(equalTo: view3.centerXAnchor).isActive = true
        title3.centerYAnchor.constraint(equalTo: view3.centerYAnchor, constant: -20).isActive = true
    }
    
    func setupValue2() {
        view2.addSubview(value2)
        value2.centerXAnchor.constraint(equalTo: title2.centerXAnchor).isActive = true
        value2.topAnchor.constraint(equalTo: title2.bottomAnchor, constant: 8).isActive = true
    }
    
    func setupValue3() {
        view3.addSubview(value3)
        value3.centerXAnchor.constraint(equalTo: title3.centerXAnchor).isActive = true
        value3.topAnchor.constraint(equalTo: title3.bottomAnchor, constant: 8).isActive = true
    }
    
    func setupReviewsLabel() {
        view2.addSubview(reviewsLabel)
        reviewsLabel.centerXAnchor.constraint(equalTo: title2.centerXAnchor).isActive = true
        reviewsLabel.topAnchor.constraint(equalTo: value2.bottomAnchor, constant: 8).isActive = true
    }
    
    @objc private func backTapped() {
        navigationController?.popViewController(animated: true)
    }
    
}

extension SPBasicInformationViewController: UIScrollViewDelegate {
    
}

extension SPBasicInformationViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SPCustomerDetailCell.cellId, for: indexPath) as! SPCustomerDetailCell
        cell.setData(name: "\(items[indexPath.item]) : ", value: itemValues[indexPath.item])
        if indexPath.item == 3 {
            cell.divider.alpha = 0
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width
        let height = collectionView.frame.height / 4
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
}
