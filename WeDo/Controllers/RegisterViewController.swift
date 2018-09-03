//
//  RegisterViewController.swift
//  WeDo
//
//  Created by Creativeitem on 26/7/18.
//  Copyright © 2018 Creativeitem. All rights reserved.
//

import UIKit
import Alamofire
class RegisterViewController: UIViewController {
    
    var areaID : Int = 0
    lazy var menu: Menu = {
        let slideMenu = Menu()
        slideMenu.registerVC = self
        return slideMenu
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
    
    lazy var backgroundImageView : UIImageView = {
        var imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .clear
        imageView.image = #imageLiteral(resourceName: "bigger-logo")
        return imageView
    }()
    
    let registerNowLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = UIColor.black
        label.text = "Register Now"
        label.font = UIFont(name: OPENSANS_REGULAR, size: 18)
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        return label
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = UIColor.black
        label.text = "Name"
        label.font = UIFont(name: OPENSANS_REGULAR, size: 13)
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let emailLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = UIColor.black
        label.text = "Email"
        label.font = UIFont(name: OPENSANS_REGULAR, size: 13)
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        return label
    }()
    
    let phoneNumberLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = UIColor.black
        label.text = "Phone No."
        label.font = UIFont(name: OPENSANS_REGULAR, size: 13)
        label.clipsToBounds = true
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let nameTextField : PaddedTextField = {
        var textfield = PaddedTextField()
        textfield.translatesAutoresizingMaskIntoConstraints = false
        textfield.clipsToBounds = true
        textfield.placeholder = "Name"
        textfield.layer.cornerRadius = 5
        textfield.layer.borderWidth = 1
        textfield.layer.borderColor = UIColor(red:0.62, green:0.62, blue:0.62, alpha:0.5).cgColor
        return textfield
    }()
    
    let emailTextField : PaddedTextField = {
        var textfield = PaddedTextField()
        textfield.translatesAutoresizingMaskIntoConstraints = false
        textfield.clipsToBounds = true
        textfield.placeholder = "Email"
        textfield.layer.cornerRadius = 5
        textfield.layer.borderWidth = 1
        textfield.layer.borderColor = UIColor(red:0.62, green:0.62, blue:0.62, alpha:0.5).cgColor
        return textfield
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
    
    lazy var registerButton : UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.clipsToBounds = true
        button.backgroundColor = UIColor(red:0.17, green:0.67, blue:0.31, alpha:1.0)
        button.setTitle("REGISTER", for: .normal)
        button.titleLabel?.font = UIFont(name: OPENSANS_REGULAR, size: 15)
        button.layer.cornerRadius = 5
        button.addTarget(self, action: #selector(registerButtonTapped), for: .touchUpInside)
        return button
    }()
    
    let haveAccountLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = UIColor.black
        label.text = "Have And Account?"
        label.font = UIFont(name: OPENSANS_REGULAR, size: 15)
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        label.textColor = UIColor.lightGray
        return label
    }()
    
    let loginLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = UIColor.black
        label.attributedText = NSAttributedString(string: "Login", attributes:[.underlineStyle: NSUnderlineStyle.styleSingle.rawValue])
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
        label.textAlignment = .left
        label.textColor = UIColor.black
        label.text = "Service Provide"
        label.font = UIFont(name: OPENSANS_REGULAR, size: 15)
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        return label
    }()
    
    let loginRegisterLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = UIColor.black
        label.text = "Login | Register"
        label.font = UIFont(name: OPENSANS_REGULAR, size: 13)
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
        
        self.nameTextField.delegate = self
        self.emailTextField.delegate = self
        self.phoneNumberTextField.delegate = self
        
        // tap gesture on login label
        let tap = UITapGestureRecognizer(target: self, action: #selector(login))
        self.loginLabel.addGestureRecognizer(tap)
        
        // Adding outside tap will dismiss the keyboard
        let backgorundTap: UITapGestureRecognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(dismissKeyboard))
        view.addGestureRecognizer(backgorundTap)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        Alert.checkInternetConnection(on: self)
        
        if !Helper.Exists(key: AREA_ID) {
           self.setAreaFirst()
        }else {
            self.areaID = UserDefaults.standard.value(forKey: AREA_ID) as! Int
        }
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
        //navigationItem.leftBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "menu"), style: .plain, target: self, action: #selector(menuIconTapped))
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "back-icon"), style: .plain, target: self, action: #selector(backTapped))
        
    }
    
    func layout() {
        setupBackgroundImageView()
        setupScrollView()
        setupRegisterNowLabel()
        setupNameLabel()
        setupNameTextField()
        setupEmailLabel()
        setupEmailTextField()
        setupPhoneNumberLabel()
        setupPhoneNumberTextField()
        setupRegisterButton()
        setupHaveAnAccountLabel()
        setupLoginLabel()
        setupOrLabel()
        setupLeftHorizontalLine()
        setupRighttHorizontalLine()
        setupServiceProvideLabel()
        setupLoginRegisterLabel()
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
    
    func setupRegisterNowLabel() {
        scrollView.addSubview(registerNowLabel)
        registerNowLabel.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        registerNowLabel.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 16).isActive = true
    }
    func setupNameLabel() {
        scrollView.addSubview(nameLabel)
        nameLabel.topAnchor.constraint(equalTo: registerNowLabel.bottomAnchor, constant: 16).isActive = true
        nameLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16).isActive = true
    }
    func setupNameTextField() {
        scrollView.addSubview(nameTextField)
        nameTextField.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 10).isActive = true
        nameTextField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16).isActive = true
        nameTextField.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16).isActive = true
        nameTextField.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    func setupEmailLabel() {
        scrollView.addSubview(emailLabel)
        emailLabel.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 16).isActive = true
        emailLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16).isActive = true
    }
    
    func setupEmailTextField() {
        scrollView.addSubview(emailTextField)
        emailTextField.topAnchor.constraint(equalTo: emailLabel.bottomAnchor, constant: 10).isActive = true
        emailTextField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16).isActive = true
        emailTextField.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16).isActive = true
        emailTextField.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    func setupPhoneNumberLabel() {
        scrollView.addSubview(phoneNumberLabel)
        phoneNumberLabel.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 16).isActive = true
        phoneNumberLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16).isActive = true
    }
    
    func setupPhoneNumberTextField() {
        scrollView.addSubview(phoneNumberTextField)
        phoneNumberTextField.topAnchor.constraint(equalTo: phoneNumberLabel.bottomAnchor, constant: 10).isActive = true
        phoneNumberTextField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16).isActive = true
        phoneNumberTextField.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16).isActive = true
        phoneNumberTextField.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    func setupRegisterButton() {
        scrollView.addSubview(registerButton)
        registerButton.topAnchor.constraint(equalTo: phoneNumberTextField.bottomAnchor, constant: 16).isActive = true
        registerButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16).isActive = true
        registerButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16).isActive = true
        registerButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    func setupHaveAnAccountLabel() {
        scrollView.addSubview(haveAccountLabel)
        haveAccountLabel.topAnchor.constraint(equalTo: registerButton.bottomAnchor, constant: 20).isActive = true
        //haveAccountLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5).isActive = true
        haveAccountLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: -30).isActive = true
    }
    
    func setupLoginLabel() {
        scrollView.addSubview(loginLabel)
        loginLabel.centerYAnchor.constraint(equalTo: haveAccountLabel.centerYAnchor).isActive = true
        //loginLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5).isActive = true
        loginLabel.leftAnchor.constraint(equalTo: haveAccountLabel.rightAnchor, constant: 5).isActive = true
    }
    
    func setupOrLabel() {
        scrollView.addSubview(orLabel)
        orLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        orLabel.topAnchor.constraint(equalTo: haveAccountLabel.bottomAnchor, constant: 40).isActive = true
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
    
    func setupLoginRegisterLabel() {
        scrollView.addSubview(loginRegisterLabel)
        loginRegisterLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        loginRegisterLabel.topAnchor.constraint(equalTo: serviceProviderLabel.bottomAnchor, constant: 16).isActive = true
    }
    
    @objc func backTapped() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func menuIconTapped() {
        self.menu.show()
    }
    
    @objc func dismissKeyboard(){
        view.endEditing(true)
    }
    
    @objc func login() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func registerButtonTapped() {
        if let name = self.nameTextField.text, let email = self.emailTextField.text, let phoneNumber = self.phoneNumberTextField.text {
            if name == "" || email == "" || phoneNumber == "" {
                Alert.showBasicAlert(on: self, with: "Fill all the fields", message: "Please fill all the fields to register")
            }else {
                if self.checkEmailValidation(email: email){
                    self.registrationMember()
                }else {
                    Alert.showBasicAlert(on: self, with: "Invalid email address", message: "Please enter a valid email address")
                }
            }
        }
    }
    
    func setAreaFirst() {
        let refreshAlert = UIAlertController(title: "Please select your area first", message: "You have to select an area first", preferredStyle: UIAlertControllerStyle.alert)
        
        refreshAlert.addAction(UIAlertAction(title: "Select Area", style: .default, handler: { (action: UIAlertAction!) in
            self.navigationController?.pushViewController(CustomerSettingsViewController(), animated: false)
        }))
        present(refreshAlert, animated: true, completion: nil)
    }
    
    func checkEmailValidation(email: String) -> Bool{
        // alternative: not case sensitive
        if  email.lowercased().range(of:"@") != nil && email.lowercased().range(of:".com") != nil {
            return true
        }
        else {
            return false
        }
    }
    
    private func registrationSuccessfullyDoneAlert(securityCode : String, phoneNumber: String) {
        
        let alert = UIAlertController(title: "Congratulations!!!", message: "Registration Successfully Done", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Close", style: .default, handler: { action in
            let verificationVC = VerificationCodeViewController()
            verificationVC.securityCode = securityCode
            verificationVC.phoneNumber = phoneNumber
            self.navigationController?.pushViewController(verificationVC, animated: true)
        }))
        self.present(alert, animated: true, completion: nil)
    }
    private func registrationFailedAlert(){
        
        let alert = UIAlertController(title: "Ooops!!", message: "Registration failed", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Try Again", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}

extension RegisterViewController : UIScrollViewDelegate {
    
}

extension RegisterViewController : UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        if textField == self.nameTextField {
            
        }
        else if textField == self.phoneNumberTextField {
            scrollView.setContentOffset(CGPoint(x: 0, y: 100), animated: true)
        }
        else if textField == self.emailTextField {
            
            
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

// API CALLS
extension RegisterViewController {
    func registrationMember() {
        if self.areaID > 0 {
            guard let url = URL(string: "\(BASE_URL)api/v2/member/register") else { return }
            let params = ["PhoneNumber" : self.phoneNumberTextField.text ?? "",
                          "CityId" : self.areaID,
                          "Name" : self.nameTextField.text ?? "",
                          "Password" : "",
                          "Email" : self.emailTextField.text ?? ""] as [String : Any]
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
                            
                            self.registrationSuccessfullyDoneAlert(securityCode: registrationResponse.data.member.securityCode, phoneNumber: self.phoneNumberTextField.text!)
                        }
                        else{
                            self.registrationFailedAlert()
                        }
                        
                    } catch let err{
                        
                        print(err)
                    }
                }
            })
        }else {
            self.setAreaFirst()
        }
        
    }
}

