//
//  SPServiceHistoryDetailsViewController.swift
//  WeDo
//
//  Created by Tanvir Hasan Piash on 21/9/18.
//  Copyright © 2018 Creativeitem. All rights reserved.
//

import UIKit

class SPServiceHistoryDetailsViewController: UIViewController {
    
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
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = GREENISH_COLOR
        label.font = UIFont(name: OPENSANS_REGULAR, size: 18)
        label.numberOfLines = 0
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = UIColor.black
        label.font = UIFont(name: OPENSANS_REGULAR, size: 12)
        label.numberOfLines = 0
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.backgroundColor = UIColor.clear
        view.showsHorizontalScrollIndicator = false
        view.alwaysBounceHorizontal = true
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        view.delegate = self
        view.dataSource = self
        return view
    }()
    
    let addressLabel: UILabel = {
        let label = UILabel()
        label.text = "Address".localized()
        label.textAlignment = .left
        label.textColor = GREENISH_COLOR
        label.font = UIFont(name: OPENSANS_REGULAR, size: 12)
        label.numberOfLines = 0
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let addressValue: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = UIColor.black
        label.font = UIFont(name: OPENSANS_REGULAR, size: 12)
        label.numberOfLines = 0
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let dateLabel: UILabel = {
        let label = UILabel()
        label.text = "Order Date".localized()
        label.textAlignment = .left
        label.textColor = GREENISH_COLOR
        label.font = UIFont(name: OPENSANS_REGULAR, size: 12)
        label.numberOfLines = 0
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let dateValue: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = UIColor.black
        label.font = UIFont(name: OPENSANS_REGULAR, size: 12)
        label.numberOfLines = 0
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let amountLabel: UILabel = {
        let label = UILabel()
        label.text = "Total Amount Received".localized()
        label.textAlignment = .left
        label.textColor = GREENISH_COLOR
        label.font = UIFont(name: OPENSANS_REGULAR, size: 12)
        label.numberOfLines = 0
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let amountValue: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = UIColor.black
        label.font = UIFont(name: OPENSANS_BOLD, size: 14)
        label.numberOfLines = 0
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var object: SPServiceHistoryModel?
    var selectedIndex: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        collectionView.register(SingleImageCell.self, forCellWithReuseIdentifier: SingleImageCell.cellId)
        setNavigationBar()
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
        scrollView.contentSize = CGSize(width: view.frame.width, height: contentHeight + 140)
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
        setupTitleLabel()
        setupDescriptionLabel()
        setupCollectionView()
        setupAddressLabel()
        setupAddressValue()
        setupDateLabel()
        setupDateValue()
        setupAmountLabel()
        setupAmountValue()
    }
    
    func setupData() {
        guard let object = object else { return }
        titleLabel.text = object.data.jobHistory[selectedIndex].serviceTitle
        descriptionLabel.text = object.data.jobHistory[selectedIndex].description
        addressValue.text = object.data.jobHistory[selectedIndex].area ?? ""
        dateValue.text = object.data.jobHistory[selectedIndex].startDateTime
        amountValue.text = "AED \(object.data.jobHistory[selectedIndex].price)"
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
        scrollView.topAnchor.constraint(equalTo: view.topAnchor, constant: 80).isActive = true
        scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    func setupTitleLabel() {
        scrollView.addSubview(titleLabel)
        titleLabel.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16).isActive = true
        titleLabel.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 16).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
    }
    
    func setupDescriptionLabel() {
        scrollView.addSubview(descriptionLabel)
        descriptionLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor).isActive = true
        descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8).isActive = true
        descriptionLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor, constant: 0).isActive = true
    }
    
    func setupCollectionView() {
        scrollView.addSubview(collectionView)
        collectionView.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor).isActive = true
        collectionView.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 16).isActive = true
        collectionView.heightAnchor.constraint(equalToConstant: 80).isActive = true
    }
    
    func setupAddressLabel() {
        scrollView.addSubview(addressLabel)
        addressLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor).isActive = true
        addressLabel.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: 16).isActive = true
        addressLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5).isActive = true
    }
    
    func setupAddressValue() {
        scrollView.addSubview(addressValue)
        addressValue.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor).isActive = true
        addressValue.topAnchor.constraint(equalTo: addressLabel.bottomAnchor, constant: 4).isActive = true
        addressValue.widthAnchor.constraint(equalTo: addressLabel.widthAnchor).isActive = true
    }
    
    func setupDateLabel() {
        scrollView.addSubview(dateLabel)
        dateLabel.leadingAnchor.constraint(equalTo: addressLabel.trailingAnchor, constant: 12).isActive = true
        dateLabel.topAnchor.constraint(equalTo: addressLabel.topAnchor).isActive = true
        dateLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
    }
    
    func setupDateValue() {
        scrollView.addSubview(dateValue)
        dateValue.leadingAnchor.constraint(equalTo: dateLabel.leadingAnchor).isActive = true
        dateValue.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 4).isActive = true
        dateValue.trailingAnchor.constraint(equalTo: dateLabel.trailingAnchor).isActive = true
    }
    
    func setupAmountLabel() {
        scrollView.addSubview(amountLabel)
        amountLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor).isActive = true
        amountLabel.topAnchor.constraint(equalTo: addressValue.bottomAnchor, constant: 24).isActive = true
    }
    
    func setupAmountValue() {
        scrollView.addSubview(amountValue)
        amountValue.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor).isActive = true
        amountValue.topAnchor.constraint(equalTo: amountLabel.bottomAnchor, constant: 4).isActive = true
    }
    
    @objc private func backTapped() {
        navigationController?.popViewController(animated: true)
    }
}

extension SPServiceHistoryDetailsViewController: UIScrollViewDelegate {
    
}

extension SPServiceHistoryDetailsViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let object = object else { return 0 }
        if object.data.jobHistory[selectedIndex].jobThumbnails?.count == 0 {
            return 1
        } else {
            return (object.data.jobHistory[selectedIndex].jobThumbnails?.count)!
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SingleImageCell.cellId, for: indexPath) as? SingleImageCell else {
            let cell = UICollectionViewCell()
            return cell
        }
        if object?.data.jobHistory[selectedIndex].jobThumbnails?.count == 0 {
            cell.image = #imageLiteral(resourceName: "placeholder")
        } else {
            cell.imageView.sd_setImage(with: URL(string: (object?.data.jobHistory[selectedIndex].jobThumbnails![indexPath.item].addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!)!))
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = collectionView.frame.height
        return CGSize(width: height + 16, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
}
