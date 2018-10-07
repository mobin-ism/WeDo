//
//  PrivacyPolicyViewController.swift
//  WeDo
//
//  Created by Tanvir Hasan Piash on 15/9/18.
//  Copyright © 2018 Creativeitem. All rights reserved.
//

import UIKit

class PrivacyPolicyViewController: UIViewController {
    
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
        label.text = "Privacy Policy".localized()
        label.textAlignment = .center
        label.textColor = GREENISH_COLOR
        label.font = UIFont(name: OPENSANS_BOLD, size: 16)
        label.numberOfLines = 1
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let headerOneLabel: UILabel = {
        let label = UILabel()
        label.text = "Our collection of your personal information".localized()
        label.textAlignment = .left
        label.textColor = GREENISH_COLOR
        label.font = UIFont(name: OPENSANS_BOLD, size: 14)
        label.numberOfLines = 0
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let contentOneLabel: UILabel = {
        let label = UILabel()
        label.text = "As part of your registration on the application, you will be asked to provide us with certain personal information, such as your name, shipping address, email address and/or telephone number and other similar information as well as some additional information about you such as your date of birth or other identifying information. Additionally, in order for us to verify your identity, we may need to request from you valid proof if identification.".localized()
        label.textAlignment = .justified
        label.textColor = UIColor.black
        label.font = UIFont(name: OPENSANS_REGULAR, size: 12)
        label.numberOfLines = 0
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let headerTwoLabel: UILabel = {
        let label = UILabel()
        label.text = "Our use of your personal information".localized()
        label.textAlignment = .left
        label.textColor = GREENISH_COLOR
        label.font = UIFont(name: OPENSANS_BOLD, size: 14)
        label.numberOfLines = 0
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let contentTwoLabel: UILabel = {
        let label = UILabel()
        label.text = "We only use your personal information to provide services and customer support to you, to measure and improve our services to you, to prevent illegal activities and implement our user agreement with you, troubleshoot problems, collect fees, provide you with promotional emails and verify information you give us with third parties. For example, we may share some of the personal information you give us with banks or credit card authorisation, processing and verification services or with third parties for fraud screening purposes.".localized()
        label.textAlignment = .justified
        label.textColor = UIColor.black
        label.font = UIFont(name: OPENSANS_REGULAR, size: 12)
        label.numberOfLines = 0
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
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
        setupScrollView()
        setupTitleLabel()
        setupHeaderOneLabel()
        setupContentOneLabel()
        setupHeaderTwoLabel()
        setupContentTwoLabel()
    }
    
    func setupScrollView() {
        view.addSubview(scrollView)
        scrollView.topAnchor.constraint(equalTo: view.topAnchor, constant: Helper.barHeight+(self.navigationController?.navigationBar.frame.size.height)!).isActive = true
        scrollView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        scrollView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    private func setupTitleLabel() {
        scrollView.addSubview(titleLabel)
        titleLabel.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 16).isActive = true
        titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
    
    private func setupHeaderOneLabel() {
        scrollView.addSubview(headerOneLabel)
        headerOneLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        headerOneLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 24).isActive = true
        headerOneLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
    }
    
    private func setupContentOneLabel() {
        scrollView.addSubview(contentOneLabel)
        contentOneLabel.topAnchor.constraint(equalTo: headerOneLabel.bottomAnchor, constant: 8).isActive = true
        contentOneLabel.leadingAnchor.constraint(equalTo: headerOneLabel.leadingAnchor).isActive = true
        contentOneLabel.trailingAnchor.constraint(equalTo: headerOneLabel.trailingAnchor).isActive = true
    }
    
    private func setupHeaderTwoLabel() {
        scrollView.addSubview(headerTwoLabel)
        headerTwoLabel.topAnchor.constraint(equalTo: contentOneLabel.bottomAnchor, constant: 16).isActive = true
        headerTwoLabel.leadingAnchor.constraint(equalTo: headerOneLabel.leadingAnchor).isActive = true
        headerTwoLabel.trailingAnchor.constraint(equalTo: headerOneLabel.trailingAnchor).isActive = true
    }
    
    private func setupContentTwoLabel() {
        scrollView.addSubview(contentTwoLabel)
        contentTwoLabel.topAnchor.constraint(equalTo: headerTwoLabel.bottomAnchor, constant: 8).isActive = true
        contentTwoLabel.leadingAnchor.constraint(equalTo: contentOneLabel.leadingAnchor).isActive = true
        contentTwoLabel.trailingAnchor.constraint(equalTo: contentOneLabel.trailingAnchor).isActive = true
    }
    
    @objc private func backTapped() {
        navigationController?.popViewController(animated: true)
    }
    
}

extension PrivacyPolicyViewController: UIScrollViewDelegate {
    
}
