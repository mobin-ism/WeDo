//
//  TermsConditionsViewController.swift
//  WeDo
//
//  Created by Tanvir Hasan Piash on 15/9/18.
//  Copyright © 2018 Creativeitem. All rights reserved.
//

import UIKit

class TermsConditionsViewController: UIViewController {
    
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
        label.text = "Terms and Conditions".localized()
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
        label.text = "Eligibility for Membership".localized()
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
        label.text = "Wedo wishes to ensure that its members are able to form legally binding contracts and further that minors do not purchase unsuitable content. Therefore membership of the site is not available to persons under the age of 18 years. You represent that you are 18 years of age or over the age of 18 years before you become a member of the site.".localized()
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
        label.text = "Your Account and Registration Obligations".localized()
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
        label.text = "You are responsible for maintaining the confidentiality of, and restricting access to and use of, your account and password, and accept responsiblity for all activities that occur under your account and password. You agree to immediately notify WeDo of any unauthorised use of your password or account or any other breach of security.".localized()
        label.textAlignment = .justified
        label.textColor = UIColor.black
        label.font = UIFont(name: OPENSANS_REGULAR, size: 12)
        label.numberOfLines = 0
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let headerThreeLabel: UILabel = {
        let label = UILabel()
        label.text = "Online Payment".localized()
        label.textAlignment = .left
        label.textColor = GREENISH_COLOR
        label.font = UIFont(name: OPENSANS_BOLD, size: 14)
        label.numberOfLines = 0
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let contentThreeLabel: UILabel = {
        let label = UILabel()
        label.text = "If you make a payment for our products or services on our application, the details you are asked to submit will be provided directly to our payment provider via a secured connection. The cardholder must retain a copy of transaction records and Merchant policies and rules.".localized()
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
        setupHeaderThreeLabel()
        setupContentThreeLabel()
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
    
    private func setupHeaderThreeLabel() {
        scrollView.addSubview(headerThreeLabel)
        headerThreeLabel.topAnchor.constraint(equalTo: contentTwoLabel.bottomAnchor, constant: 16).isActive = true
        headerThreeLabel.leadingAnchor.constraint(equalTo: headerOneLabel.leadingAnchor).isActive = true
        headerThreeLabel.trailingAnchor.constraint(equalTo: headerOneLabel.trailingAnchor).isActive = true
    }
    
    private func setupContentThreeLabel() {
        scrollView.addSubview(contentThreeLabel)
        contentThreeLabel.topAnchor.constraint(equalTo: headerThreeLabel.bottomAnchor, constant: 8).isActive = true
        contentThreeLabel.leadingAnchor.constraint(equalTo: contentOneLabel.leadingAnchor).isActive = true
        contentThreeLabel.trailingAnchor.constraint(equalTo: contentOneLabel.trailingAnchor).isActive = true
    }
    
    @objc private func backTapped() {
        navigationController?.popViewController(animated: true)
    }
}

extension TermsConditionsViewController: UIScrollViewDelegate {
    
}
