//
//  WelcomeViewController.swift
//  WeDo
//
//  Created by Al Mobin on 30/7/18.
//  Copyright © 2018 Creativeitem. All rights reserved.
//

import UIKit
class WelcomeViewController: UIViewController {
    
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
    
    lazy var weDoImageView : UIImageView = {
        var imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .clear
        imageView.image = #imageLiteral(resourceName: "colorful-logo")
        return imageView
    }()
    
    lazy var thankYouLabel : UILabel = {
       var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.clipsToBounds = true
        label.font = UIFont(name: OPENSANS_BOLD, size: 25)
        label.text = "Thank You For"
        label.textColor = GREENISH_COLOR
        label.numberOfLines = 1
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    lazy var yourOrdreLabel : UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.clipsToBounds = true
        label.font = UIFont(name: OPENSANS_BOLD, size: 25)
        label.text = "Your Order"
        label.textColor = GREENISH_COLOR
        label.numberOfLines = 1
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    lazy var yourJobIdLabel : UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.clipsToBounds = true
        label.font = UIFont(name: OPENSANS_REGULAR, size: 12)
        label.text = "Your Job ID: "
        label.textColor = UIColor.black
        return label
    }()
    
    lazy var jobIdLabel : UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.clipsToBounds = true
        label.font = UIFont(name: OPENSANS_REGULAR, size: 12)
        label.textColor = UIColor.black
        return label
    }()
    
    lazy var messageLabel : UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.clipsToBounds = true
        label.font = UIFont(name: OPENSANS_REGULAR, size: 10)
        label.textColor = UIColor.black
        return label
    }()
    
    lazy var jobTitleView : UIView = {
       var view = UIView()
        view.backgroundColor = UIColor(red:0.99, green:0.99, blue:0.99, alpha:1.0)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor(red:0.88, green:0.88, blue:0.88, alpha:1.0).cgColor
        view.layer.cornerRadius = 0
        return view
    }()
    
    lazy var amountToBePaidView : UIView = {
        var view = UIView()
        view.backgroundColor = UIColor(red:0.99, green:0.99, blue:0.99, alpha:1.0)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor(red:0.88, green:0.88, blue:0.88, alpha:1.0).cgColor
        view.layer.cornerRadius = 0
        return view
    }()
    
    lazy var paymentMethodView : UIView = {
        var view = UIView()
        view.backgroundColor = UIColor(red:0.99, green:0.99, blue:0.99, alpha:1.0)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor(red:0.88, green:0.88, blue:0.88, alpha:1.0).cgColor
        view.layer.cornerRadius = 0
        return view
    }()
    
    lazy var jobTitleImageView : UIImageView = {
        var imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .clear
        imageView.image = #imageLiteral(resourceName: "dummy2")
        return imageView
    }()
    
    lazy var jobTitleLabel : UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.clipsToBounds = true
        label.font = UIFont(name: OPENSANS_REGULAR, size: 12)
        label.text = "Job Title: "
        label.textColor = UIColor.black
        return label
    }()
    
    lazy var jobLabel : UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.clipsToBounds = true
        label.font = UIFont(name: OPENSANS_BOLD, size: 14)
        label.textColor = GREENISH_COLOR
        return label
    }()
    
    lazy var amountToBePaidImageView : UIImageView = {
        var imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .clear
        imageView.image = #imageLiteral(resourceName: "dummy2")
        return imageView
    }()
    
    lazy var amountToBePaidTitleLabel : UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.clipsToBounds = true
        label.font = UIFont(name: OPENSANS_REGULAR, size: 12)
        label.text = "Amount To Be Paid: "
        label.textColor = UIColor.black
        return label
    }()
    
    lazy var amountToBePaidLabel : UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.clipsToBounds = true
        label.font = UIFont(name: OPENSANS_BOLD, size: 14)
        label.text = "AED 150"
        label.textColor = GREENISH_COLOR
        return label
    }()
    
    lazy var paymentMethodImageView : UIImageView = {
        var imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .clear
        imageView.image = #imageLiteral(resourceName: "dummy2")
        return imageView
    }()
    
    lazy var paymentMethodTitleLabel : UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.clipsToBounds = true
        label.font = UIFont(name: OPENSANS_REGULAR, size: 12)
        label.text = "Payment Method: "
        label.textColor = UIColor.black
        return label
    }()
    
    lazy var paymentMethodLabel : UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.clipsToBounds = true
        label.font = UIFont(name: OPENSANS_BOLD, size: 14)
        label.text = "Cash"
        label.textColor = GREENISH_COLOR
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationBar()
        view.backgroundColor = UIColor.white
        layout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        Alert.checkInternetConnection(on: self)
        self.jobLabel.text = "\(UserDefaults.standard.value(forKey: SUB_SERVICE_TITLE) as! String)"
        UserDefaults.standard.set(false, forKey: SHOW_WELCOME_PAGE)
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
        self.navigationItem.rightBarButtonItem?.tintColor = UIColor.white
        self.navigationController?.navigationBar.shadowImage = UIImage()
    }
    
    func layout() {
        setupBackgroundImageView()
        setupScrollView()
        setupWEDOLogo()
        setupThankYouLabel()
        setupYourOrderLabel()
        setupYourJobIDLabel()
        setupJobIdLabel()
        setupMessageLabel()
        setupJobTitleView()
        setupJobTitleImageView()
        setupJobTitleLabel()
        setupJobLabel()
        setupAmountToBePaidView()
        setupAmountToBePaidImageView()
        setupAmountToBePaidTitleLabel()
        setupAmountToBePaidLabel()
        setupPaymentMethodView()
        setupPaymentMethodImageView()
        setupPaymentMethodTitleLabel()
        setupPaymentMethodLabel()
    }
    
    func setupBackgroundImageView() {
        view.addSubview(backgroundImageView)
        backgroundImageView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        backgroundImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 25).isActive = true
        backgroundImageView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.5).isActive = true
        backgroundImageView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8).isActive = true
    }
    
    func setupScrollView() {
        let topAnchor = Helper.barHeight + (self.navigationController?.navigationBar.frame.size.height)!
        view.addSubview(scrollView)
        scrollView.topAnchor.constraint(equalTo: view.topAnchor, constant: topAnchor).isActive = true
        scrollView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        scrollView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    func setupWEDOLogo() {
        scrollView.addSubview(weDoImageView)
        weDoImageView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 50).isActive = true
        weDoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        weDoImageView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        weDoImageView.widthAnchor.constraint(equalToConstant: 100).isActive = true
    }
    
    func setupThankYouLabel() {
        scrollView.addSubview(thankYouLabel)
        thankYouLabel.topAnchor.constraint(equalTo: weDoImageView.bottomAnchor, constant: 30).isActive = true
        thankYouLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
    
    func setupYourOrderLabel() {
        scrollView.addSubview(yourOrdreLabel)
        yourOrdreLabel.topAnchor.constraint(equalTo: thankYouLabel.bottomAnchor, constant: 5).isActive = true
        yourOrdreLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
    
    func setupYourJobIDLabel() {
        scrollView.addSubview(yourJobIdLabel)
        yourJobIdLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: -35).isActive = true
        yourJobIdLabel.topAnchor.constraint(equalTo: yourOrdreLabel.bottomAnchor, constant: 20).isActive = true
    }
    
    func setupJobIdLabel() {
        scrollView.addSubview(jobIdLabel)
        jobIdLabel.leftAnchor.constraint(equalTo: yourJobIdLabel.rightAnchor, constant: 5).isActive = true
        jobIdLabel.centerYAnchor.constraint(equalTo: yourJobIdLabel.centerYAnchor).isActive = true
    }
    
    func setupMessageLabel() {
        scrollView.addSubview(messageLabel)
        messageLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        messageLabel.topAnchor.constraint(equalTo: yourJobIdLabel.bottomAnchor, constant: 5).isActive = true
    }
    
    func setupJobTitleView() {
        scrollView.addSubview(jobTitleView)
        jobTitleView.topAnchor.constraint(equalTo: messageLabel.bottomAnchor, constant: 20).isActive = true
        jobTitleView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16).isActive = true
        jobTitleView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16).isActive = true
        jobTitleView.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    func setupJobTitleImageView() {
        jobTitleView.addSubview(jobTitleImageView)
        jobTitleImageView.centerYAnchor.constraint(equalTo: jobTitleView.centerYAnchor).isActive = true
        jobTitleImageView.leftAnchor.constraint(equalTo: jobTitleView.leftAnchor, constant: 16).isActive = true
        jobTitleImageView.heightAnchor.constraint(equalToConstant: 20).isActive = true
        jobTitleImageView.widthAnchor.constraint(equalToConstant: 20).isActive = true
    }
    
    func  setupJobTitleLabel() {
        jobTitleView.addSubview(jobTitleLabel)
        jobTitleLabel.centerYAnchor.constraint(equalTo: jobTitleImageView.centerYAnchor).isActive = true
        jobTitleLabel.leftAnchor.constraint(equalTo: jobTitleImageView.rightAnchor, constant: 5).isActive = true
    }
    
    func setupJobLabel() {
        jobTitleView.addSubview(jobLabel)
        jobLabel.centerYAnchor.constraint(equalTo: jobTitleImageView.centerYAnchor).isActive = true
        jobLabel.leftAnchor.constraint(equalTo: jobTitleLabel.rightAnchor, constant: 5).isActive = true
    }
    
    func setupAmountToBePaidView() {
        scrollView.addSubview(amountToBePaidView)
        amountToBePaidView.topAnchor.constraint(equalTo: jobTitleView.bottomAnchor, constant: -1).isActive = true
        amountToBePaidView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16).isActive = true
        amountToBePaidView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16).isActive = true
        amountToBePaidView.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    func setupAmountToBePaidImageView() {
        amountToBePaidView.addSubview(amountToBePaidImageView)
        amountToBePaidImageView.centerYAnchor.constraint(equalTo: amountToBePaidView.centerYAnchor).isActive = true
        amountToBePaidImageView.leftAnchor.constraint(equalTo: amountToBePaidView.leftAnchor, constant: 16).isActive = true
        amountToBePaidImageView.heightAnchor.constraint(equalToConstant: 20).isActive = true
        amountToBePaidImageView.widthAnchor.constraint(equalToConstant: 20).isActive = true
    }
    
    func  setupAmountToBePaidTitleLabel() {
        amountToBePaidView.addSubview(amountToBePaidTitleLabel)
        amountToBePaidTitleLabel.centerYAnchor.constraint(equalTo: amountToBePaidImageView.centerYAnchor).isActive = true
        amountToBePaidTitleLabel.leftAnchor.constraint(equalTo: amountToBePaidImageView.rightAnchor, constant: 5).isActive = true
    }
    
    func setupAmountToBePaidLabel() {
        amountToBePaidView.addSubview(amountToBePaidLabel)
        amountToBePaidLabel.centerYAnchor.constraint(equalTo: amountToBePaidImageView.centerYAnchor).isActive = true
        amountToBePaidLabel.leftAnchor.constraint(equalTo: amountToBePaidTitleLabel.rightAnchor, constant: 5).isActive = true
    }
    
    func setupPaymentMethodView() {
        scrollView.addSubview(paymentMethodView)
        paymentMethodView.topAnchor.constraint(equalTo: amountToBePaidView.bottomAnchor, constant: -1).isActive = true
        paymentMethodView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16).isActive = true
        paymentMethodView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16).isActive = true
        paymentMethodView.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    func setupPaymentMethodImageView() {
        paymentMethodView.addSubview(paymentMethodImageView)
        paymentMethodImageView.centerYAnchor.constraint(equalTo: paymentMethodView.centerYAnchor).isActive = true
        paymentMethodImageView.leftAnchor.constraint(equalTo: paymentMethodView.leftAnchor, constant: 16).isActive = true
        paymentMethodImageView.heightAnchor.constraint(equalToConstant: 20).isActive = true
        paymentMethodImageView.widthAnchor.constraint(equalToConstant: 20).isActive = true
    }
    
    func  setupPaymentMethodTitleLabel() {
        paymentMethodView.addSubview(paymentMethodTitleLabel)
        paymentMethodTitleLabel.centerYAnchor.constraint(equalTo: paymentMethodImageView.centerYAnchor).isActive = true
        paymentMethodTitleLabel.leftAnchor.constraint(equalTo: paymentMethodImageView.rightAnchor, constant: 5).isActive = true
    }
    
    func setupPaymentMethodLabel() {
        paymentMethodView.addSubview(paymentMethodLabel)
        paymentMethodLabel.centerYAnchor.constraint(equalTo: paymentMethodImageView.centerYAnchor).isActive = true
        paymentMethodLabel.leftAnchor.constraint(equalTo: paymentMethodTitleLabel.rightAnchor, constant: 5).isActive = true
    }
    
    @objc func backTapped() {
        let viewControllers: [UIViewController] = self.navigationController!.viewControllers
        for aViewController in viewControllers {
            if aViewController is HomeViewController {
                self.navigationController!.popToViewController(aViewController, animated: true)
            }
        }
    }
}

extension WelcomeViewController : UIScrollViewDelegate {
    
}
