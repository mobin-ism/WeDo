//
//  SPLoginVerifyViewController.swift
//  WeDo
//
//  Created by Tanvir Hasan Piash on 16/9/18.
//  Copyright © 2018 Creativeitem. All rights reserved.
//

import UIKit
import Alamofire
import SVProgressHUD

class SPLoginVerifyViewController: UIViewController {
    
    let backgroundImageView : UIImageView = {
        var imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .clear
        imageView.image = #imageLiteral(resourceName: "bigger-logo")
        return imageView
    }()
    
    let provideLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.black
        label.textAlignment = .center
        label.text = "Provide your verification code".localized()
        label.font = UIFont(name: OPENSANS_REGULAR, size: 18)
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var codeTextField : PaddedTextField = {
        var textfield = PaddedTextField()
        textfield.translatesAutoresizingMaskIntoConstraints = false
        textfield.clipsToBounds = true
        textfield.layer.cornerRadius = 5
        textfield.layer.borderWidth = 1
        textfield.layer.borderColor = UIColor(red:0.62, green:0.62, blue:0.62, alpha:0.5).cgColor
        textfield.textAlignment = .center
        textfield.keyboardType = .numberPad
        return textfield
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
    
    lazy var menu: Menu = {
        let slideMenu = Menu()
        slideMenu.spLoginVerifyVC = self
        return slideMenu
    }()
    
    var verificationCode: String = ""
    var id: Int = 0
    var phoneNumber: String = ""
    
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
        codeTextField.text = verificationCode
    }
    
    private func setNavigationBar() {
        navigationController?.navigationBar.barTintColor = NAVBAR_BG_COLOR
        let logo = UIImage(named: "logo.png")
        let imageView = UIImageView(image:logo)
        self.navigationItem.titleView = imageView
        //navigationItem.leftBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "back-icon"), style: .plain, target: self, action: #selector(backTapped))
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "menu"), style: .plain, target: self, action: #selector(menuIconTapped))
    }
    
    func layout() {
        setupBackgroundImageView()
        setupCodeTextField()
        setupProvideLabel()
        setupSubmitButton()
    }
    
    func setupBackgroundImageView() {
        view.addSubview(backgroundImageView)
        backgroundImageView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        backgroundImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 25).isActive = true
        backgroundImageView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.5).isActive = true
        backgroundImageView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8).isActive = true
    }
    
    func setupCodeTextField() {
        view.addSubview(codeTextField)
        codeTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        codeTextField.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        codeTextField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9).isActive = true
        codeTextField.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    func setupProvideLabel() {
        view.addSubview(provideLabel)
        provideLabel.bottomAnchor.constraint(equalTo: codeTextField.topAnchor, constant: -16).isActive = true
        provideLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8).isActive = true
        provideLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8).isActive = true
    }
    
    func setupSubmitButton() {
        view.addSubview(submitButton)
        submitButton.topAnchor.constraint(equalTo: codeTextField.bottomAnchor, constant: 10).isActive = true
        submitButton.leadingAnchor.constraint(equalTo: codeTextField.leadingAnchor).isActive = true
        submitButton.trailingAnchor.constraint(equalTo: codeTextField.trailingAnchor).isActive = true
        submitButton.heightAnchor.constraint(equalTo: codeTextField.heightAnchor).isActive = true
    }
    
    @objc private func submitButtonTapped() {
        if codeTextField.text == "" {
            Alert.showBasicAlert(on: self, with: "Error".localized(), message: "Please enter verification code".localized())
            return
        }
        verifySecurityCode(code: codeTextField.text!)
        
//        navigationController?.pushViewController(SPHomeViewController(), animated: true)
    }
    
    @objc private func menuIconTapped() {
        self.menu.show(self)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    public func selectedViewControllerFromMenu(indexNumber : Int) {
        if  UserDefaults.standard.value(forKey: IS_LOGGED_IN) as! Bool {
            switch indexNumber {
            case 0:
                self.navigationController?.pushViewController(HomeViewController(), animated: true)
            case 1:
                self.navigationController?.pushViewController(ActiveOrderViewController(), animated: true)
            case 2:
                self.navigationController?.pushViewController(NotificationViewController(), animated: true)
            case 3:
                self.navigationController?.pushViewController(OrderHistoryViewController(), animated: true)
            case 4:
                self.navigationController?.pushViewController(HelpAndFAQViewController(), animated: true)
            case 5:
                self.navigationController?.pushViewController(ContactUsViewController(), animated: true)
            case 6:
                self.navigationController?.pushViewController(EditProfileViewController(), animated: true)
            case 7:
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

extension SPLoginVerifyViewController {
    
    func verifySecurityCode(code: String) {
        SVProgressHUD.setDefaultMaskType(.black)
        SVProgressHUD.show(withStatus: "Please Wait...")
        
        guard let url = URL(string: "\(BASE_URL)api/v2/agent/register/token/submit") else { return }
        let params = ["AgentId" : "\(id)",
            "SecurityKey" : "\(code)"]
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
                        let spHome = SPCurrentJobsViewController()
                        spHome.serviceProviderInfo = serviceProviderInfo
                        UserDefaults.standard.set(true, forKey: IS_LOGGED_IN)
                        UserDefaults.standard.set(true, forKey: IS_SERVICE_PROVIDER)
                        UserDefaults.standard.set(serviceProviderInfo.data.agent.id, forKey: SERVICE_PROVIDER_ID)
                        UserDefaults.standard.set(serviceProviderInfo.data.agent.companyName, forKey: COMPANY_NAME)
                        SVProgressHUD.dismiss()
                        self.navigationController?.pushViewController(spHome, animated: true)
                    } else {
                        SVProgressHUD.dismiss()
                        Alert.showBasicAlert(on: self, with: "Invalid Security Code".localized(), message: "Please enter the correct code".localized())
                    }
                } catch let err {
                    SVProgressHUD.dismiss()
                    print(err.localizedDescription)
                }
            }
        }
    }
    
}
