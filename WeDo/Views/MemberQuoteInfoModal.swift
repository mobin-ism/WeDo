//
//  MemberQuoteInfoModal.swift
//  WeDo
//
//  Created by Tanvir Hasan Piash on 6/10/18.
//  Copyright © 2018 Creativeitem. All rights reserved.
//

import UIKit
import SDWebImage
import HCSStarRatingView

class MemberQuoteInfoModal: NSObject {
    
    var index: Int = 0
    
    lazy var activeOrderVC: ActiveOrderViewController = {
        let vc = ActiveOrderViewController()
        vc.memberQuoteInfoModal = self
        return vc
    }()
    
    lazy var quoteInfoView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.init(white: 0.1, alpha: 0.2)
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isUserInteractionEnabled = true
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(dismiss)))
        view.alpha = 0
        return view
    }()
    
    let quoteInfoHolder: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        return view
    }()
    
    let imageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let serviceTitleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = UIColor.black
        label.font = UIFont(name: OPENSANS_REGULAR, size: 14)
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let serviceStatusLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = UIColor.darkGray
        label.font = UIFont(name: OPENSANS_REGULAR, size: 12)
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let separator: UIView = {
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
        label.textColor = UIColor.darkGray
        label.font = UIFont(name: OPENSANS_REGULAR, size: 12)
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let amountLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .right
        label.textColor = GREENISH_COLOR
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
    
    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .justified
        label.textColor = UIColor.lightGray
        label.font = UIFont(name: OPENSANS_REGULAR, size: 11)
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }()
    
    lazy var checkButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(imageLiteralResourceName: "jobdone"), for: .normal)
        button.clipsToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(checkTapped), for: .touchUpInside)
        return button
    }()
    
    func show(data: MemberOrderDataModel, selectedIndex: Int) {
        setupQuoteInfoView()
        setupInfoLayout()
        setupImageView()
        setupServiceTitleLabel()
        setupServiceStatusLabel()
        setupSeparator()
        setupCompanyImageView()
        setupCompanyTitleLabel()
        setupStarView()
        setupAmountLabel()
        setupDescriptionLabel()
        setupJobDoneButton()
        
        setupData(data: data, index: selectedIndex)
        index = selectedIndex
    }
    
    func setupQuoteInfoView() {
        if let window = UIApplication.shared.keyWindow {
            window.addSubview(quoteInfoView)
            UIView.animate(withDuration: 0.33) {
                self.quoteInfoView.alpha = 1
            }
            NSLayoutConstraint.activate([
                quoteInfoView.leadingAnchor.constraint(equalTo: window.leadingAnchor),
                quoteInfoView.trailingAnchor.constraint(equalTo: window.trailingAnchor),
                quoteInfoView.topAnchor.constraint(equalTo: window.topAnchor),
                quoteInfoView.bottomAnchor.constraint(equalTo: window.bottomAnchor)
            ])
        }
    }
    
    func setupInfoLayout() {
        if let window = UIApplication.shared.keyWindow {
            quoteInfoView.addSubview(quoteInfoHolder)
            let height = window.frame.height * 0.5
            let y = window.frame.height - height
            quoteInfoHolder.frame = CGRect(x: 0, y: window.frame.height, width: window.frame.width, height: height)
            UIView.animate(withDuration: 0.33) {
                self.quoteInfoHolder.frame = CGRect(x: 0, y: y, width: self.quoteInfoHolder.frame.width, height: self.quoteInfoHolder.frame.height)
            }
        }
    }
    
    func setupImageView() {
        quoteInfoHolder.addSubview(imageView)
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: quoteInfoHolder.topAnchor, constant: 16),
            imageView.leadingAnchor.constraint(equalTo: quoteInfoHolder.leadingAnchor, constant: 16),
            imageView.heightAnchor.constraint(equalToConstant: 50),
            imageView.widthAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    func setupServiceTitleLabel() {
        quoteInfoHolder.addSubview(serviceTitleLabel)
        NSLayoutConstraint.activate([
            serviceTitleLabel.topAnchor.constraint(equalTo: imageView.topAnchor, constant: 8),
            serviceTitleLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 8)
        ])
    }
    
    func setupServiceStatusLabel() {
        quoteInfoHolder.addSubview(serviceStatusLabel)
        NSLayoutConstraint.activate([
            serviceStatusLabel.topAnchor.constraint(equalTo: serviceTitleLabel.bottomAnchor, constant: 4),
            serviceStatusLabel.leadingAnchor.constraint(equalTo: serviceTitleLabel.leadingAnchor, constant: 0)
        ])
    }
    
    func setupSeparator() {
        quoteInfoHolder.addSubview(separator)
        NSLayoutConstraint.activate([
            separator.leadingAnchor.constraint(equalTo: quoteInfoHolder.leadingAnchor),
            separator.trailingAnchor.constraint(equalTo: quoteInfoHolder.trailingAnchor),
            separator.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 16),
            separator.heightAnchor.constraint(equalToConstant: 1)
        ])
    }
    
    func setupCompanyImageView() {
        quoteInfoHolder.addSubview(companyImageView)
        NSLayoutConstraint.activate([
            companyImageView.topAnchor.constraint(equalTo: separator.bottomAnchor, constant: 16),
            companyImageView.leadingAnchor.constraint(equalTo: separator.leadingAnchor, constant: 16),
            companyImageView.heightAnchor.constraint(equalToConstant: 50),
            companyImageView.widthAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    func setupCompanyTitleLabel() {
        quoteInfoHolder.addSubview(companyTitleLabel)
        NSLayoutConstraint.activate([
            companyTitleLabel.topAnchor.constraint(equalTo: companyImageView.topAnchor, constant: 8),
            companyTitleLabel.leadingAnchor.constraint(equalTo: companyImageView.trailingAnchor, constant: 8)
        ])
    }
    
    func setupStarView() {
        quoteInfoHolder.addSubview(starView)
        NSLayoutConstraint.activate([
            starView.topAnchor.constraint(equalTo: companyTitleLabel.bottomAnchor, constant: 4),
            starView.leadingAnchor.constraint(equalTo: companyTitleLabel.leadingAnchor, constant: 0),
            starView.heightAnchor.constraint(equalToConstant: 10),
            starView.widthAnchor.constraint(equalToConstant: 60)
        ])
    }
    
    func setupAmountLabel() {
        quoteInfoHolder.addSubview(amountLabel)
        NSLayoutConstraint.activate([
            amountLabel.topAnchor.constraint(equalTo: companyTitleLabel.topAnchor, constant: 0),
            amountLabel.trailingAnchor.constraint(equalTo: quoteInfoHolder.trailingAnchor, constant: -16)
        ])
    }
    
    func setupDescriptionLabel() {
        quoteInfoHolder.addSubview(descriptionLabel)
        NSLayoutConstraint.activate([
            descriptionLabel.topAnchor.constraint(equalTo: companyImageView.bottomAnchor, constant: 16),
            descriptionLabel.leadingAnchor.constraint(equalTo: companyImageView.leadingAnchor, constant: 0),
            descriptionLabel.trailingAnchor.constraint(equalTo: quoteInfoHolder.trailingAnchor, constant: -16)
        ])
    }
    
    func setupJobDoneButton() {
        quoteInfoHolder.addSubview(checkButton)
        NSLayoutConstraint.activate([
            checkButton.centerYAnchor.constraint(equalTo: imageView.centerYAnchor),
            checkButton.trailingAnchor.constraint(equalTo: quoteInfoView.trailingAnchor, constant: -16),
            checkButton.widthAnchor.constraint(equalToConstant: 50),
            checkButton.heightAnchor.constraint(equalToConstant: 50)
            ])
    }
    
    func setupData(data: MemberOrderDataModel, index: Int) {
        serviceTitleLabel.text = data.data.jobRequestList[index].serviceTitle
        imageView.sd_setImage(with: URL(string: data.data.jobRequestList[index].serviceIcon.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!), placeholderImage: UIImage(named: "placeholder"), options: [.continueInBackground], completed: nil)
        serviceStatusLabel.text = "Status: ".localized() + "\(data.data.jobRequestList[index].status)"
        guard let agent = data.data.jobRequestList[index].agents else { return }
        guard let firstData = agent.first else { return }
        companyImageView.sd_setImage(with: URL(string: firstData.companyLogo?.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)! ?? ""), placeholderImage: UIImage(named: "cloud-download"), options: [.continueInBackground], completed: nil)
        companyTitleLabel.text = firstData.companyName
        starView.value = CGFloat(firstData.rating)
        amountLabel.text = "AED \(firstData.serviceRequestBidAmount)"
        descriptionLabel.text = data.data.jobRequestList[index].description ?? ""
        
    }
    
    @objc func dismiss() {
        if let window = UIApplication.shared.keyWindow {
            UIView.animate(withDuration: 0.33, animations: {
                self.quoteInfoHolder.frame = CGRect(x: 0, y: window.frame.height, width: self.quoteInfoHolder.frame.width, height: self.quoteInfoHolder.frame.height)
            }) { (_) in
                UIView.animate(withDuration: 0.33, animations: {
                    self.quoteInfoView.alpha = 0
                    for view in self.quoteInfoView.subviews {
                        view.removeFromSuperview()
                    }
                    self.quoteInfoView.removeFromSuperview()
                })
            }
        }
    }
    
    @objc func checkTapped() {
        dismiss()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.activeOrderVC.checkTappedFromModal(index: self.index)
        }
    }
    
}
