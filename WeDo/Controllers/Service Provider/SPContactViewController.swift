//
//  SPContactViewController.swift
//  WeDo
//
//  Created by Tanvir Hasan Piash on 21/9/18.
//  Copyright © 2018 Creativeitem. All rights reserved.
//

import UIKit

class SPContactViewController: UIViewController {
    
    let backgroundImageView : UIImageView = {
        var imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .clear
        imageView.image = #imageLiteral(resourceName: "bigger-logo")
        return imageView
    }()
    
    lazy var textView: UITextView = {
        let view = UITextView()
        view.text = "If you have any queries please let us know".localized()
        view.backgroundColor = UIColor.clear
        view.textColor = UIColor.lightGray
        view.textAlignment = .left
        view.font = UIFont(name: OPENSANS_REGULAR, size: 12)
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.borderColor = UIColor.init(white: 0.9, alpha: 0.9).cgColor
        view.layer.borderWidth = 1
        view.layer.cornerRadius = 5
        view.delegate = self
        return view
    }()
    
    lazy var submitButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("SUBMIT".localized(), for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.backgroundColor = GREENISH_COLOR
        button.titleLabel?.font = UIFont(name: OPENSANS_REGULAR, size: 16)
        button.clipsToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 5
        button.layer.borderColor = GREENISH_COLOR.cgColor
        button.layer.borderWidth = 1
        button.addTarget(self, action: #selector(submitButtonTapped), for: .touchUpInside)
        return button
    }()
    
    let emailLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = GREENISH_COLOR
        label.text = "Email".localized()
        label.font = UIFont(name: OPENSANS_BOLD, size: 14)
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let phoneLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = GREENISH_COLOR
        label.text = "Phone no.".localized()
        label.font = UIFont(name: OPENSANS_BOLD, size: 14)
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let addressLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = GREENISH_COLOR
        label.text = "Address".localized()
        label.font = UIFont(name: OPENSANS_BOLD, size: 14)
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let emailValue: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = UIColor.black
        label.font = UIFont(name: OPENSANS_REGULAR, size: 14)
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let phoneValue: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = UIColor.black
        label.font = UIFont(name: OPENSANS_REGULAR, size: 14)
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let addressValue: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = UIColor.black
        label.font = UIFont(name: OPENSANS_REGULAR, size: 14)
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var menu: Menu = {
        let slideMenu = Menu()
        slideMenu.spContactVC = self
        return slideMenu
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        setNavigationBar()
        layout()
        
        getContactInfo()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        Alert.checkInternetConnection(on: self)
    }
    
    private func setNavigationBar() {
        navigationController?.navigationBar.barTintColor = NAVBAR_BG_COLOR
        let logo = UIImage(named: "logo.png")
        let imageView = UIImageView(image:logo)
        self.navigationItem.titleView = imageView
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "menu"), style: .plain, target: self, action: #selector(menuIconTapped))
    }
    
    @objc func menuIconTapped() {
        self.menu.show(self)
    }
    
    private func layout() {
        setupBackgroundImageView()
        setupTextView()
        setupSubmitButton()
        setupEmailLabel()
        setupEmailValue()
        setupPhoneLabel()
        setupPhoneValue()
        setupAddressLabel()
        setupAddressValue()
    }
    
    func setupBackgroundImageView() {
        view.addSubview(backgroundImageView)
        backgroundImageView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        backgroundImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 25).isActive = true
        backgroundImageView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.5).isActive = true
        backgroundImageView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8).isActive = true
    }
    
    func setupTextView() {
        view.addSubview(textView)
        NSLayoutConstraint.activate([
            textView.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            textView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            textView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            textView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.3)
        ])
    }
    
    func setupSubmitButton() {
        view.addSubview(submitButton)
        NSLayoutConstraint.activate([
            submitButton.leadingAnchor.constraint(equalTo: textView.leadingAnchor),
            submitButton.trailingAnchor.constraint(equalTo: textView.trailingAnchor),
            submitButton.topAnchor.constraint(equalTo: textView.bottomAnchor, constant: 16),
            submitButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    func setupEmailLabel() {
        view.addSubview(emailLabel)
        NSLayoutConstraint.activate([
            emailLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            emailLabel.topAnchor.constraint(equalTo: submitButton.bottomAnchor, constant: 16)
        ])
    }
    
    func setupEmailValue() {
        view.addSubview(emailValue)
        NSLayoutConstraint.activate([
            emailValue.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            emailValue.topAnchor.constraint(equalTo: emailLabel.bottomAnchor, constant: 4)
        ])
    }
    
    func setupPhoneLabel() {
        view.addSubview(phoneLabel)
        NSLayoutConstraint.activate([
            phoneLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            phoneLabel.topAnchor.constraint(equalTo: emailValue.bottomAnchor, constant: 10)
        ])
    }
    
    func setupPhoneValue() {
        view.addSubview(phoneValue)
        NSLayoutConstraint.activate([
            phoneValue.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            phoneValue.topAnchor.constraint(equalTo: phoneLabel.bottomAnchor, constant: 4)
        ])
    }
    
    func setupAddressLabel() {
        view.addSubview(addressLabel)
        NSLayoutConstraint.activate([
            addressLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            addressLabel.topAnchor.constraint(equalTo: phoneValue.bottomAnchor, constant: 10)
        ])
    }
    
    func setupAddressValue() {
        view.addSubview(addressValue)
        NSLayoutConstraint.activate([
            addressValue.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            addressValue.topAnchor.constraint(equalTo: addressLabel.bottomAnchor, constant: 4)
        ])
    }
    
    @objc private func submitButtonTapped() {
        
    }
    
    public func selectedViewControllerFromMenu(indexNumber : Int) {
        if  UserDefaults.standard.value(forKey: IS_SERVICE_PROVIDER) as! Bool == true {
            switch indexNumber {
            case 0:
                self.navigationController?.pushViewController(SPCurrentJobsViewController(), animated: true)
            case 1:
                self.navigationController?.pushViewController(SPCurrentJobsViewController(), animated: true)
            case 2:
                navigationController?.pushViewController(SPProfileViewController(), animated: true)
            case 3:
                self.navigationController?.pushViewController(SPServiceHistoryViewController(), animated: true)
            case 4:
                print("current page")
            case 5:
                Alert.logOutConfirmationAlert(on: self)
            default:
                print("Wrong Index")
            }
        }
    }
    
}

extension SPContactViewController: UITextViewDelegate {
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.text = nil
            textView.textColor = UIColor.black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "If you have any queries please let us know".localized()
            textView.textColor = UIColor.lightGray
        }
    }
    
}

extension SPContactViewController {
    
    func getContactInfo() {
        guard let url = URL(string: "\(BASE_URL)api/v2/general/contact-us") else { return }
        HTTPRequestHandler.makeGetHttpRequest(url: url, parameter: [:]) { (response, error) in
            guard let response = response else { return }
            if let json = response.data {
                let decoder = JSONDecoder()
                do {
                    let contactInfo = try decoder.decode(SPContactModel.self, from: json)
                    if contactInfo.isSuccess {
                        self.emailValue.text = contactInfo.data.contact.email
                        self.phoneValue.text = contactInfo.data.contact.phoneNumber
                        self.addressValue.text = contactInfo.data.contact.address
                    }
                } catch let err {
                    print(err.localizedDescription)
                }
            }
        }
    }
    
}
