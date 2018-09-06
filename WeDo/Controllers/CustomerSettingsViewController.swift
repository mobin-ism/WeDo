//
//  CustomerSettingsViewController.swift
//  WeDo
//
//  Created by Al Mobin on 29/7/18.
//  Copyright © 2018 Creativeitem. All rights reserved.
//

import UIKit
import Localize_Swift
class CustomerSettingsViewController: UIViewController {
    
    var languageNSObject = [LanguageNSObject]()
    var areaNSObject = [AreaNSObject]()
    var selectedAreaID : Int = 1
    var selectedArea : String!
    var selectedLanguage : String!
    var selectedLanguageID : Int = 1
    lazy var backgroundImageView : UIImageView = {
        var imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .clear
        imageView.image = #imageLiteral(resourceName: "bigger-logo")
        return imageView
    }()
    
    lazy var languageLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.clipsToBounds = true
        label.numberOfLines = 0
        label.font = UIFont(name: OPENSANS_REGULAR, size: 14)
        label.textColor = UIColor.black
        label.textAlignment = .left
        label.text = "Language"
        return label
    }()
    
    lazy var notificationLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.clipsToBounds = true
        label.numberOfLines = 0
        label.font = UIFont(name: OPENSANS_REGULAR, size: 14)
        label.textColor = UIColor.black
        label.textAlignment = .left
        label.text = "Notification"
        return label
    }()
    
    lazy var soundLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.clipsToBounds = true
        label.numberOfLines = 0
        label.font = UIFont(name: OPENSANS_REGULAR, size: 14)
        label.textColor = UIColor.black
        label.textAlignment = .left
        label.text = "Sound"
        return label
    }()
    
    lazy var vibrationLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.clipsToBounds = true
        label.numberOfLines = 0
        label.font = UIFont(name: OPENSANS_REGULAR, size: 14)
        label.textColor = UIColor.black
        label.textAlignment = .left
        label.text = "Vibration"
        return label
    }()
    
    lazy var versionLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.clipsToBounds = true
        label.numberOfLines = 0
        label.font = UIFont(name: OPENSANS_REGULAR, size: 12)
        label.textColor = UIColor.lightGray
        label.textAlignment = .left
        label.text = "ℹ App Version 1.18.1"
        return label
    }()
    
    lazy var languageSelectorButton : UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.clipsToBounds = true
        button.backgroundColor = UIColor.white
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor(red:0.88, green:0.88, blue:0.88, alpha:1.0).cgColor
        button.layer.cornerRadius = 4
        button.setTitleColor(UIColor.black, for: .normal)
        button.titleLabel?.font = UIFont(name: OPENSANS_REGULAR, size: 12)
        button.addTarget(self, action: #selector(handleLanguageSelector), for: .touchUpInside)
        return button
    }()
    
    lazy var selectAreaLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.clipsToBounds = true
        label.numberOfLines = 0
        label.font = UIFont(name: OPENSANS_REGULAR, size: 14)
        label.textColor = UIColor.black
        label.textAlignment = .left
        label.text = "Area"
        return label
    }()
    
    lazy var areaSelectorButton : UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.clipsToBounds = true
        button.backgroundColor = UIColor.white
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor(red:0.88, green:0.88, blue:0.88, alpha:1.0).cgColor
        button.layer.cornerRadius = 4
        button.setTitleColor(UIColor.black, for: .normal)
        button.titleLabel?.font = UIFont(name: OPENSANS_REGULAR, size: 12)
        button.setTitle("Select Area", for: .normal)
        button.addTarget(self, action: #selector(handleAreaSelector), for: .touchUpInside)
        return button
    }()
    
    lazy var horizontalLineOne : UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        view.backgroundColor = UIColor(red:0.62, green:0.62, blue:0.62, alpha:0.3)
        return view
    }()
    
    lazy var horizontalLineTwo : UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        view.backgroundColor = UIColor(red:0.62, green:0.62, blue:0.62, alpha:0.3)
        return view
    }()
    
    lazy var horizontalLineThree : UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        view.backgroundColor = UIColor(red:0.62, green:0.62, blue:0.62, alpha:0.3)
        return view
    }()
    
    lazy var horizontalLineFour : UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        view.backgroundColor = UIColor(red:0.62, green:0.62, blue:0.62, alpha:0.3)
        return view
    }()
    
    lazy var notificationSwitch : UISwitch = {
        let customSwitch = UISwitch()
        customSwitch.translatesAutoresizingMaskIntoConstraints = false
        customSwitch.clipsToBounds = true
        customSwitch.tintColor = UIColor(red:0.74, green:0.74, blue:0.74, alpha:0.5)
        customSwitch.addTarget(self, action: #selector(toggleNotificationSwitch), for: .touchUpInside)
        customSwitch.backgroundColor = .clear
        return customSwitch
    }()
    
    lazy var soundSwitch : UISwitch = {
        let customSwitch = UISwitch()
        customSwitch.translatesAutoresizingMaskIntoConstraints = false
        customSwitch.clipsToBounds = true
        customSwitch.tintColor = UIColor(red:0.74, green:0.74, blue:0.74, alpha:0.5)
        customSwitch.addTarget(self, action: #selector(toggleSoundSwitch), for: .touchUpInside)
        customSwitch.backgroundColor = .clear
        customSwitch.isOn = true
        return customSwitch
    }()
    
    lazy var vibrationSwitch : UISwitch = {
        let customSwitch = UISwitch()
        customSwitch.translatesAutoresizingMaskIntoConstraints = false
        customSwitch.clipsToBounds = true
        customSwitch.tintColor = UIColor(red:0.74, green:0.74, blue:0.74, alpha:0.5)
        customSwitch.addTarget(self, action: #selector(toggleVibrationSwitch), for: .touchUpInside)
        customSwitch.backgroundColor = .clear
        return customSwitch
    }()
    
    lazy var submitButton : UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.clipsToBounds = true
        button.backgroundColor = UIColor(red:0.17, green:0.67, blue:0.31, alpha:1.0)
        button.setTitle("Submit", for: .normal)
        button.titleLabel?.font = UIFont(name: OPENSANS_REGULAR, size: 15)
        button.layer.cornerRadius = 5
        button.addTarget(self, action: #selector(handleSubmitButton), for: .touchUpInside)
        return button
    }()
    
    lazy var selector: Selector = {
        let selector = Selector()
        selector.customerSettingsVC = self
        return selector
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        setNavigationBar()
        layout()
        
        if UserDefaults.standard.value(forKey: LANGUAGE) as? String == "ar" {
            self.languageSelectorButton.setTitle("Arabic", for: .normal)
        }else {
            self.languageSelectorButton.setTitle("English", for: .normal)
        }
        
        if Helper.Exists(key: AREA){
            self.areaSelectorButton.setTitle("\(UserDefaults.standard.value(forKey: AREA) as! String)", for: .normal)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        Alert.checkInternetConnection(on: self)
        
        if UserDefaults.standard.value(forKey: LANGUAGE) as! String == "en" {
            self.selectedLanguageID = 1
        }else if UserDefaults.standard.value(forKey: LANGUAGE) as! String == "ar" {
            self.selectedLanguageID = 2
        }
        
        self.selectedArea = UserDefaults.standard.value(forKey: AREA) as! String
        self.selectedAreaID = UserDefaults.standard.value(forKey: AREA_ID) as! Int
    }
    
    private func setNavigationBar() {
        navigationController?.navigationBar.barTintColor = NAVBAR_BG_COLOR
        let logo = UIImage(named: "logo.png")
        let imageView = UIImageView(image:logo)
        self.navigationItem.titleView = imageView
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "back-icon"), style: .plain, target: self, action: #selector(backTapped))
        self.navigationController?.navigationBar.shadowImage = UIImage()
    }
    
    func changeLanguageSelectorTitle(withString title: String, selectedLanguageID : Int) {
        self.languageSelectorButton.setTitle(title, for: .normal)
        self.selectedLanguageID = selectedLanguageID
    }
    
    func changeAreaSelectorTitle(withString title: String, selectedAreaID : Int) {
        self.areaSelectorButton.setTitle(title, for: .normal)
        self.selectedArea = title
        self.selectedAreaID = selectedAreaID
    }
    
    func layout() {
        setupBackgroundImageView()
        setupLanguageSelector()
        setupLanguageLable()
        setupHorizontalLineFour()
        setupAreaSelector()
        setupAreaLabel()
        setupHorizontalLineOne()
        setupNotificationSwitch()
        setupNotificationLable()
        setupHorizontalLineTwo()
        setupSoundSwitch()
        setupSoundLabel()
        setupHorizontalLineThree()
        setupVibrationSwitch()
        setupVibrationLabel()
        setupSubmitButton()
        setupVersionNumberLabel()
    }
    
    func setupBackgroundImageView() {
        view.addSubview(backgroundImageView)
        backgroundImageView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        backgroundImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 25).isActive = true
        backgroundImageView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.5).isActive = true
        backgroundImageView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8).isActive = true
    }
    
    func setupLanguageSelector() {
        let topAnchor = Helper.barHeight + (self.navigationController?.navigationBar.frame.height)! + 20
        view.addSubview(languageSelectorButton)
        languageSelectorButton.topAnchor.constraint(equalTo: view.topAnchor, constant: topAnchor).isActive = true
        languageSelectorButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16).isActive = true
        languageSelectorButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        languageSelectorButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.45).isActive = true
    }
    
    func setupLanguageLable() {
        view.addSubview(languageLabel)
        languageLabel.centerYAnchor.constraint(equalTo: languageSelectorButton.centerYAnchor).isActive = true
        languageLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16).isActive = true
    }
    
    func setupHorizontalLineFour() {
        view.addSubview(horizontalLineFour)
        horizontalLineFour.topAnchor.constraint(equalTo: languageSelectorButton.bottomAnchor, constant: 16).isActive = true
        horizontalLineFour.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        horizontalLineFour.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        horizontalLineFour.heightAnchor.constraint(equalToConstant: 1).isActive = true
    }
    func setupAreaSelector() {
        view.addSubview(areaSelectorButton)
        areaSelectorButton.topAnchor.constraint(equalTo: horizontalLineFour.bottomAnchor, constant: 16).isActive = true
        areaSelectorButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16).isActive = true
        areaSelectorButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        areaSelectorButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.45).isActive = true
    }
    
    func setupAreaLabel() {
        view.addSubview(selectAreaLabel)
        selectAreaLabel.centerYAnchor.constraint(equalTo: areaSelectorButton.centerYAnchor).isActive = true
        selectAreaLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16).isActive = true
    }
    
    func setupHorizontalLineOne() {
        view.addSubview(horizontalLineOne)
        horizontalLineOne.topAnchor.constraint(equalTo: areaSelectorButton.bottomAnchor, constant: 16).isActive = true
        horizontalLineOne.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        horizontalLineOne.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        horizontalLineOne.heightAnchor.constraint(equalToConstant: 1).isActive = true
    }
    
    func setupNotificationSwitch() {
        view.addSubview(notificationSwitch)
        notificationSwitch.topAnchor.constraint(equalTo: horizontalLineOne.bottomAnchor, constant: 16).isActive = true
        notificationSwitch.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16).isActive = true
    }
    
    func setupNotificationLable() {
        view.addSubview(notificationLabel)
        notificationLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16).isActive = true
        notificationLabel.centerYAnchor.constraint(equalTo: notificationSwitch.centerYAnchor).isActive = true
    }
    
    func setupHorizontalLineTwo() {
        view.addSubview(horizontalLineTwo)
        horizontalLineTwo.topAnchor.constraint(equalTo: notificationSwitch.bottomAnchor, constant: 16).isActive = true
        horizontalLineTwo.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        horizontalLineTwo.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        horizontalLineTwo.heightAnchor.constraint(equalToConstant: 1).isActive = true
    }
    
    func setupSoundSwitch() {
        view.addSubview(soundSwitch)
        soundSwitch.topAnchor.constraint(equalTo: horizontalLineTwo.bottomAnchor, constant: 16).isActive = true
        soundSwitch.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16).isActive = true
    }
    
    func setupSoundLabel() {
        view.addSubview(soundLabel)
        soundLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16).isActive = true
        soundLabel.centerYAnchor.constraint(equalTo: soundSwitch.centerYAnchor).isActive = true
    }
    
    func setupHorizontalLineThree() {
        view.addSubview(horizontalLineThree)
        horizontalLineThree.topAnchor.constraint(equalTo: soundSwitch.bottomAnchor, constant: 16).isActive = true
        horizontalLineThree.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        horizontalLineThree.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        horizontalLineThree.heightAnchor.constraint(equalToConstant: 1).isActive = true
    }
    
    func setupVibrationSwitch() {
        view.addSubview(vibrationSwitch)
        vibrationSwitch.topAnchor.constraint(equalTo: horizontalLineThree.bottomAnchor, constant: 16).isActive = true
        vibrationSwitch.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16).isActive = true
    }
    
    func setupVibrationLabel() {
        view.addSubview(vibrationLabel)
        vibrationLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16).isActive = true
        vibrationLabel.centerYAnchor.constraint(equalTo: vibrationSwitch.centerYAnchor).isActive = true
    }
    
    func setupSubmitButton() {
        view.addSubview(submitButton)
        submitButton.topAnchor.constraint(equalTo: vibrationSwitch.bottomAnchor, constant: 20).isActive = true
        submitButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        submitButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
        submitButton.heightAnchor.constraint(equalToConstant: 60).isActive = true
    }
    
    func setupVersionNumberLabel() {
        view.addSubview(versionLabel)
        versionLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        versionLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -40).isActive = true
    }
    
    @objc func backTapped() {
        //self.navigationController?.popViewController(animated: true)
        self.navigationController?.pushViewController(HomeViewController(), animated: true)
    }
    
    @objc func toggleNotificationSwitch() {
        print(notificationSwitch.isOn)
        if notificationSwitch.isOn {
            //self.navigationController?.pushViewController(VerificationCodeViewController(), animated: true)
        }
    }
    
    @objc func toggleSoundSwitch() {
        print(soundSwitch.isOn)
    }
    
    @objc func toggleVibrationSwitch() {
        print(vibrationSwitch.isOn)
    }
    
    @objc func handleLanguageSelector() {
        self.makeLanguageNSObject()
    }
    
    @objc func handleAreaSelector() {
        self.makeAreaNSObject()
    }
    func makeLanguageNSObject() {
        if !self.languageNSObject.isEmpty {
            self.languageNSObject.removeAll()
        }
        let englishLanguage = LanguageNSObject(languageId: 1, languageName: "English")
        let arabicLanguagge = LanguageNSObject(languageId: 2, languageName: "Arabic")
        self.languageNSObject.append(englishLanguage)
        self.languageNSObject.append(arabicLanguagge)
        self.selector.show(withData: self.languageNSObject)
    }
    
    private func makeAreaNSObject() {
        guard let url = URL(string: "\(BASE_URL)api/v2/city?language=\(UserDefaults.standard.value(forKey: LANGUAGE) as! String)") else { return }
        HTTPRequestHandler.makeGetHttpRequest(url: url, parameter: [:]) { (response, nil) in
            guard let response = response else { return }
            
            if !self.areaNSObject.isEmpty {
                self.areaNSObject.removeAll()
            }
            print(response)
            if let json = response.data {
                let decoder = JSONDecoder()
                do {
                    let areaList = try decoder.decode(Area.self, from: json)
                    for area in areaList.data.city {
                        let container = AreaNSObject(areaId: area.id, areaName: area.name)
                        self.areaNSObject.append(container)
                    }
                self.selector.show(withData: self.areaNSObject)
                }catch let err {
                    print(err)
                }
            }
        }
    }
    
    
    
    @objc func handleSubmitButton() {
        // language select
        if selectedLanguageID == 2 {
            UserDefaults.standard.set("ar", forKey: LANGUAGE)
            UIView.appearance().semanticContentAttribute = .forceRightToLeft
            Localize.setCurrentLanguage("ar")
            
        }else {
            UserDefaults.standard.set("en", forKey: LANGUAGE)
            UIView.appearance().semanticContentAttribute = .forceLeftToRight
            Localize.setCurrentLanguage("en")
        }
        
        // area select
        UserDefaults.standard.set(self.selectedAreaID, forKey: AREA_ID)
        UserDefaults.standard.set(selectedArea, forKey: AREA)
        Alert.showBasicAlert(on: self, with: "Updated", message: "Settings updated successfully")
    }
    
}
