//
//  SPLoginVerifyViewController.swift
//  WeDo
//
//  Created by Tanvir Hasan Piash on 16/9/18.
//  Copyright © 2018 Creativeitem. All rights reserved.
//

import UIKit

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
        navigationController?.pushViewController(SPHomeViewController(), animated: true)
    }
    
    @objc private func menuIconTapped() {
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
}
