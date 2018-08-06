//
//  ServiceDetailsViewController.swift
//  WeDo
//
//  Created by Creativeitem on 26/7/18.
//  Copyright © 2018 Creativeitem. All rights reserved.
//

import UIKit
import HCSStarRatingView

class ServiceDetailsViewController: UIViewController {
    
    lazy var starRatingView : HCSStarRatingView = {
        var view = HCSStarRatingView()
        view.maximumValue = 5
        view.minimumValue = 1
        view.value = 3.5
        view.tintColor = UIColor(red:1.00, green:0.62, blue:0.00, alpha:1.0)
        view.allowsHalfStars = true
        view.isUserInteractionEnabled = false
        view.isEnabled = false
        view.frame = CGRect(x: 76, y: 36 , width: 100, height: 30)
        view.addTarget(self, action: #selector(didChangeValue(_:)), for: .valueChanged)
        view.alpha = 1
        return view
    }()
    
    lazy var backgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.init(white: 0.9, alpha: 0.9)
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(hide)))
        view.alpha = 0
        return view
    }()
    
    let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        view.clipsToBounds = true
        return view
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
    
    let serviceImageView : UIImageView = {
       var imageview = UIImageView()
        imageview.translatesAutoresizingMaskIntoConstraints = false
        imageview.clipsToBounds = true
        imageview.contentMode = .scaleAspectFit
        imageview.image = #imageLiteral(resourceName: "dummy4")
        imageview.frame.size.height = 50
        imageview.layer.cornerRadius = imageview.frame.size.height / 2
        return imageview
    }()
    
    let serviceTitleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = UIColor.black
        label.text = "Service Title Label"
        label.font = UIFont(name: OPENSANS_REGULAR, size: 13)
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        return label
    }()
    
    let paymentModeLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = UIColor.black
        label.text = "Payment Mode:"
        label.font = UIFont(name: OPENSANS_REGULAR, size: 13)
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        return label
    }()
    
    let paymentTypeLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = UIColor.lightGray
        label.text = "Cash"
        label.font = UIFont(name: OPENSANS_REGULAR, size: 13)
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        return label
    }()
    
    let serviceDescriptionLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = UIColor.black
        label.text = "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged."
        label.font = UIFont(name: OPENSANS_REGULAR, size: 11)
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
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
    
    func show() {
        self.setupSubViews()
    }
    
    func setupSubViews() {
        // adding the background view
        if let window = UIApplication.shared.keyWindow {
            window.addSubview(backgroundView)
            UIView.animate(withDuration: 0.33, animations: {
                self.backgroundView.alpha = 1
            })
            // constraints
            backgroundView.topAnchor.constraint(equalTo: window.topAnchor).isActive = true
            backgroundView.leftAnchor.constraint(equalTo: window.leftAnchor).isActive = true
            backgroundView.rightAnchor.constraint(equalTo: window.rightAnchor).isActive = true
            backgroundView.bottomAnchor.constraint(equalTo: window.bottomAnchor).isActive = true
            
            // adding the container view
            setupContainerView(window: window)
        }
    }
    
    func setupContainerView(window: UIWindow) {
        window.addSubview(containerView)
        let height = window.frame.height * 0.6
        let y = window.frame.height - height
        containerView.frame = CGRect(x: 0, y: window.frame.height, width: window.frame.width, height: height)
        
        setupScrollView()
        setupServiceImageView()
        setupServiceTitleLabel()
        setupPaymentTypeLabel()
        setupPaymentModeLabel()
        setupStarRtatingView()
        setupServiceDescriptionLabel()
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.9, initialSpringVelocity: 1, options: .curveEaseIn, animations: {
            self.containerView.frame = CGRect(x: 0, y: y, width: self.containerView.frame.width, height: self.containerView.frame.height)
        }, completion: nil)
    }
    
    func setupScrollView() {
        containerView.addSubview(scrollView)
        scrollView.topAnchor.constraint(equalTo: containerView.topAnchor).isActive = true
        scrollView.leftAnchor.constraint(equalTo: containerView.leftAnchor).isActive = true
        scrollView.rightAnchor.constraint(equalTo: containerView.rightAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor).isActive = true
    }
    func setupServiceImageView() {
        scrollView.addSubview(serviceImageView)
        serviceImageView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 16).isActive = true
        serviceImageView.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 16).isActive = true
        serviceImageView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        serviceImageView.widthAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    func setupServiceTitleLabel() {
        scrollView.addSubview(serviceTitleLabel)
        serviceTitleLabel.leftAnchor.constraint(equalTo: serviceImageView.rightAnchor, constant: 10).isActive = true
        serviceTitleLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 16).isActive = true
        serviceTitleLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
    }
    
    func setupPaymentTypeLabel() {
        scrollView.addSubview(paymentTypeLabel)
        paymentTypeLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 16).isActive = true
        paymentTypeLabel.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: -16).isActive = true
    }
    
    func setupPaymentModeLabel() {
        scrollView.addSubview(paymentModeLabel)
        paymentModeLabel.centerYAnchor.constraint(equalTo: paymentTypeLabel.centerYAnchor).isActive = true
        paymentModeLabel.rightAnchor.constraint(equalTo: paymentTypeLabel.leftAnchor, constant: -5).isActive = true
    }
    
    func setupStarRtatingView() {
        scrollView.addSubview(starRatingView)
    }
    
    func setupServiceDescriptionLabel() {
        scrollView.addSubview(serviceDescriptionLabel)
        serviceDescriptionLabel.topAnchor.constraint(equalTo: serviceImageView.bottomAnchor, constant: 20).isActive = true
        serviceDescriptionLabel.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 16).isActive = true
        serviceDescriptionLabel.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: -16).isActive = true
    }
    
    @objc private func hide() {
        if let window = UIApplication.shared.keyWindow {
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.9, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                self.containerView.frame = CGRect(x: 0, y: window.frame.height, width: self.containerView.frame.width, height: self.containerView.frame.height)
                self.backgroundView.alpha = 0
            }, completion: nil)
        }
    }
    
    @objc func didChangeValue(_ sender: Any) {
        print(self.starRatingView.value)
    }
}

extension ServiceDetailsViewController : UIScrollViewDelegate {
    
}
