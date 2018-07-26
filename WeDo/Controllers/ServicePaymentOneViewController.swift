//
//  ServicePaymentOneViewController.swift
//  WeDo
//
//  Created by Al Mobin on 21/7/18.
//  Copyright © 2018 Creativeitem. All rights reserved.
//

import UIKit
class ServicePaymentOneViewController: UIViewController {
    
    
    lazy var backgroundImageView : UIImageView = {
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
    
    lazy var descriptionButton : UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.clipsToBounds = true
        button.backgroundColor = UIColor(red:64/255, green:173/255, blue:93/255, alpha:0.9)
        button.setTitle("Description", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.titleLabel?.font = UIFont(name: OPENSANS_REGULAR, size: 12)
        button.tag = 1
        button.addTarget(self, action: #selector(navigationButtonTapped( _:)), for: .touchUpInside)
        return button
    }()
    
    lazy var locationButton : UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.clipsToBounds = true
        button.backgroundColor = UIColor(red:64/255, green:173/255, blue:93/255, alpha:0.9)
        button.setTitle("Location", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.titleLabel?.font = UIFont(name: OPENSANS_REGULAR, size: 12)
        button.tag = 2
        button.addTarget(self, action: #selector(navigationButtonTapped( _:)), for: .touchUpInside)
        return button
    }()
    
    lazy var dateAndTimeButton : UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.clipsToBounds = true
        button.backgroundColor = UIColor(red:64/255, green:173/255, blue:93/255, alpha:0.9)
        button.setTitle("Date and Time", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.titleLabel?.font = UIFont(name: OPENSANS_REGULAR, size: 12)
        button.tag = 3
        button.addTarget(self, action: #selector(navigationButtonTapped( _:)), for: .touchUpInside)
        return button
    }()
    
    lazy var paymentButton : UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.clipsToBounds = true
        button.backgroundColor = UIColor(red:64/255, green:173/255, blue:93/255, alpha:0.9)
        button.setTitle("Payment", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = UIFont(name: OPENSANS_REGULAR, size: 12)
        button.tag = 4
        button.addTarget(self, action: #selector(navigationButtonTapped( _:)), for: .touchUpInside)
        return button
    }()
    
    lazy var jobTitleView : UIView = {
        var view = UIView()
        view.backgroundColor = UIColor(red:252/255, green:251/255, blue:252/255, alpha:0.9)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor(red:0.91, green:0.91, blue:0.91, alpha:0.5).cgColor
        return view
    }()
    
    let jobTitleImageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        view.image = #imageLiteral(resourceName: "dummy2")
        view.backgroundColor = GREENISH_COLOR
        view.layer.cornerRadius = 5
        return view
    }()
    
    let jobTitleLabel : UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.clipsToBounds = true
        label.numberOfLines = 0
        label.font = UIFont(name: OPENSANS_REGULAR, size: 12)
        label.textColor = UIColor.black
        label.text = "Job Title:"
        return label
    }()
    
    let jobLabel : UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.clipsToBounds = true
        label.numberOfLines = 0
        label.font = UIFont(name: OPENSANS_REGULAR, size: 16)
        label.textColor = GREENISH_COLOR
        label.text = "Full House Cleaning"
        return label
    }()
    
    lazy var amountToBePaidView : UIView = {
        var view = UIView()
        view.backgroundColor = UIColor(red:252/255, green:251/255, blue:252/255, alpha:0.9)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor(red:0.91, green:0.91, blue:0.91, alpha:0.5).cgColor
        return view
    }()
    
    let amountToBePaidImageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        view.image = #imageLiteral(resourceName: "dummy2")
        view.backgroundColor = GREENISH_COLOR
        view.layer.cornerRadius = 5
        return view
    }()
    
    let amountToBePaidLabel : UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.clipsToBounds = true
        label.numberOfLines = 0
        label.font = UIFont(name: OPENSANS_REGULAR, size: 16)
        label.textColor = GREENISH_COLOR
        label.text = "AED 150"
        label.textAlignment = .left
        return label
    }()
    
    let amountToBePaidTitleLabel : UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.clipsToBounds = true
        label.numberOfLines = 0
        label.font = UIFont(name: OPENSANS_REGULAR, size: 12)
        label.textColor = UIColor.black
        label.text = "Amount To Be Paid:"
        return label
    }()
    
    lazy var payThroughCardButton : UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.clipsToBounds = true
        button.backgroundColor = UIColor(red:0.17, green:0.67, blue:0.31, alpha:1.0)
        button.setTitle("PAY THROUGH CARD", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = UIFont(name: OPENSANS_REGULAR, size: 15)
        button.layer.cornerRadius = 5
        button.addTarget(self, action: #selector(checkLoginStatus), for: .touchUpInside)
        return button
    }()
    
    lazy var cashOnDeliveryButton : UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.clipsToBounds = true
        button.backgroundColor = UIColor(red:24/255, green:151/255, blue:155/255, alpha:1.0)
        button.setTitle("CASH ON DELIVERY", for: .normal)
        button.titleLabel?.font = UIFont(name: OPENSANS_REGULAR, size: 15)
        button.setTitleColor(UIColor.white, for: .normal)
        button.layer.cornerRadius = 5
        button.addTarget(self, action: #selector(checkLoginStatus), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        layout()
        setNavigationBar()
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
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Full Hosue Cleaning", style: .plain, target: self, action: #selector(rightBarButtonTapped))
        self.navigationItem.rightBarButtonItem?.tintColor = UIColor.white
        self.navigationController?.navigationBar.shadowImage = UIImage()
    }
    func layout() {
        setupBackgroundImageView()
        setupDescriptionButton()
        setupLocationButton()
        setupDateTimeButton()
        setupPaymentButton()
        setupScrollView()
        setupJobTitleView()
        setupJobTitleImageView()
        setupJobTitleLabel()
        setupJobLabel()
        setupAmountToBePaidView()
        setupAmountToBePaidImageView()
        setupAmountToBePaidTitleLabel()
        setupAmountToBePaidLabel()
        setupPayThroughCardButton()
        setupCashOnDeliveryButton()
    }
    
    func setupBackgroundImageView() {
        view.addSubview(backgroundImageView)
        backgroundImageView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        backgroundImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 25).isActive = true
        backgroundImageView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.5).isActive = true
        backgroundImageView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8).isActive = true
    }
    
    func setupDescriptionButton() {
        view.addSubview(descriptionButton)
        descriptionButton.topAnchor.constraint(equalTo: view.topAnchor, constant: Helper.barHeight+(self.navigationController?.navigationBar.frame.size.height)!).isActive = true
        descriptionButton.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        descriptionButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        descriptionButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.25).isActive = true
    }
    
    func setupLocationButton() {
        view.addSubview(locationButton)
        locationButton.topAnchor.constraint(equalTo: view.topAnchor, constant: Helper.barHeight+(self.navigationController?.navigationBar.frame.size.height)!).isActive = true
        locationButton.leftAnchor.constraint(equalTo: descriptionButton.rightAnchor).isActive = true
        locationButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        locationButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.25).isActive = true
    }
    
    func setupDateTimeButton() {
        view.addSubview(dateAndTimeButton)
        dateAndTimeButton.topAnchor.constraint(equalTo: view.topAnchor, constant: Helper.barHeight+(self.navigationController?.navigationBar.frame.size.height)!).isActive = true
        dateAndTimeButton.leftAnchor.constraint(equalTo: locationButton.rightAnchor).isActive = true
        dateAndTimeButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        dateAndTimeButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.25).isActive = true
    }
    
    func setupPaymentButton() {
        view.addSubview(paymentButton)
        paymentButton.topAnchor.constraint(equalTo: view.topAnchor, constant: Helper.barHeight+(self.navigationController?.navigationBar.frame.size.height)!).isActive = true
        paymentButton.leftAnchor.constraint(equalTo: dateAndTimeButton.rightAnchor).isActive = true
        paymentButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        paymentButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.25).isActive = true
    }
    
    func setupScrollView() {
        view.addSubview(scrollView)
        scrollView.topAnchor.constraint(equalTo: descriptionButton.bottomAnchor, constant: 16).isActive = true
        scrollView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        scrollView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    func setupJobTitleView() {
        scrollView.addSubview(jobTitleView)
        jobTitleView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        jobTitleView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16).isActive = true
        jobTitleView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16).isActive = true
        jobTitleView.heightAnchor.constraint(equalToConstant: 100).isActive = true
    }
    
    func setupJobTitleImageView() {
        jobTitleView.addSubview(jobTitleImageView)
        jobTitleImageView.centerYAnchor.constraint(equalTo: jobTitleView.centerYAnchor).isActive = true
        jobTitleImageView.leftAnchor.constraint(equalTo: jobTitleView.leftAnchor, constant: 16).isActive = true
        jobTitleImageView.heightAnchor.constraint(equalToConstant: 60).isActive = true
        jobTitleImageView.widthAnchor.constraint(equalToConstant: 60).isActive = true
    }
    
    func setupJobTitleLabel() {
        jobTitleView.addSubview(jobTitleLabel)
        jobTitleLabel.centerYAnchor.constraint(equalTo: jobTitleImageView.centerYAnchor).isActive = true
        jobTitleLabel.leftAnchor.constraint(equalTo: jobTitleImageView.rightAnchor, constant: 16).isActive = true
    }
    
    func setupJobLabel() {
        jobTitleView.addSubview(jobLabel)
        jobLabel.centerYAnchor.constraint(equalTo: jobTitleImageView.centerYAnchor).isActive = true
        jobLabel.leftAnchor.constraint(equalTo: jobTitleLabel.rightAnchor, constant: 5).isActive = true
        jobLabel.rightAnchor.constraint(equalTo: jobTitleView.rightAnchor, constant: -16).isActive = true
    }
    
    func setupAmountToBePaidView() {
        scrollView.addSubview(amountToBePaidView)
        amountToBePaidView.topAnchor.constraint(equalTo: jobTitleView.bottomAnchor, constant: -1).isActive = true
        amountToBePaidView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16).isActive = true
        amountToBePaidView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16).isActive = true
        amountToBePaidView.heightAnchor.constraint(equalToConstant: 100).isActive = true
    }
    
    func setupAmountToBePaidImageView() {
        amountToBePaidView.addSubview(amountToBePaidImageView)
        amountToBePaidImageView.centerYAnchor.constraint(equalTo: amountToBePaidView.centerYAnchor).isActive = true
        amountToBePaidImageView.leftAnchor.constraint(equalTo: amountToBePaidView.leftAnchor, constant: 16).isActive = true
        amountToBePaidImageView.heightAnchor.constraint(equalToConstant: 60).isActive = true
        amountToBePaidImageView.widthAnchor.constraint(equalToConstant: 60).isActive = true
    }
    
    func setupAmountToBePaidTitleLabel() {
        amountToBePaidView.addSubview(amountToBePaidTitleLabel)
        amountToBePaidTitleLabel.centerYAnchor.constraint(equalTo: amountToBePaidImageView.centerYAnchor).isActive = true
        amountToBePaidTitleLabel.leftAnchor.constraint(equalTo: amountToBePaidImageView.rightAnchor, constant: 16).isActive = true
    }
    
    func setupAmountToBePaidLabel() {
        amountToBePaidView.addSubview(amountToBePaidLabel)
        amountToBePaidLabel.centerYAnchor.constraint(equalTo: amountToBePaidImageView.centerYAnchor).isActive = true
        amountToBePaidLabel.leftAnchor.constraint(equalTo: amountToBePaidTitleLabel.rightAnchor, constant: 5).isActive = true
    }
    
    func setupPayThroughCardButton() {
        scrollView.addSubview(payThroughCardButton)
        payThroughCardButton.topAnchor.constraint(equalTo: amountToBePaidView.bottomAnchor, constant: 20).isActive = true
        payThroughCardButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16).isActive = true
        payThroughCardButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16).isActive = true
        payThroughCardButton.heightAnchor.constraint(equalToConstant: 60).isActive = true
    }
    func setupCashOnDeliveryButton() {
        scrollView.addSubview(cashOnDeliveryButton)
        cashOnDeliveryButton.topAnchor.constraint(equalTo: payThroughCardButton.bottomAnchor, constant: 15).isActive = true
        cashOnDeliveryButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16).isActive = true
        cashOnDeliveryButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16).isActive = true
        cashOnDeliveryButton.heightAnchor.constraint(equalToConstant: 60).isActive = true
    }
    
    @objc func rightBarButtonTapped() {
        
    }
    
    @objc func backTapped() {
        //self.navigationController?.popViewController(animated: true)
        let viewControllers: [UIViewController] = self.navigationController!.viewControllers
        for aViewController in viewControllers {
            if aViewController is AllServicesListViewController {
                self.navigationController!.popToViewController(aViewController, animated: true)
            }
        }
    }
    
    @objc func navigationButtonTapped(_ sender: UIButton) {
        switch sender.tag {
        case 1:
            self.navigationController?.pushViewController(ServiceDescriptionOneViewController(), animated: false)
        case 2:
            self.navigationController?.pushViewController(ServiceLocationOneViewController(), animated: false)
        case 3:
            self.navigationController?.pushViewController(ServiceDateAndTimeOneViewController(), animated: false)
        default:
            print("current view controller")
        }
    }
    
    @objc func checkLoginStatus() {
        self.navigationController?.pushViewController(LoginViewController(), animated: true)
    }
}

extension ServicePaymentOneViewController : UIScrollViewDelegate {
    
}
