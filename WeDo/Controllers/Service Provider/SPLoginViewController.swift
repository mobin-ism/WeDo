//
//  SPLoginViewController.swift
//  WeDo
//
//  Created by Tanvir Hasan Piash on 15/9/18.
//  Copyright © 2018 Creativeitem. All rights reserved.
//

import UIKit
import Alamofire
import SVProgressHUD

class SPLoginViewController: UIViewController {
    
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
    
    let loginLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = UIColor.black
        label.text = "Login as Service Provider".localized()
        label.font = UIFont(name: OPENSANS_REGULAR, size: 18)
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        return label
    }()
    
    let phoneNumberLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = UIColor.black
        label.text = "Phone Number".localized()
        label.font = UIFont(name: OPENSANS_REGULAR, size: 13)
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var phoneNumberTextField : PaddedTextField = {
        var textfield = PaddedTextField()
        textfield.translatesAutoresizingMaskIntoConstraints = false
        textfield.clipsToBounds = true
        textfield.placeholder = "Your Phone No.".localized()
        textfield.layer.cornerRadius = 5
        textfield.layer.borderWidth = 1
        textfield.layer.borderColor = UIColor(red:0.62, green:0.62, blue:0.62, alpha:0.5).cgColor
        return textfield
    }()
    
    lazy var loginButton : UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.clipsToBounds = true
        button.backgroundColor = UIColor(red:0.17, green:0.67, blue:0.31, alpha:1.0)
        button.setTitle("LOGIN".localized(), for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = UIFont(name: OPENSANS_REGULAR, size: 15)
        button.layer.cornerRadius = 5
        button.addTarget(self, action: #selector(handleLoginButton), for: .touchUpInside)
        return button
    }()
    
    let dontHaveAccountLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.text = "Don't Have And Account?".localized()
        label.font = UIFont(name: OPENSANS_REGULAR, size: 15)
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        label.textColor = UIColor.lightGray
        return label
    }()
    
    lazy var registerLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = UIColor.black
        label.attributedText = NSAttributedString(string: "Register".localized(), attributes:[.underlineStyle: NSUnderlineStyle.styleSingle.rawValue])
        label.font = UIFont(name: OPENSANS_REGULAR, size: 15)
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        label.isUserInteractionEnabled = true
        label.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(registerTapped)))
        return label
    }()
    
    let neverPostLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.text = "We will never post anything without your permission".localized()
        label.font = UIFont(name: OPENSANS_REGULAR, size: 11)
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        label.textColor = UIColor.lightGray
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        setNavigationBar()
        layout()
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
        setupLoginLabel()
        setupPhoneLabel()
        setupPhoneNumberTextField()
        setupLoginButton()
        setupDontHaveAnAccountLabel()
        setupRegisterLabel()
        setupNeverPostLabel()
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
    
    func setupLoginLabel() {
        scrollView.addSubview(loginLabel)
        loginLabel.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        loginLabel.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 16).isActive = true
    }
    func setupPhoneLabel() {
        scrollView.addSubview(phoneNumberLabel)
        phoneNumberLabel.topAnchor.constraint(equalTo: loginLabel.bottomAnchor, constant: 16).isActive = true
        phoneNumberLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16).isActive = true
    }
    func setupPhoneNumberTextField() {
        scrollView.addSubview(phoneNumberTextField)
        phoneNumberTextField.topAnchor.constraint(equalTo: phoneNumberLabel.bottomAnchor, constant: 10).isActive = true
        phoneNumberTextField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16).isActive = true
        phoneNumberTextField.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16).isActive = true
        phoneNumberTextField.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    func setupLoginButton() {
        scrollView.addSubview(loginButton)
        loginButton.topAnchor.constraint(equalTo: phoneNumberTextField.bottomAnchor, constant: 16).isActive = true
        loginButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16).isActive = true
        loginButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16).isActive = true
        loginButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    func setupDontHaveAnAccountLabel() {
        scrollView.addSubview(dontHaveAccountLabel)
        dontHaveAccountLabel.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 20).isActive = true
        dontHaveAccountLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: -30).isActive = true
    }
    
    func setupRegisterLabel() {
        scrollView.addSubview(registerLabel)
        registerLabel.centerYAnchor.constraint(equalTo: dontHaveAccountLabel.centerYAnchor).isActive = true
        registerLabel.leftAnchor.constraint(equalTo: dontHaveAccountLabel.rightAnchor, constant: 5).isActive = true
    }
    
    func setupNeverPostLabel() {
        scrollView.addSubview(neverPostLabel)
        neverPostLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        neverPostLabel.topAnchor.constraint(equalTo: dontHaveAccountLabel.bottomAnchor, constant: 8).isActive = true
    }
    
    @objc private func backTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc private func registerTapped() {
        navigationController?.pushViewController(SPRegisterViewController(), animated: true)
    }
    
    @objc private func handleLoginButton() {
        if phoneNumberTextField.text == "" {
            Alert.showBasicAlert(on: self, with: "Error".localized(), message: "Please enter a phone number".localized())
            return
        }
        attemptSPLogin(phoneNumber: phoneNumberTextField.text!)
        //navigationController?.pushViewController(SPLoginVerifyViewController(), animated: true)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
}

extension SPLoginViewController: UIScrollViewDelegate {
    
}

extension SPLoginViewController {
    
    func attemptSPLogin(phoneNumber: String) {
        SVProgressHUD.setDefaultMaskType(.black)
        SVProgressHUD.show(withStatus: "Please Wait...")
        
        guard let url = URL(string: "\(BASE_URL)api/v2/agent/register") else { return }
        let params = ["PhoneNumber" : "\(phoneNumber)",
                        "CityId" : UserDefaults.standard.value(forKey: AREA_ID) as! Int,
                        "CompanyName": "",
                        "CompanyEmail": "",
                        "CompanyAddress": "",
                        "CompanyPhone": "",
                        "Latitude": "",
                        "Longitude": "",
                        "Address": ""]
            as [String : Any]
        Alamofire.request(url, method: .post, parameters: params, encoding: URLEncoding.default, headers: ["Content-Type" : "application/x-www-form-urlencoded", "Authorization": AUTH_KEY]).responseJSON { (response) in
            guard response.result.isSuccess else {
                print(response)
                SVProgressHUD.dismiss()
                return
            }
            if let json = response.data {
                let decoder = JSONDecoder()
                do {
                    let serviceProviderInfo = try decoder.decode(ServiceProviderModel.self, from: json)
                    if serviceProviderInfo.isSuccess {
                        let spLoginVerifyVC = SPLoginVerifyViewController()
                        spLoginVerifyVC.verificationCode = serviceProviderInfo.data.agent.token
                        spLoginVerifyVC.id = serviceProviderInfo.data.agent.id
                        spLoginVerifyVC.phoneNumber = serviceProviderInfo.data.agent.phoneNumber
                        SVProgressHUD.dismiss()
                        self.navigationController?.pushViewController(spLoginVerifyVC, animated: true)
                    } else {
                        SVProgressHUD.dismiss()
                        Alert.showBasicAlert(on: self, with: "Invalid Phone Number".localized(), message: "Please login with a valid phone number".localized())
                    }
                } catch let err {
                    SVProgressHUD.dismiss()
                    print(err.localizedDescription)
                }
            }
        }
    }
    
}
