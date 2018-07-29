//
//  JobRequestDetails.swift
//  WeDo
//
//  Created by Creativeitem on 29/7/18.
//  Copyright © 2018 Creativeitem. All rights reserved.
//

import UIKit
import HCSStarRatingView
class JobRequestDetails: UIViewController {
    
    var imageArray = [#imageLiteral(resourceName: "house-1"), #imageLiteral(resourceName: "house-2"), #imageLiteral(resourceName: "house-3"), #imageLiteral(resourceName: "house-4")]
    var numberOfItems : Int!
    
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
    
    lazy var contactDetailsView : UIView = {
       var view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        view.backgroundColor = UIColor(red:0.99, green:0.99, blue:0.99, alpha:1.0)
        return view
    }()
    
    lazy var serviceImageView : UIImageView = {
        var imageview = UIImageView()
        imageview.translatesAutoresizingMaskIntoConstraints = false
        imageview.clipsToBounds = true
        imageview.contentMode = .scaleToFill
        imageview.layer.cornerRadius = 5
        imageview.image = #imageLiteral(resourceName: "dummy6")
        return imageview
    }()
    
    lazy var titleLabelOne: UILabel = {
        let label = UILabel()
        label.textColor = GREENISH_COLOR
        label.font = UIFont(name: OPENSANS_SEMIBOLD, size: 18)
        label.numberOfLines = 0
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "DU Clean"
        return label
    }()
    
    lazy var totalCompletedJobTitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.black
        label.font = UIFont(name: OPENSANS_REGULAR, size: 12)
        label.numberOfLines = 0
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Total Completed Job: "
        return label
    }()
    
    lazy var totalNumberOfCompletedJobLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.gray
        label.font = UIFont(name: OPENSANS_REGULAR, size: 12)
        label.numberOfLines = 0
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "35"
        return label
    }()
    
    lazy var phoneNumberTitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.black
        label.font = UIFont(name: OPENSANS_REGULAR, size: 12)
        label.numberOfLines = 0
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Phone No.: "
        return label
    }()
    
    lazy var phoneNumberLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.gray
        label.font = UIFont(name: OPENSANS_REGULAR, size: 12)
        label.numberOfLines = 0
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "+8801921040960 "
        return label
    }()
    
    lazy var emailTitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.black
        label.font = UIFont(name: OPENSANS_REGULAR, size: 12)
        label.numberOfLines = 0
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Email: "
        return label
    }()
    
    lazy var emailLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.gray
        label.font = UIFont(name: OPENSANS_REGULAR, size: 12)
        label.numberOfLines = 0
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "admin@example.com"
        return label
    }()
    
    lazy var areaTitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.black
        label.font = UIFont(name: OPENSANS_REGULAR, size: 12)
        label.numberOfLines = 0
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Area: "
        return label
    }()
    
    lazy var areaLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.gray
        label.font = UIFont(name: OPENSANS_REGULAR, size: 12)
        label.numberOfLines = 0
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Dubai: "
        return label
    }()
    
    lazy var amountTitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.black
        label.font = UIFont(name: OPENSANS_REGULAR, size: 12)
        label.numberOfLines = 0
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Amount: "
        return label
    }()
    
    lazy var amountLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(red:0.10, green:0.63, blue:0.65, alpha:1.0)
        label.font = UIFont(name: OPENSANS_SEMIBOLD, size: 18)
        label.numberOfLines = 0
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "AED 200"
        return label
    }()
    
    lazy var selectButton : UIButton = {
       let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.clipsToBounds = true
        button.layer.cornerRadius = 4
        button.backgroundColor = GREENISH_COLOR
        button.setTitle("SELECT", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.addTarget(self, action: #selector(handleSelectButton), for: .touchUpInside)
        return button
    }()
    
    lazy var starRatingView : HCSStarRatingView = {
        var view = HCSStarRatingView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        view.maximumValue = 5
        view.minimumValue = 1
        view.value = 3
        view.tintColor = UIColor(red:0.96, green:0.50, blue:0.09, alpha:1.0)
        view.allowsHalfStars = true
        view.isUserInteractionEnabled = false
        view.isEnabled = false
        view.backgroundColor = .clear
        view.alpha = 1
        return view
    }()
    
    let numberOfReviewLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.gray
        label.font = UIFont(name: OPENSANS_REGULAR, size: 11)
        label.numberOfLines = 0
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "(10 Reviews)"
        return label
    }()
    
    lazy var titleLabelTwo: UILabel = {
        let label = UILabel()
        label.textColor = GREENISH_COLOR
        label.font = UIFont(name: OPENSANS_REGULAR, size: 16)
        label.numberOfLines = 0
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Full House Cleaninig"
        return label
    }()
    
    lazy var serviceDescription : UITextView = {
        var textview = UITextView()
        textview.translatesAutoresizingMaskIntoConstraints = false
        textview.clipsToBounds = true
        textview.font = UIFont(name: OPENSANS_REGULAR, size: 12)
        textview.textColor = UIColor.black
        textview.text = "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged."
        textview.isScrollEnabled = true
        textview.isUserInteractionEnabled = false
        return textview
    }()
    
    lazy var addressTitleLabel : UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.clipsToBounds = true
        label.font = UIFont(name: OPENSANS_REGULAR, size: 11)
        label.textColor = GREENISH_COLOR
        label.text = "Address"
        return label
    }()
    
    lazy var addressLabel : UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.clipsToBounds = true
        label.font = UIFont(name: OPENSANS_REGULAR, size: 12)
        label.textColor = UIColor.black
        label.text = "Sector No.: 3, Road No. 2, Uttara"
        return label
    }()
    
    lazy var dateTimeTitleLabel : UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.clipsToBounds = true
        label.font = UIFont(name: OPENSANS_REGULAR, size: 11)
        label.textColor = GREENISH_COLOR
        label.text = "Date and Time"
        return label
    }()
    
    lazy var dateLabel : UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.clipsToBounds = true
        label.font = UIFont(name: OPENSANS_REGULAR, size: 12)
        label.textColor = UIColor.black
        label.text = "22 July, 2017"
        return label
    }()
    
    lazy var timeLabel : UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.clipsToBounds = true
        label.font = UIFont(name: OPENSANS_REGULAR, size: 12)
        label.textColor = UIColor.black
        label.text = "1:30 PM"
        return label
    }()
    
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.backgroundColor = UIColor.clear
        collection.showsVerticalScrollIndicator = false
        collection.alwaysBounceVertical = false
        collection.delegate = self
        collection.dataSource = self
        collection.clipsToBounds = true
        collection.translatesAutoresizingMaskIntoConstraints = false
        return collection
    }()
    
    let serviceRequestImageCellID = "ServiceRequestImageCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        numberOfItems = self.imageArray.count
        
        setNavigationBar()
        layout()
        
        collectionView.register(ServiceRequestImageCell.self, forCellWithReuseIdentifier: serviceRequestImageCellID)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        view.layoutIfNeeded()
        var contentHeight: CGFloat = 0
        for view in scrollView.subviews {
            contentHeight = contentHeight + view.frame.size.height
        }
        scrollView.contentSize = CGSize(width: view.frame.width, height: contentHeight + 100)
        print(contentHeight)
    }
    
    private func setNavigationBar() {
        navigationController?.navigationBar.barTintColor = NAVBAR_BG_COLOR
        let logo = UIImage(named: "logo.png")
        let imageView = UIImageView(image:logo)
        self.navigationItem.titleView = imageView
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "back-icon"), style: .plain, target: self, action: #selector(backTapped))
        self.navigationItem.rightBarButtonItem?.tintColor = UIColor.white
        self.navigationController?.navigationBar.shadowImage = UIImage()
    }
    
    func layout() {
        setupScrollView()
        setupContactDetailsUIView()
        setupServiceImageView()
        setupServiceTitleOne()
        setupTotalCompletedJobTitle()
        setupTotalCompletedJob()
        setupPhoneNumberTitleLabel()
        setupPhoneNumberLabel()
        setupEmailTitleLabel()
        setupEmailLabel()
        setupAreaTitleLabel()
        setupAreaLabel()
        setupAmountTitleLabel()
        setupAmountLabel()
        setupSelectButton()
        setupNumberOfReviewLabel()
        setupStarReviewView()
        setupTitleLabelTwo()
        setupServiceDescriptionTextView()
        setupCollectionView()
        setupAddressTitleLabel()
        setupAddressLabel()
        setupDateAndTimeTitleLabel()
        setupDateLabel()
        setupTimeLabel()
    }
    
    func setupScrollView() {
        let topAnchor = Helper.barHeight + (self.navigationController?.navigationBar.frame.size.height)!
        view.addSubview(scrollView)
        scrollView.topAnchor.constraint(equalTo: view.topAnchor, constant: topAnchor).isActive = true
        scrollView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        scrollView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    func setupContactDetailsUIView() {
        scrollView.addSubview(contactDetailsView)
        contactDetailsView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 16).isActive = true
        contactDetailsView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16).isActive = true
        contactDetailsView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16).isActive = true
        contactDetailsView.heightAnchor.constraint(equalToConstant: 210).isActive = true
    }
    
    func setupServiceImageView() {
        contactDetailsView.addSubview(serviceImageView)
        serviceImageView.topAnchor.constraint(equalTo: contactDetailsView.topAnchor, constant: 10).isActive = true
        serviceImageView.leftAnchor.constraint(equalTo: contactDetailsView.leftAnchor, constant: 10).isActive = true
        serviceImageView.heightAnchor.constraint(equalToConstant: 60).isActive = true
        serviceImageView.widthAnchor.constraint(equalToConstant: 60).isActive = true
    }
    
    func setupServiceTitleOne() {
        contactDetailsView.addSubview(titleLabelOne)
        titleLabelOne.leftAnchor.constraint(equalTo: serviceImageView.rightAnchor, constant: 10).isActive = true
        titleLabelOne.topAnchor.constraint(equalTo: contactDetailsView.topAnchor, constant: 10).isActive = true
    }
    
    func setupTotalCompletedJobTitle() {
        contactDetailsView.addSubview(totalCompletedJobTitleLabel)
        totalCompletedJobTitleLabel.leftAnchor.constraint(equalTo: serviceImageView.rightAnchor, constant: 10).isActive = true
        totalCompletedJobTitleLabel.topAnchor.constraint(equalTo: titleLabelOne.bottomAnchor, constant: 5).isActive = true
    }
    
    func setupTotalCompletedJob() {
        contactDetailsView.addSubview(totalNumberOfCompletedJobLabel)
        totalNumberOfCompletedJobLabel.leftAnchor.constraint(equalTo: totalCompletedJobTitleLabel.rightAnchor, constant: 5).isActive = true
        totalNumberOfCompletedJobLabel.centerYAnchor.constraint(equalTo: totalCompletedJobTitleLabel.centerYAnchor).isActive = true
    }
    
    func setupPhoneNumberTitleLabel() {
        contactDetailsView.addSubview(phoneNumberTitleLabel)
        phoneNumberTitleLabel.leftAnchor.constraint(equalTo: serviceImageView.rightAnchor, constant: 10).isActive = true
        phoneNumberTitleLabel.topAnchor.constraint(equalTo: totalCompletedJobTitleLabel.bottomAnchor, constant: 5).isActive = true
    }
    
    func setupPhoneNumberLabel() {
        contactDetailsView.addSubview(phoneNumberLabel)
        phoneNumberLabel.centerYAnchor.constraint(equalTo: phoneNumberTitleLabel.centerYAnchor).isActive = true
        phoneNumberLabel.leftAnchor.constraint(equalTo: phoneNumberTitleLabel.rightAnchor, constant: 5).isActive = true
    }
    
    func setupEmailTitleLabel() {
        contactDetailsView.addSubview(emailTitleLabel)
        emailTitleLabel.leftAnchor.constraint(equalTo: serviceImageView.rightAnchor, constant: 10).isActive = true
        emailTitleLabel.topAnchor.constraint(equalTo: phoneNumberTitleLabel.bottomAnchor, constant: 5).isActive = true
    }
    
    func setupEmailLabel() {
        contactDetailsView.addSubview(emailLabel)
        emailLabel.centerYAnchor.constraint(equalTo: emailTitleLabel.centerYAnchor).isActive = true
        emailLabel.leftAnchor.constraint(equalTo: emailTitleLabel.rightAnchor, constant: 5).isActive = true
    }
    
    func setupAreaTitleLabel() {
        contactDetailsView.addSubview(areaTitleLabel)
        areaTitleLabel.leftAnchor.constraint(equalTo: serviceImageView.rightAnchor, constant: 10).isActive = true
        areaTitleLabel.topAnchor.constraint(equalTo: emailTitleLabel.bottomAnchor, constant: 5).isActive = true
    }
    
    func setupAreaLabel() {
        contactDetailsView.addSubview(areaLabel)
        areaLabel.centerYAnchor.constraint(equalTo: areaTitleLabel.centerYAnchor).isActive = true
        areaLabel.leftAnchor.constraint(equalTo: emailTitleLabel.rightAnchor, constant: 5).isActive = true
    }
    
    func setupAmountTitleLabel() {
        contactDetailsView.addSubview(amountTitleLabel)
        amountTitleLabel.topAnchor.constraint(equalTo: areaTitleLabel.bottomAnchor, constant: 40).isActive = true
        amountTitleLabel.leftAnchor.constraint(equalTo: contactDetailsView.leftAnchor, constant: 16).isActive = true
    }
    
    func setupAmountLabel() {
        contactDetailsView.addSubview(amountLabel)
        amountLabel.centerYAnchor.constraint(equalTo: amountTitleLabel.centerYAnchor).isActive = true
        amountLabel.leftAnchor.constraint(equalTo: amountTitleLabel.rightAnchor, constant: 5).isActive = true
    }
    
    func setupSelectButton() {
        contactDetailsView.addSubview(selectButton)
        selectButton.centerYAnchor.constraint(equalTo: amountTitleLabel.centerYAnchor).isActive = true
        selectButton.rightAnchor.constraint(equalTo: contactDetailsView.rightAnchor, constant: -16).isActive = true
        selectButton.heightAnchor.constraint(equalToConstant: 60).isActive = true
        selectButton.leftAnchor.constraint(equalTo: amountLabel.rightAnchor, constant: 30).isActive = true
    }
    
    func setupNumberOfReviewLabel() {
        contactDetailsView.addSubview(numberOfReviewLabel)
        numberOfReviewLabel.topAnchor.constraint(equalTo: contactDetailsView.topAnchor, constant: 10).isActive = true
        numberOfReviewLabel.rightAnchor.constraint(equalTo: contactDetailsView.rightAnchor, constant: -10).isActive = true
    }
    
    func setupStarReviewView(){
        contactDetailsView.addSubview(starRatingView)
        starRatingView.centerYAnchor.constraint(equalTo: numberOfReviewLabel.centerYAnchor).isActive = true
        starRatingView.rightAnchor.constraint(equalTo: numberOfReviewLabel.leftAnchor, constant: -5).isActive = true
        starRatingView.heightAnchor.constraint(equalToConstant: 60).isActive = true
        starRatingView.widthAnchor.constraint(equalToConstant: 70).isActive = true
    }
    
    func setupTitleLabelTwo() {
        scrollView.addSubview(titleLabelTwo)
        titleLabelTwo.topAnchor.constraint(equalTo: contactDetailsView.bottomAnchor, constant: 20).isActive = true
        titleLabelTwo.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16).isActive = true
    }
    
    func setupServiceDescriptionTextView() {
        scrollView.addSubview(serviceDescription)
        serviceDescription.topAnchor.constraint(equalTo: titleLabelTwo.bottomAnchor, constant: 20).isActive = true
        serviceDescription.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16).isActive = true
        serviceDescription.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16).isActive = true
        serviceDescription.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.2).isActive = true
    }
    
    func setupCollectionView() {
        let rows: CGFloat = (CGFloat(numberOfItems)/3).rounded(.up)
        let height = (view.frame.width / 3) * (rows) - 32
        scrollView.addSubview(collectionView)
        collectionView.topAnchor.constraint(equalTo: serviceDescription.bottomAnchor, constant: 16).isActive = true
        collectionView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16).isActive = true
        collectionView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16).isActive = true
        collectionView.heightAnchor.constraint(equalToConstant: height).isActive = true
    }
    
    func setupAddressTitleLabel() {
        view.addSubview(addressTitleLabel)
        addressTitleLabel.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: 16).isActive = true
        addressTitleLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16).isActive = true
    }
    
    func setupAddressLabel() {
        view.addSubview(addressLabel)
        addressLabel.topAnchor.constraint(equalTo: addressTitleLabel.bottomAnchor, constant: 5).isActive = true
        addressLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16).isActive = true
    }
    
    func setupDateAndTimeTitleLabel() {
        view.addSubview(dateTimeTitleLabel)
        dateTimeTitleLabel.centerYAnchor.constraint(equalTo: addressTitleLabel.centerYAnchor).isActive = true
        dateTimeTitleLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16).isActive = true
    }
    
    func setupDateLabel() {
        view.addSubview(dateLabel)
        dateLabel.topAnchor.constraint(equalTo: dateTimeTitleLabel.bottomAnchor, constant: 5).isActive = true
        dateLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16).isActive = true
    }
    
    func setupTimeLabel() {
        view.addSubview(timeLabel)
        timeLabel.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 5).isActive = true
        timeLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16).isActive = true
    }
    
    @objc func backTapped() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func handleSelectButton() {
        self.navigationController?.pushViewController(CustomerSettingsViewController(), animated: true)
    }
}

extension JobRequestDetails: UISearchControllerDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.imageArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: serviceRequestImageCellID, for: indexPath) as? ServiceRequestImageCell else {
            
            let cell = collectionView.cellForItem(at: indexPath)!
            return cell
        }
        cell.mainImage = imageArray[indexPath.row]
        cell.removeButton.alpha = 0
        
        return cell
    }
}

extension JobRequestDetails: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width: CGFloat = collectionView.frame.width / 3 - 4
        let height: CGFloat = width
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 4
    }
    
}

extension JobRequestDetails : UIScrollViewDelegate {
    
}
