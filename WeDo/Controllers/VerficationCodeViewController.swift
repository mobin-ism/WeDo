//
//  VerficationCodeViewController.swift
//  WeDo
//
//  Created by Al Mobin on 30/7/18.
//  Copyright © 2018 Creativeitem. All rights reserved.
//

import UIKit
class VerificationCodeViewController: UIViewController {
    
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
    
    lazy var verificationCodeLabel : UILabel = {
       var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.clipsToBounds = true
        label.text = "Provide Your Verification Code"
        label.numberOfLines = 0
        label.font = UIFont(name: OPENSANS_REGULAR, size: 14)
        label.textColor = UIColor.black
        return label
    }()
    
    lazy var verificationCodeTextField : PaddedTextField = {
       var textfield = PaddedTextField()
        textfield.translatesAutoresizingMaskIntoConstraints = false
        textfield.clipsToBounds = true
        textfield.backgroundColor = .clear
        textfield.placeholder = "Verificatin Code"
        textfield.font = UIFont(name: OPENSANS_REGULAR, size: 14)
        textfield.layer.borderWidth = 1
        textfield.layer.borderColor = UIColor(red:0.88, green:0.88, blue:0.88, alpha:1.0).cgColor
        textfield.layer.cornerRadius = 4
        return textfield
    }()
    
    lazy var submitButton : UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.clipsToBounds = true
        button.backgroundColor = GREENISH_COLOR
        button.setTitle("SUBMIT", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.addTarget(self, action: #selector(handleSubmitButton), for: .touchUpInside)
        button.layer.cornerRadius = 4
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        
        setNavigationBar()
        layout()
        
        self.verificationCodeTextField.delegate = self
        
        // Adding outside tap will dismiss the keyboard
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
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
        setupVrificationCodeLabel()
        setupVerificationTextField()
        setupSubmitButton()
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
    
    func setupVrificationCodeLabel() {
        scrollView.addSubview(verificationCodeLabel)
        verificationCodeLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        verificationCodeLabel.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 100).isActive = true
    }
    
    func setupVerificationTextField() {
        scrollView.addSubview(verificationCodeTextField)
        verificationCodeTextField.topAnchor.constraint(equalTo: verificationCodeLabel.bottomAnchor, constant: 16).isActive = true
        verificationCodeTextField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16).isActive = true
        verificationCodeTextField.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16).isActive = true
        verificationCodeTextField.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }
    
    func setupSubmitButton() {
        scrollView.addSubview(submitButton)
        submitButton.topAnchor.constraint(equalTo: verificationCodeTextField.bottomAnchor, constant: 16).isActive = true
        submitButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16).isActive = true
        submitButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16).isActive = true
        submitButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }
    
    @objc func backTapped() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func handleSubmitButton() {
        self.navigationController?.pushViewController(WelcomeViewController(), animated: true)
    }
    
    @objc func dismissKeyboard(){
        view.endEditing(true)
    }
}

extension VerificationCodeViewController : UIScrollViewDelegate {
}
extension VerificationCodeViewController : UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        if textField == self.verificationCodeTextField {
            
            //scrollView.setContentOffset(CGPoint(x: 0, y: 50), animated: true)
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        //scrollView.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        view.resignFirstResponder()
        return true
        
    }
}
