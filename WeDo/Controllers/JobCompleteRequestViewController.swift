//
//  JobCompleteRequestViewController.swift
//  WeDo
//
//  Created by Tanvir Hasan Piash on 7/10/18.
//  Copyright © 2018 Creativeitem. All rights reserved.
//

import UIKit
import HCSStarRatingView
import SDWebImage

class JobCompleteRequestViewController: UIViewController {
    
    var data: MemberOrderDataModel?
    var selectedIndex: Int = 0
    
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
    
    lazy var backgroundImageView : UIImageView = {
        var imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .clear
        imageView.image = #imageLiteral(resourceName: "bigger-logo")
        return imageView
    }()
    
    let companyInfoHolder: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.init(white: 0.9, alpha: 0.2)
        view.layer.cornerRadius = 5
        view.layer.borderColor = UIColor.init(white: 0.9, alpha: 0.5).cgColor
        view.layer.borderWidth = 1
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let companyImageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let companyTitleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = GREENISH_COLOR
        label.font = UIFont(name: OPENSANS_SEMIBOLD, size: 14)
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let jobCompletedLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = UIColor.black
        label.font = UIFont(name: OPENSANS_REGULAR, size: 12)
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let emailLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = UIColor.black
        label.font = UIFont(name: OPENSANS_REGULAR, size: 12)
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let areaLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = UIColor.black
        label.font = UIFont(name: OPENSANS_REGULAR, size: 12)
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let amountLabel: UILabel = {
        let label = UILabel()
        label.text = "Amount".localized() + ": "
        label.textAlignment = .left
        label.textColor = UIColor.black
        label.font = UIFont(name: OPENSANS_REGULAR, size: 12)
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let amountValue: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = GREENISH_COLOR
        label.font = UIFont(name: OPENSANS_REGULAR, size: 14)
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let starView: HCSStarRatingView = {
        var view = HCSStarRatingView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        view.maximumValue = 5
        view.minimumValue = 0
        view.tintColor = UIColor(red:0.96, green:0.50, blue:0.09, alpha:1.0)
        view.allowsHalfStars = true
        view.isUserInteractionEnabled = false
        view.isEnabled = false
        view.backgroundColor = .clear
        view.alpha = 1
        return view
    }()
    
    let reviewsLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = UIColor.lightGray
        label.font = UIFont(name: OPENSANS_REGULAR, size: 12)
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
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
    
    lazy var jobDoneButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("JOB DONE".localized(), for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.backgroundColor = GREENISH_COLOR
        button.titleLabel?.font = UIFont(name: OPENSANS_REGULAR, size: 16)
        button.clipsToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 5
        button.layer.borderColor = GREENISH_COLOR.cgColor
        button.layer.borderWidth = 1
        button.addTarget(self, action: #selector(jobDoneTapped), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        setNavigationBar()
        layout()
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
        setupCompanyInfoHolder()
        setupCompanyImageView()
        setupCompanyTitleLabel()
        setupJobCompletedLabel()
        setupCompanyEmailLabel()
        setupAreaLabel()
        setupAmountLabel()
        setupAmountValue()
        setupStarView()
        setupReviewsLabel()
        setupTitleLabel()
        setupDescriptionLabel()
        setupAddressLabel()
        setupAddressValue()
        setupDateLabel()
        setupDateValue()
        setupJobDoneButton()
        
        setupData()
    }
    
    func setupData() {
        guard let data = data else { return }
        guard let agent = data.data.jobRequestList[selectedIndex].agents else { return }
        guard let companyImage = agent.first?.companyLogo else { return }
        companyImageView.sd_setImage(with: URL(string: companyImage.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!), placeholderImage: UIImage(named: "cloud-download"), options: [.continueInBackground], completed: nil)
        companyTitleLabel.text = agent.first?.companyName ?? ""
        jobCompletedLabel.text = "Total completed job".localized() + ": " + "\(agent.first?.totalJobDone ?? 0)"
        emailLabel.text = "Email".localized() + ": " + "\(agent.first?.companyEmail ?? "")"
        areaLabel.text = "Area".localized() + ": " + "\(agent.first?.companyAddress ?? "")"
        let isPaid = data.data.jobRequestList[selectedIndex].isPaymentComplete ? "Paid".localized() : ""
        amountValue.text = "AED \(agent.first?.serviceRequestBidAmount ?? 0) " + "(\(isPaid))"
        starView.value = CGFloat(agent.first?.rating ?? 0)
        reviewsLabel.text = "( \(agent.first?.totalReviews ?? 0) " + "Reviews )".localized()
        titleLabel.text = data.data.jobRequestList[selectedIndex].serviceTitle
        descriptionLabel.text = data.data.jobRequestList[selectedIndex].description ?? ""
        addressValue.text = data.data.jobRequestList[selectedIndex].area
        dateValue.text = data.data.jobRequestList[selectedIndex].startDateTime
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
        scrollView.topAnchor.constraint(equalTo: view.topAnchor, constant: Helper.barHeight+(self.navigationController?.navigationBar.frame.size.height)!).isActive = true
        scrollView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        scrollView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    func setupCompanyInfoHolder() {
        scrollView.addSubview(companyInfoHolder)
        NSLayoutConstraint.activate([
            companyInfoHolder.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 16),
            companyInfoHolder.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            companyInfoHolder.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            companyInfoHolder.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.25)
            ])
    }
    
    func setupCompanyImageView() {
        companyInfoHolder.addSubview(companyImageView)
        NSLayoutConstraint.activate([
            companyImageView.topAnchor.constraint(equalTo: companyInfoHolder.topAnchor, constant: 16),
            companyImageView.leadingAnchor.constraint(equalTo: companyInfoHolder.leadingAnchor, constant: 16),
            companyImageView.widthAnchor.constraint(equalToConstant: 50),
            companyImageView.heightAnchor.constraint(equalToConstant: 50)
            ])
    }
    
    func setupCompanyTitleLabel() {
        companyInfoHolder.addSubview(companyTitleLabel)
        NSLayoutConstraint.activate([
            companyTitleLabel.topAnchor.constraint(equalTo: companyImageView.topAnchor, constant: 0),
            companyTitleLabel.leadingAnchor.constraint(equalTo: companyImageView.trailingAnchor, constant: 16)
            ])
    }
    
    func setupJobCompletedLabel() {
        companyInfoHolder.addSubview(jobCompletedLabel)
        NSLayoutConstraint.activate([
            jobCompletedLabel.topAnchor.constraint(equalTo: companyTitleLabel.bottomAnchor, constant: 4),
            jobCompletedLabel.leadingAnchor.constraint(equalTo: companyTitleLabel.leadingAnchor, constant: 0)
            ])
    }
    
    func setupCompanyEmailLabel() {
        companyInfoHolder.addSubview(emailLabel)
        NSLayoutConstraint.activate([
            emailLabel.topAnchor.constraint(equalTo: jobCompletedLabel.bottomAnchor, constant: 4),
            emailLabel.leadingAnchor.constraint(equalTo: companyTitleLabel.leadingAnchor, constant: 0)
            ])
    }
    
    func setupAreaLabel() {
        companyInfoHolder.addSubview(areaLabel)
        NSLayoutConstraint.activate([
            areaLabel.topAnchor.constraint(equalTo: emailLabel.bottomAnchor, constant: 4),
            areaLabel.leadingAnchor.constraint(equalTo: companyTitleLabel.leadingAnchor, constant: 0)
            ])
    }
    
    func setupAmountLabel() {
        companyInfoHolder.addSubview(amountLabel)
        NSLayoutConstraint.activate([
            amountLabel.topAnchor.constraint(equalTo: areaLabel.bottomAnchor, constant: 4),
            amountLabel.leadingAnchor.constraint(equalTo: companyTitleLabel.leadingAnchor, constant: 0)
            ])
    }
    
    func setupAmountValue() {
        companyInfoHolder.addSubview(amountValue)
        NSLayoutConstraint.activate([
            amountValue.centerYAnchor.constraint(equalTo: amountLabel.centerYAnchor),
            amountValue.leadingAnchor.constraint(equalTo: amountLabel.trailingAnchor, constant: 2)
            ])
    }
    
    func setupStarView() {
        companyInfoHolder.addSubview(starView)
        NSLayoutConstraint.activate([
            starView.topAnchor.constraint(equalTo: amountLabel.bottomAnchor, constant: 8),
            starView.leadingAnchor.constraint(equalTo: companyTitleLabel.leadingAnchor, constant: 0),
            starView.heightAnchor.constraint(equalToConstant: 24),
            starView.widthAnchor.constraint(equalToConstant: 60)
            ])
    }
    
    func setupReviewsLabel() {
        companyInfoHolder.addSubview(reviewsLabel)
        NSLayoutConstraint.activate([
            reviewsLabel.centerYAnchor.constraint(equalTo: starView.centerYAnchor),
            reviewsLabel.leadingAnchor.constraint(equalTo: starView.trailingAnchor, constant: 4)
            ])
    }
    
    func setupTitleLabel() {
        scrollView.addSubview(titleLabel)
        titleLabel.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16).isActive = true
        titleLabel.topAnchor.constraint(equalTo: companyInfoHolder.bottomAnchor, constant: 16).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
    }
    
    func setupDescriptionLabel() {
        scrollView.addSubview(descriptionLabel)
        descriptionLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor).isActive = true
        descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8).isActive = true
        descriptionLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor, constant: 0).isActive = true
    }
    
    func setupAddressLabel() {
        scrollView.addSubview(addressLabel)
        addressLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor).isActive = true
        addressLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 16).isActive = true
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
    
    func setupJobDoneButton() {
        scrollView.addSubview(jobDoneButton)
        jobDoneButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        jobDoneButton.topAnchor.constraint(equalTo: addressValue.bottomAnchor, constant: 24).isActive = true
        jobDoneButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
        jobDoneButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    @objc private func backTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc private func jobDoneTapped() {
        
    }
    
}

extension JobCompleteRequestViewController: UIScrollViewDelegate {
    
}
