//
//  LoginViewController.swift
//  WeDo
//
//  Created by Creativeitem on 26/7/18.
//  Copyright © 2018 Creativeitem. All rights reserved.
//

import UIKit
import Alamofire
import SVProgressHUD

class LoginViewController: UIViewController {
    var isImageSelected : Bool = false
    var imageArray : [UIImage] = []
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
        label.text = "Login As Customer".localized()
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
    
    let phoneNumberTextField : PaddedTextField = {
        var textfield = PaddedTextField()
        textfield.translatesAutoresizingMaskIntoConstraints = false
        textfield.clipsToBounds = true
        textfield.placeholder = "Your Phone No."
        textfield.layer.cornerRadius = 5
        textfield.layer.borderWidth = 1
        textfield.layer.borderColor = UIColor(red:0.62, green:0.62, blue:0.62, alpha:0.5).cgColor
        return textfield
    }()
    
    lazy var loginButton : UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.clipsToBounds = true
        button.backgroundColor = UIColor(red:0.17, green:0.67, blue:0.31, alpha:1.0)
        button.setTitle("LOGIN", for: .normal)
        button.titleLabel?.font = UIFont(name: OPENSANS_REGULAR, size: 15)
        button.layer.cornerRadius = 5
        button.addTarget(self, action: #selector(handleLoginButton), for: .touchUpInside)
        return button
    }()
    
    let dontHaveAccountLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = UIColor.black
        label.text = "Don't Have And Account?"
        label.font = UIFont(name: OPENSANS_REGULAR, size: 15)
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        label.textColor = UIColor.lightGray
        return label
    }()
    
    let registerLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = UIColor.black
        label.attributedText = NSAttributedString(string: "Register now".localized(), attributes:[.underlineStyle: NSUnderlineStyle.styleSingle.rawValue])
        label.font = UIFont(name: OPENSANS_REGULAR, size: 15)
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        label.isUserInteractionEnabled = true
        return label
    }()
    
    lazy var leftHorizontalLine : UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        view.backgroundColor = UIColor(red:0.62, green:0.62, blue:0.62, alpha:0.5)
        return view
    }()
    
    lazy var rightHorizontalLine : UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        view.backgroundColor = UIColor(red:0.62, green:0.62, blue:0.62, alpha:0.5)
        return view
    }()
    
    lazy var orLabel : UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.clipsToBounds = true
        label.textAlignment = .center
        label.text = "OR"
        label.numberOfLines = 0
        label.textColor = UIColor.black
        label.font = UIFont(name: OPENSANS_REGULAR, size: 15)
        return label
    }()
    
    let serviceProviderLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = UIColor.black
        label.text = "Service Provider".localized()
        label.font = UIFont(name: OPENSANS_REGULAR, size: 15)
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        return label
    }()
    
    let spDividerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.lightGray
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var spLoginLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.text = "Login".localized()
        label.font = UIFont(name: OPENSANS_REGULAR, size: 13)
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        label.textColor = UIColor.lightGray
        label.isUserInteractionEnabled = true
        label.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(spLoginTapped)))
        return label
    }()
    
    lazy var spRegisterLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .right
        label.text = "Register".localized()
        label.font = UIFont(name: OPENSANS_REGULAR, size: 13)
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        label.textColor = UIColor.lightGray
        label.isUserInteractionEnabled = true
        label.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(spRegisterTapped)))
        return label
    }()
    
    lazy var menu: Menu = {
        let slideMenu = Menu()
        slideMenu.loginVC = self
        return slideMenu
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        setNavigationBar()
        layout()
        
        self.phoneNumberTextField.delegate = self
        
        // tap gesture on login label
        let tap = UITapGestureRecognizer(target: self, action: #selector(register))
        self.registerLabel.addGestureRecognizer(tap)
        
        // Adding outside tap will dismiss the keyboard
        let backgorundTap: UITapGestureRecognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(dismissKeyboard))
        view.addGestureRecognizer(backgorundTap)
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
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "menu"), style: .plain, target: self, action: #selector(menuIconTapped))
    }
    
    func layout() {
        setupBackgroundImageView()
        setupScrollView()
        setupLoginLabel()
        setupPhoneLabel()
        setupPhoneNumberTextField()
        setupLoginButton()
        setupDontHaveAnAccountLabel()
        setupRegisterLabel()
        setupOrLabel()
        setupLeftHorizontalLine()
        setupRighttHorizontalLine()
        setupServiceProvideLabel()
        setupSpDividerView()
        setupSpLoginLabel()
        setupSpRegisterLabel()
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
    
    func setupOrLabel() {
        scrollView.addSubview(orLabel)
        orLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        orLabel.topAnchor.constraint(equalTo: dontHaveAccountLabel.bottomAnchor, constant: 40).isActive = true
    }
    
    func setupLeftHorizontalLine() {
        scrollView.addSubview(leftHorizontalLine)
        leftHorizontalLine.centerYAnchor.constraint(equalTo: orLabel.centerYAnchor).isActive = true
        leftHorizontalLine.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 40).isActive = true
        leftHorizontalLine.rightAnchor.constraint(equalTo: orLabel.leftAnchor, constant: -16).isActive = true
        leftHorizontalLine.heightAnchor.constraint(equalToConstant: 1).isActive = true
    }
    
    func setupRighttHorizontalLine() {
        scrollView.addSubview(rightHorizontalLine)
        rightHorizontalLine.centerYAnchor.constraint(equalTo: orLabel.centerYAnchor).isActive = true
        rightHorizontalLine.leftAnchor.constraint(equalTo: orLabel.rightAnchor, constant: 16).isActive = true
        rightHorizontalLine.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -40).isActive = true
        rightHorizontalLine.heightAnchor.constraint(equalToConstant: 1).isActive = true
    }
    
    func setupServiceProvideLabel() {
        scrollView.addSubview(serviceProviderLabel)
        serviceProviderLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        serviceProviderLabel.topAnchor.constraint(equalTo: orLabel.bottomAnchor, constant: 40).isActive = true
    }
    
    func setupSpDividerView() {
        scrollView.addSubview(spDividerView)
        spDividerView.centerXAnchor.constraint(equalTo: serviceProviderLabel.centerXAnchor).isActive = true
        spDividerView.topAnchor.constraint(equalTo: serviceProviderLabel.bottomAnchor, constant: 16).isActive = true
        spDividerView.widthAnchor.constraint(equalToConstant: 1).isActive = true
        spDividerView.heightAnchor.constraint(equalToConstant: 16).isActive = true
        
    }
    
    func setupSpLoginLabel() {
        scrollView.addSubview(spLoginLabel)
        spLoginLabel.centerYAnchor.constraint(equalTo: spDividerView.centerYAnchor).isActive = true
        spLoginLabel.leadingAnchor.constraint(equalTo: serviceProviderLabel.leadingAnchor, constant: 0).isActive = true
    }
    
    func setupSpRegisterLabel() {
        scrollView.addSubview(spRegisterLabel)
        spRegisterLabel.centerYAnchor.constraint(equalTo: spDividerView.centerYAnchor).isActive = true
        spRegisterLabel.trailingAnchor.constraint(equalTo: serviceProviderLabel.trailingAnchor, constant: 0).isActive = true
    }
    
    @objc private func spLoginTapped() {
        navigationController?.pushViewController(SPLoginViewController(), animated: true)
    }
    
    @objc private func spRegisterTapped() {
        navigationController?.pushViewController(SPRegisterViewController(), animated: true)
    }
    
    @objc func menuIconTapped() {
        self.menu.show(self)
    }
        
    @objc func dismissKeyboard(){
        view.endEditing(true)
    }
    
    @objc func register() {
        let registerVC = RegisterViewController()
        registerVC.isImageSelected = self.isImageSelected
        registerVC.imageArray = self.imageArray
        self.navigationController?.pushViewController(registerVC, animated: true)
    }
    
    @objc func handleLoginButton() {
        if let phoneNumber = self.phoneNumberTextField.text {
            if phoneNumber != "" {
                self.login(phoneNumber: phoneNumber)
            }else {
                Alert.showBasicAlert(on: self, with: "Fill all the fields", message: "Please fill all the fields to login")
            }
        }
    }
    
    public func selectedViewControllerFromMenu(indexNumber : Int) {
        if  UserDefaults.standard.value(forKey: IS_LOGGED_IN) as! Bool {
            switch indexNumber {
            case 0:
                self.navigationController?.pushViewController(HomeViewController(), animated: false)
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
        }else {
            switch indexNumber {
            case 0:
                self.navigationController?.pushViewController(HomeViewController(), animated: false)
            case 1:
                self.navigationController?.pushViewController(HelpAndFAQViewController(), animated: true)
            case 2:
                self.navigationController?.pushViewController(ContactUsViewController(), animated: true)
            case 3:
                print("Current view controller")
            default:
                print("Wrong Index")
            }
        }
    }
}

extension LoginViewController : UIScrollViewDelegate {
    
}

extension LoginViewController : UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        if textField == self.phoneNumberTextField {
            
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        scrollView.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        view.resignFirstResponder()
        return true
        
    }
}

//API CALLS
extension LoginViewController {
    func login(phoneNumber : String) {
        guard let url = URL(string: "\(BASE_URL)api/v2/member/register") else { return }
        let params = ["PhoneNumber" : "\(phoneNumber)",
                      "CityId" : UserDefaults.standard.value(forKey: AREA_ID) as! Int,
                      "Name" : "",
                      "Password" : "12345",
                      "Email" : ""] as [String : Any]
        Alamofire.request(url,method: .post, parameters: params, encoding: URLEncoding.default, headers: ["Content-Type" : "application/x-www-form-urlencoded", "Authorization": AUTH_KEY]).responseJSON(completionHandler: {
            response in
            guard response.result.isSuccess else {
                print(response)
                return
            }
            print(response)
            if let json = response.data {
                
                let decoder = JSONDecoder()
                
                do {
                    let registrationResponse = try decoder.decode(Member.self, from: json)
                    if  registrationResponse.isSuccess {
                        let verificationVC = VerificationCodeViewController()
                        verificationVC.securityCode = registrationResponse.data.member.securityCode
                        verificationVC.phoneNumber = phoneNumber
                        verificationVC.memberID = registrationResponse.data.member.id
                        verificationVC.memberName = registrationResponse.data.member.name
                        verificationVC.imageArray = self.imageArray
                        verificationVC.isImageSelected = self.isImageSelected
                        self.navigationController?.pushViewController(verificationVC, animated: true)
                    }
                    else{
                        Alert.showBasicAlert(on: self, with: "Invalid Phone Number".localized(), message: "Please login with a valid phone number".localized())
                    }
                    
                } catch let err {
                    print(err)
                }
            }
        })
    }
}
