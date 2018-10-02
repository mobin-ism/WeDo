//
//  SPRegisterCompanyViewController.swift
//  WeDo
//
//  Created by Tanvir Hasan Piash on 15/9/18.
//  Copyright © 2018 Creativeitem. All rights reserved.
//

import UIKit

class SPRegisterCompanyViewController: UIViewController {
    
    lazy var menu: Menu = {
        let slideMenu = Menu()
        slideMenu.spRegisterCompanyVC = self
        return slideMenu
    }()
    
    lazy var companyButton : UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.clipsToBounds = true
        button.backgroundColor = UIColor(red:64/255, green:173/255, blue:93/255, alpha:0.9)
        button.setTitle("Company".localized(), for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = UIFont(name: OPENSANS_REGULAR, size: 12)
        button.tag = 1
        button.addTarget(self, action: #selector(navigationButtonTapped( _:)), for: .touchUpInside)
        return button
    }()
    
    lazy var addressButton : UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.clipsToBounds = true
        button.backgroundColor = UIColor(red:64/255, green:173/255, blue:93/255, alpha:0.9)
        button.setTitle("Address".localized(), for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = UIFont(name: OPENSANS_REGULAR, size: 12)
        button.tag = 2
        button.addTarget(self, action: #selector(navigationButtonTapped( _:)), for: .touchUpInside)
        return button
    }()
    
    lazy var dateTimeButton : UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.clipsToBounds = true
        button.backgroundColor = UIColor(red:64/255, green:173/255, blue:93/255, alpha:0.9)
        button.setTitle("Date & Time".localized(), for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = UIFont(name: OPENSANS_REGULAR, size: 12)
        button.tag = 3
        button.addTarget(self, action: #selector(navigationButtonTapped( _:)), for: .touchUpInside)
        return button
    }()
    
    lazy var servicesButton : UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.clipsToBounds = true
        button.backgroundColor = UIColor(red:64/255, green:173/255, blue:93/255, alpha:0.9)
        button.setTitle("Services".localized(), for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = UIFont(name: OPENSANS_REGULAR, size: 12)
        button.tag = 4
        button.addTarget(self, action: #selector(navigationButtonTapped( _:)), for: .touchUpInside)
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
    
    let backgroundImageView : UIImageView = {
        var imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .clear
        imageView.image = #imageLiteral(resourceName: "bigger-logo")
        return imageView
    }()
    
    let companyNameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = UIColor.black
        label.text = "Company Name".localized()
        label.font = UIFont(name: OPENSANS_REGULAR, size: 13)
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var companyNameTextField : PaddedTextField = {
        var textfield = PaddedTextField()
        textfield.translatesAutoresizingMaskIntoConstraints = false
        textfield.clipsToBounds = true
        textfield.placeholder = "Your company name".localized()
        textfield.layer.cornerRadius = 5
        textfield.layer.borderWidth = 1
        textfield.layer.borderColor = UIColor(red:0.62, green:0.62, blue:0.62, alpha:0.5).cgColor
        return textfield
    }()
    
    let companyMobileLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = UIColor.black
        label.text = "Company Mobile no.".localized()
        label.font = UIFont(name: OPENSANS_REGULAR, size: 13)
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var companyMobileTextField : PaddedTextField = {
        var textfield = PaddedTextField()
        textfield.translatesAutoresizingMaskIntoConstraints = false
        textfield.clipsToBounds = true
        textfield.placeholder = "Company mobile number".localized()
        textfield.layer.cornerRadius = 5
        textfield.layer.borderWidth = 1
        textfield.layer.borderColor = UIColor(red:0.62, green:0.62, blue:0.62, alpha:0.5).cgColor
        return textfield
    }()
    
    let companyPhoneLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = UIColor.black
        label.text = "Company Phone no.".localized()
        label.font = UIFont(name: OPENSANS_REGULAR, size: 13)
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var companyPhoneTextField : PaddedTextField = {
        var textfield = PaddedTextField()
        textfield.translatesAutoresizingMaskIntoConstraints = false
        textfield.clipsToBounds = true
        textfield.placeholder = "Company phone number".localized()
        textfield.layer.cornerRadius = 5
        textfield.layer.borderWidth = 1
        textfield.layer.borderColor = UIColor(red:0.62, green:0.62, blue:0.62, alpha:0.5).cgColor
        return textfield
    }()
    
    let companyEmailLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = UIColor.black
        label.text = "Company Email".localized()
        label.font = UIFont(name: OPENSANS_REGULAR, size: 13)
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var companyEmailTextField : PaddedTextField = {
        var textfield = PaddedTextField()
        textfield.translatesAutoresizingMaskIntoConstraints = false
        textfield.clipsToBounds = true
        textfield.placeholder = "Company email".localized()
        textfield.layer.cornerRadius = 5
        textfield.layer.borderWidth = 1
        textfield.layer.borderColor = UIColor(red:0.62, green:0.62, blue:0.62, alpha:0.5).cgColor
        return textfield
    }()
    
    let companyAddressLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = UIColor.black
        label.text = "Company Address".localized()
        label.font = UIFont(name: OPENSANS_REGULAR, size: 13)
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var companyAddressTextField : PaddedTextField = {
        var textfield = PaddedTextField()
        textfield.translatesAutoresizingMaskIntoConstraints = false
        textfield.clipsToBounds = true
        textfield.placeholder = "Company address".localized()
        textfield.layer.cornerRadius = 5
        textfield.layer.borderWidth = 1
        textfield.layer.borderColor = UIColor(red:0.62, green:0.62, blue:0.62, alpha:0.5).cgColor
        return textfield
    }()
    
    let companyLogoLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = UIColor.black
        label.text = "Company Logo".localized()
        label.font = UIFont(name: OPENSANS_REGULAR, size: 13)
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let companyIdLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = UIColor.black
        label.text = "ID".localized()
        label.font = UIFont(name: OPENSANS_REGULAR, size: 13)
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let companyLicenseLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = UIColor.black
        label.text = "Company License".localized()
        label.font = UIFont(name: OPENSANS_REGULAR, size: 13)
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let companyCertificateLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = UIColor.black
        label.text = "Chamber of Commerce Certificate".localized()
        label.font = UIFont(name: OPENSANS_REGULAR, size: 13)
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var logoAddButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("ADD".localized(), for: .normal)
        button.setTitleColor(GREENISH_COLOR, for: .normal)
        button.titleLabel?.font = UIFont(name: OPENSANS_REGULAR, size: 16)
        button.clipsToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 5
        button.layer.borderColor = GREENISH_COLOR.cgColor
        button.layer.borderWidth = 1
        button.tag = 1
        return button
    }()
    
    lazy var idAddButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("ADD".localized(), for: .normal)
        button.setTitleColor(GREENISH_COLOR, for: .normal)
        button.titleLabel?.font = UIFont(name: OPENSANS_REGULAR, size: 16)
        button.clipsToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 5
        button.layer.borderColor = GREENISH_COLOR.cgColor
        button.layer.borderWidth = 1
        button.tag = 2
        return button
    }()
    
    lazy var licenseAddButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("ADD".localized(), for: .normal)
        button.setTitleColor(GREENISH_COLOR, for: .normal)
        button.titleLabel?.font = UIFont(name: OPENSANS_REGULAR, size: 16)
        button.clipsToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 5
        button.layer.borderColor = GREENISH_COLOR.cgColor
        button.layer.borderWidth = 1
        button.tag = 3
        return button
    }()
    
    lazy var certificateAddButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("ADD".localized(), for: .normal)
        button.setTitleColor(GREENISH_COLOR, for: .normal)
        button.titleLabel?.font = UIFont(name: OPENSANS_REGULAR, size: 16)
        button.clipsToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 5
        button.layer.borderColor = GREENISH_COLOR.cgColor
        button.layer.borderWidth = 1
        button.tag = 4
        return button
    }()
    
    let logoInputView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.clear
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 5
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor(red:0.62, green:0.62, blue:0.62, alpha:0.5).cgColor
        return view
    }()
    
    let idInputView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.clear
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 5
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor(red:0.62, green:0.62, blue:0.62, alpha:0.5).cgColor
        return view
    }()
    
    let liceseInputView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.clear
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 5
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor(red:0.62, green:0.62, blue:0.62, alpha:0.5).cgColor
        return view
    }()
    
    let certificateInputView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.clear
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 5
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor(red:0.62, green:0.62, blue:0.62, alpha:0.5).cgColor
        return view
    }()
    
    lazy var nextButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("NEXT".localized(), for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.backgroundColor = GREENISH_COLOR
        button.titleLabel?.font = UIFont(name: OPENSANS_REGULAR, size: 16)
        button.clipsToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 5
        button.layer.borderColor = GREENISH_COLOR.cgColor
        button.layer.borderWidth = 1
        button.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        setNavigationBar()
        layout()
    }
    
    private func setNavigationBar() {
        navigationController?.navigationBar.barTintColor = NAVBAR_BG_COLOR
        let logo = UIImage(named: "logo.png")
        let imageView = UIImageView(image:logo)
        self.navigationItem.titleView = imageView
        //navigationItem.leftBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "back-icon"), style: .plain, target: self, action: #selector(backTapped))
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "menu"), style: .plain, target: self, action: #selector(menuIconTapped))
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
        companyButton.titleLabel?.font = UIFont(name: OPENSANS_BOLD, size: 12)
    }
    
    private func layout() {
        setupBackgroundImageView()
        setupCompanyButton()
        setupAddressButton()
        setupDateTimeButton()
        setupServicesButton()
        setupScrollView()
        setupCompanyNameLabel()
        setupCompanyNameTextField()
        setupCompanyMobileLabel()
        setupCompanyMobileTextField()
        setupCompanyPhoneLabel()
        setupCompanyPhoneTextField()
        setupCompanyEmailLabel()
        setupCompanyEmailTextField()
        setupCompanyAddressLabel()
        setupCompanyAddressTextField()
        setupCompanyLogoLabel()
        setupLogoInputView()
        setupLogoAddButton()
        setupCompanyIdLabel()
        setupIdInputView()
        setupIdAddButton()
        setupCompanyLicenseLabel()
        setupLicenseInputView()
        setupLicenseAddButton()
        setupCompanyCertificateLabel()
        setupCertificateInputView()
        setupCertificateAddButton()
        setupNextButton()
    }
    
    func setupBackgroundImageView() {
        view.addSubview(backgroundImageView)
        backgroundImageView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        backgroundImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 25).isActive = true
        backgroundImageView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.5).isActive = true
        backgroundImageView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8).isActive = true
    }
    
    func setupCompanyButton() {
        view.addSubview(companyButton)
        companyButton.topAnchor.constraint(equalTo: view.topAnchor, constant: Helper.barHeight+(self.navigationController?.navigationBar.frame.size.height)!).isActive = true
        companyButton.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        companyButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        companyButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.25).isActive = true
    }
    
    func setupAddressButton() {
        view.addSubview(addressButton)
        addressButton.topAnchor.constraint(equalTo: companyButton.topAnchor).isActive = true
        addressButton.leadingAnchor.constraint(equalTo: companyButton.trailingAnchor).isActive = true
        addressButton.heightAnchor.constraint(equalTo: companyButton.heightAnchor).isActive = true
        addressButton.widthAnchor.constraint(equalTo: companyButton.widthAnchor).isActive = true
    }
    
    func setupDateTimeButton() {
        view.addSubview(dateTimeButton)
        dateTimeButton.topAnchor.constraint(equalTo: companyButton.topAnchor).isActive = true
        dateTimeButton.leadingAnchor.constraint(equalTo: addressButton.trailingAnchor).isActive = true
        dateTimeButton.heightAnchor.constraint(equalTo: companyButton.heightAnchor).isActive = true
        dateTimeButton.widthAnchor.constraint(equalTo: companyButton.widthAnchor).isActive = true
    }
    
    func setupServicesButton() {
        view.addSubview(servicesButton)
        servicesButton.topAnchor.constraint(equalTo: companyButton.topAnchor).isActive = true
        servicesButton.leadingAnchor.constraint(equalTo: dateTimeButton.trailingAnchor).isActive = true
        servicesButton.heightAnchor.constraint(equalTo: companyButton.heightAnchor).isActive = true
        servicesButton.widthAnchor.constraint(equalTo: companyButton.widthAnchor).isActive = true
    }
    
    func setupScrollView() {
        view.addSubview(scrollView)
        scrollView.topAnchor.constraint(equalTo: companyButton.bottomAnchor).isActive = true
        scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    func setupCompanyNameLabel() {
        scrollView.addSubview(companyNameLabel)
        companyNameLabel.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16).isActive = true
        companyNameLabel.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 16).isActive = true
    }
    
    func setupCompanyNameTextField() {
        scrollView.addSubview(companyNameTextField)
        companyNameTextField.topAnchor.constraint(equalTo: companyNameLabel.bottomAnchor, constant: 10).isActive = true
        companyNameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        companyNameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
        companyNameTextField.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    func setupCompanyMobileLabel() {
        scrollView.addSubview(companyMobileLabel)
        companyMobileLabel.leadingAnchor.constraint(equalTo: companyNameLabel.leadingAnchor).isActive = true
        companyMobileLabel.topAnchor.constraint(equalTo: companyNameTextField.bottomAnchor, constant: 10).isActive = true
    }
    
    func setupCompanyMobileTextField() {
        scrollView.addSubview(companyMobileTextField)
        companyMobileTextField.topAnchor.constraint(equalTo: companyMobileLabel.bottomAnchor, constant: 10).isActive = true
        companyMobileTextField.leadingAnchor.constraint(equalTo: companyNameTextField.leadingAnchor).isActive = true
        companyMobileTextField.trailingAnchor.constraint(equalTo: companyNameTextField.trailingAnchor).isActive = true
        companyMobileTextField.heightAnchor.constraint(equalTo: companyNameTextField.heightAnchor).isActive = true
    }
    
    func setupCompanyPhoneLabel() {
        scrollView.addSubview(companyPhoneLabel)
        companyPhoneLabel.leadingAnchor.constraint(equalTo: companyNameLabel.leadingAnchor).isActive = true
        companyPhoneLabel.topAnchor.constraint(equalTo: companyMobileTextField.bottomAnchor, constant: 10).isActive = true
    }
    
    func setupCompanyPhoneTextField() {
        scrollView.addSubview(companyPhoneTextField)
        companyPhoneTextField.topAnchor.constraint(equalTo: companyPhoneLabel.bottomAnchor, constant: 10).isActive = true
        companyPhoneTextField.leadingAnchor.constraint(equalTo: companyNameTextField.leadingAnchor).isActive = true
        companyPhoneTextField.trailingAnchor.constraint(equalTo: companyNameTextField.trailingAnchor).isActive = true
        companyPhoneTextField.heightAnchor.constraint(equalTo: companyNameTextField.heightAnchor).isActive = true
    }
    
    func setupCompanyEmailLabel() {
        scrollView.addSubview(companyEmailLabel)
        companyEmailLabel.leadingAnchor.constraint(equalTo: companyNameLabel.leadingAnchor).isActive = true
        companyEmailLabel.topAnchor.constraint(equalTo: companyPhoneTextField.bottomAnchor, constant: 10).isActive = true
    }
    
    func setupCompanyEmailTextField() {
        scrollView.addSubview(companyEmailTextField)
        companyEmailTextField.topAnchor.constraint(equalTo: companyEmailLabel.bottomAnchor, constant: 10).isActive = true
        companyEmailTextField.leadingAnchor.constraint(equalTo: companyNameTextField.leadingAnchor).isActive = true
        companyEmailTextField.trailingAnchor.constraint(equalTo: companyNameTextField.trailingAnchor).isActive = true
        companyEmailTextField.heightAnchor.constraint(equalTo: companyNameTextField.heightAnchor).isActive = true
    }
    
    func setupCompanyAddressLabel() {
        scrollView.addSubview(companyAddressLabel)
        companyAddressLabel.leadingAnchor.constraint(equalTo: companyNameLabel.leadingAnchor).isActive = true
        companyAddressLabel.topAnchor.constraint(equalTo: companyEmailTextField.bottomAnchor, constant: 10).isActive = true
    }
    
    func setupCompanyAddressTextField() {
        scrollView.addSubview(companyAddressTextField)
        companyAddressTextField.topAnchor.constraint(equalTo: companyAddressLabel.bottomAnchor, constant: 10).isActive = true
        companyAddressTextField.leadingAnchor.constraint(equalTo: companyNameTextField.leadingAnchor).isActive = true
        companyAddressTextField.trailingAnchor.constraint(equalTo: companyNameTextField.trailingAnchor).isActive = true
        companyAddressTextField.heightAnchor.constraint(equalTo: companyNameTextField.heightAnchor).isActive = true
    }
    
    func setupCompanyLogoLabel() {
        scrollView.addSubview(companyLogoLabel)
        companyLogoLabel.leadingAnchor.constraint(equalTo: companyNameLabel.leadingAnchor).isActive = true
        companyLogoLabel.topAnchor.constraint(equalTo: companyAddressTextField.bottomAnchor, constant: 10).isActive = true
    }
    
    func setupLogoInputView() {
        scrollView.addSubview(logoInputView)
        logoInputView.topAnchor.constraint(equalTo: companyLogoLabel.bottomAnchor, constant: 10).isActive = true
        logoInputView.leadingAnchor.constraint(equalTo: companyNameTextField.leadingAnchor).isActive = true
        logoInputView.heightAnchor.constraint(equalTo: companyNameTextField.heightAnchor).isActive = true
        logoInputView.widthAnchor.constraint(equalTo: companyNameTextField.widthAnchor, multiplier: 0.7).isActive = true
    }
    
    func setupLogoAddButton() {
        scrollView.addSubview(logoAddButton)
        logoAddButton.leadingAnchor.constraint(equalTo: logoInputView.trailingAnchor, constant: 5).isActive = true
        logoAddButton.trailingAnchor.constraint(equalTo: companyNameTextField.trailingAnchor).isActive = true
        logoAddButton.centerYAnchor.constraint(equalTo: logoInputView.centerYAnchor).isActive = true
        logoAddButton.heightAnchor.constraint(equalTo: companyNameTextField.heightAnchor).isActive = true
    }
    
    func setupCompanyIdLabel() {
        scrollView.addSubview(companyIdLabel)
        companyIdLabel.leadingAnchor.constraint(equalTo: companyNameLabel.leadingAnchor).isActive = true
        companyIdLabel.topAnchor.constraint(equalTo: logoInputView.bottomAnchor, constant: 10).isActive = true
    }
    
    func setupIdInputView() {
        scrollView.addSubview(idInputView)
        idInputView.topAnchor.constraint(equalTo: companyIdLabel.bottomAnchor, constant: 10).isActive = true
        idInputView.leadingAnchor.constraint(equalTo: companyNameTextField.leadingAnchor).isActive = true
        idInputView.heightAnchor.constraint(equalTo: companyNameTextField.heightAnchor).isActive = true
        idInputView.widthAnchor.constraint(equalTo: companyNameTextField.widthAnchor, multiplier: 0.7).isActive = true
    }
    
    func setupIdAddButton() {
        scrollView.addSubview(idAddButton)
        idAddButton.leadingAnchor.constraint(equalTo: idInputView.trailingAnchor, constant: 5).isActive = true
        idAddButton.trailingAnchor.constraint(equalTo: companyNameTextField.trailingAnchor).isActive = true
        idAddButton.centerYAnchor.constraint(equalTo: idInputView.centerYAnchor).isActive = true
        idAddButton.heightAnchor.constraint(equalTo: companyNameTextField.heightAnchor).isActive = true
    }
    
    func setupCompanyLicenseLabel() {
        scrollView.addSubview(companyLicenseLabel)
        companyLicenseLabel.leadingAnchor.constraint(equalTo: companyNameLabel.leadingAnchor).isActive = true
        companyLicenseLabel.topAnchor.constraint(equalTo: idInputView.bottomAnchor, constant: 10).isActive = true
    }
    
    func setupLicenseInputView() {
        scrollView.addSubview(liceseInputView)
        liceseInputView.topAnchor.constraint(equalTo: companyLicenseLabel.bottomAnchor, constant: 10).isActive = true
        liceseInputView.leadingAnchor.constraint(equalTo: companyNameTextField.leadingAnchor).isActive = true
        liceseInputView.heightAnchor.constraint(equalTo: companyNameTextField.heightAnchor).isActive = true
        liceseInputView.widthAnchor.constraint(equalTo: companyNameTextField.widthAnchor, multiplier: 0.7).isActive = true
    }
    
    func setupLicenseAddButton() {
        scrollView.addSubview(licenseAddButton)
        licenseAddButton.leadingAnchor.constraint(equalTo: liceseInputView.trailingAnchor, constant: 5).isActive = true
        licenseAddButton.trailingAnchor.constraint(equalTo: companyNameTextField.trailingAnchor).isActive = true
        licenseAddButton.centerYAnchor.constraint(equalTo: liceseInputView.centerYAnchor).isActive = true
        licenseAddButton.heightAnchor.constraint(equalTo: companyNameTextField.heightAnchor).isActive = true
    }
    
    func setupCompanyCertificateLabel() {
        scrollView.addSubview(companyCertificateLabel)
        companyCertificateLabel.leadingAnchor.constraint(equalTo: companyNameLabel.leadingAnchor).isActive = true
        companyCertificateLabel.topAnchor.constraint(equalTo: liceseInputView.bottomAnchor, constant: 10).isActive = true
    }
    
    func setupCertificateInputView() {
        scrollView.addSubview(certificateInputView)
        certificateInputView.topAnchor.constraint(equalTo: companyCertificateLabel.bottomAnchor, constant: 10).isActive = true
        certificateInputView.leadingAnchor.constraint(equalTo: companyNameTextField.leadingAnchor).isActive = true
        certificateInputView.heightAnchor.constraint(equalTo: companyNameTextField.heightAnchor).isActive = true
        certificateInputView.widthAnchor.constraint(equalTo: companyNameTextField.widthAnchor, multiplier: 0.7).isActive = true
    }
    
    func setupCertificateAddButton() {
        scrollView.addSubview(certificateAddButton)
        certificateAddButton.leadingAnchor.constraint(equalTo: certificateInputView.trailingAnchor, constant: 5).isActive = true
        certificateAddButton.trailingAnchor.constraint(equalTo: companyNameTextField.trailingAnchor).isActive = true
        certificateAddButton.centerYAnchor.constraint(equalTo: certificateInputView.centerYAnchor).isActive = true
        certificateAddButton.heightAnchor.constraint(equalTo: companyNameTextField.heightAnchor).isActive = true
    }
    
    func setupNextButton() {
        scrollView.addSubview(nextButton)
        nextButton.topAnchor.constraint(equalTo: certificateInputView.bottomAnchor, constant: 16).isActive = true
        nextButton.leadingAnchor.constraint(equalTo: companyNameTextField.leadingAnchor).isActive = true
        nextButton.trailingAnchor.constraint(equalTo: companyNameTextField.trailingAnchor).isActive = true
        nextButton.heightAnchor.constraint(equalTo: companyNameTextField.heightAnchor).isActive = true
    }
    
    @objc func nextButtonTapped() {
        let destination = SPRegisterAddressViewController()
        navigationController?.pushViewController(destination, animated: true)
    }
    
    @objc private func navigationButtonTapped(_ sender: UIButton) {
        switch sender.tag {
        case 2:
            navigationController?.pushViewController(SPRegisterAddressViewController(), animated: false)
        case 3:
            navigationController?.pushViewController(SPRegisterDateTimeViewController(), animated: false)
        case 4:
            navigationController?.pushViewController(SPRegisterServicesViewController(), animated: false)
        default:
            print("current view controller")
        }
    }
    
    @objc private func menuIconTapped() {
        self.menu.show(self)
    }
    
    public func selectedViewControllerFromMenu(indexNumber : Int) {
        if  UserDefaults.standard.value(forKey: IS_SERVICE_PROVIDER) as! Bool == true {
            switch indexNumber {
            case 0:
                self.navigationController?.pushViewController(SPCurrentJobsViewController(), animated: true)
            case 1:
                self.navigationController?.pushViewController(SPCurrentJobsViewController(), animated: true)
            case 2:
                self.navigationController?.pushViewController(SPProfileViewController(), animated: true)
            case 3:
                self.navigationController?.pushViewController(SPServiceHistoryViewController(), animated: true)
            case 4:
                self.navigationController?.pushViewController(SPContactViewController(), animated: true)
            case 5:
                Alert.logOutConfirmationAlert(on: self)
            default:
                print("Wrong Index")
            }
        } else {
            switch indexNumber {
            case 0:
                self.navigationController?.pushViewController(HomeViewController(), animated: true)
            case 1:
                self.navigationController?.pushViewController(HelpAndFAQViewController(), animated: true)
            case 2:
                self.navigationController?.pushViewController(ContactUsViewController(), animated: true)
            case 3:
                self.navigationController?.pushViewController(LoginViewController(), animated: true)
            default:
                print("Wrong Index")
            }
        }
    }
    
}

extension SPRegisterCompanyViewController: UIScrollViewDelegate {
    
}
