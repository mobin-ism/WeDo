//
//  SPAccountViewController.swift
//  WeDo
//
//  Created by Tanvir Hasan Piash on 20/9/18.
//  Copyright © 2018 Creativeitem. All rights reserved.
//

import UIKit

class SPAccountViewController: UIViewController {
    
    let backgroundImageView : UIImageView = {
        var imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .clear
        imageView.image = #imageLiteral(resourceName: "bigger-logo")
        return imageView
    }()
    
    let view1: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 5
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.init(white: 0.9, alpha: 0.9).cgColor
        view.backgroundColor = UIColor.clear
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let view2: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 5
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.init(white: 0.9, alpha: 0.9).cgColor
        view.backgroundColor = UIColor.clear
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let title1: UILabel = {
        let label = UILabel()
        label.text = "Total Earn".localized()
        label.textAlignment = .center
        label.textColor = UIColor.black
        label.font = UIFont(name: OPENSANS_REGULAR, size: 12)
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let title2: UILabel = {
        let label = UILabel()
        label.text = "Earn This Month".localized()
        label.textAlignment = .center
        label.textColor = UIColor.black
        label.font = UIFont(name: OPENSANS_REGULAR, size: 12)
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let value1: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = GREENISH_COLOR
        label.font = UIFont(name: OPENSANS_BOLD, size: 18)
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let value2: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = GREENISH_COLOR
        label.font = UIFont(name: OPENSANS_BOLD, size: 18)
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
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
    
    private func setNavigationBar() {
        navigationController?.navigationBar.barTintColor = NAVBAR_BG_COLOR
        let logo = UIImage(named: "logo.png")
        let imageView = UIImageView(image:logo)
        self.navigationItem.titleView = imageView
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "back-icon"), style: .plain, target: self, action: #selector(backTapped))
    }
    
    private func layout() {
        setupBackgroundImageView()
        setupView1()
        setupView2()
        setupTitle1()
        setupTitle2()
        setupValue1()
        setupValue2()
    }
    
    func setupBackgroundImageView() {
        view.addSubview(backgroundImageView)
        backgroundImageView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        backgroundImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 25).isActive = true
        backgroundImageView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.5).isActive = true
        backgroundImageView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8).isActive = true
    }
    
    func setupView1() {
        view.addSubview(view1)
        view1.topAnchor.constraint(equalTo: view.topAnchor, constant: 100).isActive = true
        view1.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        view1.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.43).isActive = true
        view1.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.43).isActive = true
    }
    
    func setupView2() {
        view.addSubview(view2)
        view2.topAnchor.constraint(equalTo: view1.topAnchor).isActive = true
        view2.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
        view2.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.43).isActive = true
        view2.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.43).isActive = true
    }
    
    func setupTitle1() {
        view1.addSubview(title1)
        title1.centerXAnchor.constraint(equalTo: view1.centerXAnchor).isActive = true
        title1.centerYAnchor.constraint(equalTo: view1.centerYAnchor, constant: -20).isActive = true
    }
    
    func setupTitle2() {
        view2.addSubview(title2)
        title2.centerXAnchor.constraint(equalTo: view2.centerXAnchor).isActive = true
        title2.centerYAnchor.constraint(equalTo: view2.centerYAnchor, constant: -20).isActive = true
    }
    
    func setupValue1() {
        view1.addSubview(value1)
        value1.text = "AED 350"
        value1.topAnchor.constraint(equalTo: title1.bottomAnchor, constant: 8).isActive = true
        value1.centerXAnchor.constraint(equalTo: title1.centerXAnchor).isActive = true
    }
    
    func setupValue2() {
        view2.addSubview(value2)
        value2.text = "AED 350"
        value2.topAnchor.constraint(equalTo: title2.bottomAnchor, constant: 8).isActive = true
        value2.centerXAnchor.constraint(equalTo: title2.centerXAnchor).isActive = true
    }
    
    @objc private func backTapped() {
        navigationController?.popViewController(animated: true)
    }
    
}
