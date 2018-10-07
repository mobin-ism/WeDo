//
//  ActiveOrderDetailsViewController.swift
//  WeDo
//
//  Created by Tanvir Hasan Piash on 7/10/18.
//  Copyright © 2018 Creativeitem. All rights reserved.
//

import UIKit
import HCSStarRatingView
import SDWebImage

class ActiveOrderDetailsViewController: UIViewController {
    
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
    
    lazy var cancelButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("CANCEL ORDER".localized(), for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.backgroundColor = GREENISH_COLOR
        button.titleLabel?.font = UIFont(name: OPENSANS_REGULAR, size: 16)
        button.clipsToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 5
        button.layer.borderColor = GREENISH_COLOR.cgColor
        button.layer.borderWidth = 1
        button.addTarget(self, action: #selector(cancelTapped), for: .touchUpInside)
        return button
    }()
    
    let separator1: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.init(white: 0.9, alpha: 0.5)
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let separator2: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.init(white: 0.9, alpha: 0.5)
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
        label.textColor = UIColor.black
        label.font = UIFont(name: OPENSANS_BOLD, size: 14)
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
    
    let amountLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .right
        label.textColor = UIColor.black
        label.font = UIFont(name: OPENSANS_BOLD, size: 16)
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        collectionView.register(SingleImageCell.self, forCellWithReuseIdentifier: SingleImageCell.cellId)
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
        setupTitleLabel()
        setupDescriptionLabel()
        setupCollectionView()
        setupAddressLabel()
        setupAddressValue()
        setupDateLabel()
        setupDateValue()
        setupCancelButton()
        
        setupData()
        
        setupViewsForPendingOrderWithQuote()
    }
    
    func setupData() {
        guard let data = data else { return }
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
    
    func setupCancelButton() {
        scrollView.addSubview(cancelButton)
        cancelButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        cancelButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
        cancelButton.topAnchor.constraint(equalTo: addressValue.bottomAnchor, constant: 24).isActive = true
        cancelButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    func setupViewsForPendingOrderWithQuote() {
        guard let data = data else { return }
        if let agent = data.data.jobRequestList[selectedIndex].agents {
            if agent.count > 0 {
                scrollView.addSubview(separator1)
                NSLayoutConstraint.activate([
                    separator1.topAnchor.constraint(equalTo: cancelButton.bottomAnchor, constant: 24),
                    separator1.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                    separator1.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                    separator1.heightAnchor.constraint(equalToConstant: 1)
                    ])
                
                scrollView.addSubview(companyImageView)
                companyImageView.sd_setImage(with: URL(string: agent.first?.companyLogo?.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)! ?? ""), placeholderImage: UIImage(named: "cloud-download"), options: [.continueInBackground], completed: nil)
                NSLayoutConstraint.activate([
                    companyImageView.topAnchor.constraint(equalTo: separator1.bottomAnchor, constant: 24),
                    companyImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
                    companyImageView.widthAnchor.constraint(equalToConstant: 50),
                    companyImageView.heightAnchor.constraint(equalToConstant: 50)
                    ])
                
                scrollView.addSubview(companyTitleLabel)
                companyTitleLabel.text = agent.first?.companyName ?? ""
                NSLayoutConstraint.activate([
                    companyTitleLabel.topAnchor.constraint(equalTo: companyImageView.topAnchor, constant: 4),
                    companyTitleLabel.leadingAnchor.constraint(equalTo: companyImageView.trailingAnchor, constant: 8)
                    ])
                
                scrollView.addSubview(jobCompletedLabel)
                jobCompletedLabel.text = "Total completed job: ".localized() + "\(agent.first?.totalJobDone ?? 0)"
                NSLayoutConstraint.activate([
                    jobCompletedLabel.topAnchor.constraint(equalTo: companyTitleLabel.bottomAnchor, constant: 4),
                    jobCompletedLabel.leadingAnchor.constraint(equalTo: companyTitleLabel.leadingAnchor, constant: 0)
                    ])
                
                scrollView.addSubview(amountLabel)
                amountLabel.text = "AED \(agent.first?.serviceRequestBidAmount ?? 0)"
                NSLayoutConstraint.activate([
                    amountLabel.topAnchor.constraint(equalTo: companyTitleLabel.topAnchor, constant: 0),
                    amountLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
                    ])
                
                scrollView.addSubview(starView)
                starView.value = CGFloat(agent.first?.rating ?? 0)
                NSLayoutConstraint.activate([
                    starView.topAnchor.constraint(equalTo: amountLabel.bottomAnchor, constant: 4),
                    starView.leadingAnchor.constraint(equalTo: amountLabel.leadingAnchor),
                    starView.heightAnchor.constraint(equalToConstant: 20),
                    starView.widthAnchor.constraint(equalToConstant: 50)
                    ])
                
                scrollView.addSubview(separator2)
                NSLayoutConstraint.activate([
                    separator2.topAnchor.constraint(equalTo: starView.bottomAnchor, constant: 24),
                    separator2.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                    separator2.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                    separator2.heightAnchor.constraint(equalToConstant: 1)
                    ])
            }
        }
    }
    
    @objc private func backTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc private func cancelTapped() {
        
    }
    
}

extension ActiveOrderDetailsViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let data = data else { return 0 }
        if data.data.jobRequestList[selectedIndex].jobThumbnails?.count == 0 {
            return 1
        } else {
            return (data.data.jobRequestList[selectedIndex].jobThumbnails?.count)!
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SingleImageCell.cellId, for: indexPath) as? SingleImageCell else {
            let cell = UICollectionViewCell()
            return cell
        }
        guard let data = data else { return UICollectionViewCell() }
        if data.data.jobRequestList[selectedIndex].jobThumbnails?.count == 0 {
            cell.image = #imageLiteral(resourceName: "placeholder")
        } else {
            cell.imageView.sd_setImage(with: URL(string: (data.data.jobRequestList[selectedIndex].jobThumbnails![indexPath.item].addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!)))
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

extension ActiveOrderDetailsViewController: UIScrollViewDelegate {
    
}

extension ActiveOrderDetailsViewController {
    
    func setupAgentView(agent: [MemberAgent]) {
        
    }
    
}
