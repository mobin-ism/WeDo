//
//  SPNewJobDetailsViewController.swift
//  WeDo
//
//  Created by Tanvir Hasan Piash on 17/9/18.
//  Copyright © 2018 Creativeitem. All rights reserved.
//

import UIKit

class SPNewJobDetailsViewController: UIViewController {
    
    let backgroundImageView : UIImageView = {
        var imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .clear
        imageView.image = #imageLiteral(resourceName: "bigger-logo")
        return imageView
    }()
    
    let topView: UIView = {
        let view = UIView()
        view.backgroundColor = GREENISH_COLOR
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var backButton: UIButton = {
        let button = UIButton(type: .system)
        button.setBackgroundImage(#imageLiteral(resourceName: "back-icon"), for: .normal)
        button.clipsToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(backTapped), for: .touchUpInside)
        return button
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
        label.text = "Date & Time".localized()
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
    
    let customerDetailsLabel: UILabel = {
        let label = UILabel()
        label.text = "Customer Details".localized()
        label.textAlignment = .left
        label.textColor = GREENISH_COLOR
        label.font = UIFont(name: OPENSANS_REGULAR, size: 18)
        label.numberOfLines = 0
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var collectionView2: UICollectionView = {
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
        view.layer.borderColor = UIColor.init(white: 0.9, alpha: 0.9).cgColor
        view.layer.borderWidth = 1
        return view
    }()
    
    let aedLabel: UILabel = {
        let label = UILabel()
        label.text = "AED".localized()
        label.textAlignment = .left
        label.textColor = GREENISH_COLOR
        label.font = UIFont(name: OPENSANS_REGULAR, size: 18)
        label.numberOfLines = 0
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var bidTextField : PaddedTextField = {
        var textfield = PaddedTextField()
        textfield.font = UIFont(name: OPENSANS_REGULAR, size: 14)
        textfield.textAlignment = .center
        textfield.translatesAutoresizingMaskIntoConstraints = false
        textfield.clipsToBounds = true
        textfield.layer.cornerRadius = 5
        textfield.layer.borderWidth = 1
        textfield.layer.borderColor = UIColor(red:0.62, green:0.62, blue:0.62, alpha:0.5).cgColor
        textfield.keyboardType = .numberPad
        return textfield
    }()
    
    lazy var bidButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("BID".localized(), for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.backgroundColor = GREENISH_COLOR
        button.titleLabel?.font = UIFont(name: OPENSANS_REGULAR, size: 16)
        button.clipsToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 5
        button.layer.borderColor = GREENISH_COLOR.cgColor
        button.layer.borderWidth = 1
        button.addTarget(self, action: #selector(bidButtonTapped), for: .touchUpInside)
        return button
    }()
    
    let customerDetailNames = ["Name".localized(), "Phone no.".localized(), "Address".localized()]
    let customerDetailsValue = ["John Doe", "0162427252", "United Arab Amirates"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        collectionView.register(SingleImageCell.self, forCellWithReuseIdentifier: SingleImageCell.cellId)
        collectionView2.register(SPCustomerDetailCell.self, forCellWithReuseIdentifier: SPCustomerDetailCell.cellId)
        layout()
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
    
    private func layout() {
        setupBackgroundImageView()
        setupTopView()
        setupBackButton()
        setupScrollView()
        setupTitleLabel()
        setupDescriptionLabel()
        setupCollectionView()
        setupAddressLabel()
        setupAddressValue()
        setupDateLabel()
        setupDateValue()
        setupCustomerDetailsLabel()
        setupCollectionView2()
        setupAEDLabel()
        setupBidTextField()
        setupBidButton()
    }
    
    func setupBackgroundImageView() {
        view.addSubview(backgroundImageView)
        backgroundImageView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        backgroundImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 25).isActive = true
        backgroundImageView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.5).isActive = true
        backgroundImageView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8).isActive = true
    }
    
    func setupTopView() {
        view.addSubview(topView)
        topView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        topView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        topView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        topView.heightAnchor.constraint(equalToConstant: 68).isActive = true
    }
    
    func setupBackButton() {
        topView.addSubview(backButton)
        backButton.leadingAnchor.constraint(equalTo: topView.leadingAnchor, constant: 8).isActive = true
        backButton.bottomAnchor.constraint(equalTo: topView.bottomAnchor, constant: -16).isActive = true
        backButton.heightAnchor.constraint(equalToConstant: 22).isActive = true
        backButton.widthAnchor.constraint(equalToConstant: 22).isActive = true
    }
    
    func setupScrollView() {
        view.addSubview(scrollView)
        scrollView.topAnchor.constraint(equalTo: topView.bottomAnchor, constant: 0).isActive = true
        scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    func setupTitleLabel() {
        scrollView.addSubview(titleLabel)
        titleLabel.text = "Full House Cleaning"
        titleLabel.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16).isActive = true
        titleLabel.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 16).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
    }
    
    func setupDescriptionLabel() {
        scrollView.addSubview(descriptionLabel)
        descriptionLabel.text = "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged."
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
        addressValue.text = "2 Infinite Loop, Cupertino, CA 2323, USA"
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
        dateValue.text = "15th March, 2018 | 1:00 PM"
        dateValue.leadingAnchor.constraint(equalTo: dateLabel.leadingAnchor).isActive = true
        dateValue.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 4).isActive = true
        dateValue.trailingAnchor.constraint(equalTo: dateLabel.trailingAnchor).isActive = true
    }
    
    func setupCustomerDetailsLabel() {
        scrollView.addSubview(customerDetailsLabel)
        customerDetailsLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor).isActive = true
        customerDetailsLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor).isActive = true
        customerDetailsLabel.topAnchor.constraint(equalTo: addressValue.bottomAnchor, constant: 24).isActive = true
    }
    
    func setupCollectionView2() {
        scrollView.addSubview(collectionView2)
        collectionView2.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor).isActive = true
        collectionView2.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor).isActive = true
        collectionView2.topAnchor.constraint(equalTo: customerDetailsLabel.bottomAnchor, constant: 16).isActive = true
        collectionView2.heightAnchor.constraint(equalToConstant: 32*3).isActive = true
    }
    
    func setupAEDLabel() {
        scrollView.addSubview(aedLabel)
        aedLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor).isActive = true
        aedLabel.topAnchor.constraint(equalTo: collectionView2.bottomAnchor, constant: 32).isActive = true
    }
    
    func setupBidTextField() {
        scrollView.addSubview(bidTextField)
        bidTextField.centerYAnchor.constraint(equalTo: aedLabel.centerYAnchor).isActive = true
        bidTextField.leadingAnchor.constraint(equalTo: aedLabel.trailingAnchor, constant: 8).isActive = true
        bidTextField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.3).isActive = true
        bidTextField.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }
    
    func setupBidButton() {
        scrollView.addSubview(bidButton)
        bidButton.topAnchor.constraint(equalTo: bidTextField.topAnchor).isActive = true
        bidButton.bottomAnchor.constraint(equalTo: bidTextField.bottomAnchor).isActive = true
        bidButton.leadingAnchor.constraint(equalTo: bidTextField.trailingAnchor, constant: 8).isActive = true
        bidButton.widthAnchor.constraint(equalTo: bidTextField.widthAnchor).isActive = true
    }
    
    @objc private func backTapped() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc private func bidButtonTapped() {
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
}

extension SPNewJobDetailsViewController: UIScrollViewDelegate {
    
}

extension SPNewJobDetailsViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == collectionView2 {
            return customerDetailNames.count
        } else {
            return 2
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == collectionView2 {
            guard let cell = collectionView2.dequeueReusableCell(withReuseIdentifier: SPCustomerDetailCell.cellId, for: indexPath) as? SPCustomerDetailCell else {
                let cell = UICollectionViewCell()
                return cell
            }
            cell.setData(name: "\(customerDetailNames[indexPath.item]) :", value: customerDetailsValue[indexPath.item])
            return cell
        } else {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SingleImageCell.cellId, for: indexPath) as? SingleImageCell else {
                let cell = UICollectionViewCell()
                return cell
            }
            cell.image = #imageLiteral(resourceName: "house-4")
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if collectionView == collectionView2 {
            if indexPath.item == customerDetailNames.count - 1 {
                let cell = collectionView2.dequeueReusableCell(withReuseIdentifier: SPCustomerDetailCell.cellId, for: indexPath) as! SPCustomerDetailCell
                cell.divider.alpha = 0
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == collectionView2 {
            let width = collectionView2.frame.width
            return CGSize(width: width, height: 32)
        } else {
            let height = collectionView.frame.height
            return CGSize(width: height + 16, height: height)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        if collectionView == collectionView2 {
            return 0
        } else {
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        if collectionView == collectionView2 {
            return 0
        } else {
            return 10
        }
    }
    
}
