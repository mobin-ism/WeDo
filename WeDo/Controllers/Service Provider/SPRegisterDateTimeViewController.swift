//
//  SPRegisterDateTimeViewController.swift
//  WeDo
//
//  Created by Tanvir Hasan Piash on 15/9/18.
//  Copyright © 2018 Creativeitem. All rights reserved.
//

import UIKit

class SPRegisterDateTimeViewController: UIViewController {
    
    lazy var menu: Menu = {
        let slideMenu = Menu()
        slideMenu.spRegisterDateTimeVC = self
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
    
    let backgroundImageView : UIImageView = {
        var imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .clear
        imageView.image = #imageLiteral(resourceName: "bigger-logo")
        return imageView
    }()
    
    let workingDaysLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.black
        label.textAlignment = .left
        label.text = "Working Days".localized()
        label.font = UIFont(name: OPENSANS_REGULAR, size: 18)
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.backgroundColor = UIColor.clear
        view.alwaysBounceHorizontal = false
        view.showsHorizontalScrollIndicator = false
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        view.delegate = self
        view.dataSource = self
        view.allowsMultipleSelection = true
        return view
    }()
    
    let workingTimeLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.black
        label.textAlignment = .left
        label.text = "Working Time".localized()
        label.font = UIFont(name: OPENSANS_REGULAR, size: 18)
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var startTimeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("START TIME".localized(), for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.titleLabel?.font = UIFont(name: OPENSANS_REGULAR, size: 14)
        button.backgroundColor = UIColor.init(white: 0.8, alpha: 0.8)
        button.clipsToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 5
        return button
    }()
    
    lazy var endTimeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("END TIME".localized(), for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.titleLabel?.font = UIFont(name: OPENSANS_REGULAR, size: 14)
        button.backgroundColor = UIColor.init(white: 0.8, alpha: 0.8)
        button.clipsToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 5
        return button
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
    
    private let cellId = "CellId"
    
    private let days = ["Saturday".localized(), "Sunday".localized(), "Monday".localized(), "Tuesday".localized(), "Wednesday".localized(), "Thursday".localized(),
                        "Friday".localized()]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        collectionView.register(WeekdaySelectCell.self, forCellWithReuseIdentifier: cellId)
        setNavigationBar()
        layout()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        dateTimeButton.titleLabel?.font = UIFont(name: OPENSANS_BOLD, size: 12)
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
        setupCompanyButton()
        setupAddressButton()
        setupDateTimeButton()
        setupServicesButton()
        setupWorkingDaysLabel()
        setupCollectionView()
        setupWorkingTimeLabel()
        setupStartTimeButton()
        setupEndTimeButton()
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
    
    func setupWorkingDaysLabel() {
        view.addSubview(workingDaysLabel)
        workingDaysLabel.topAnchor.constraint(equalTo: companyButton.bottomAnchor, constant: 16).isActive = true
        workingDaysLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
    }
    
    func setupCollectionView() {
        view.addSubview(collectionView)
        collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
        collectionView.topAnchor.constraint(equalTo: workingDaysLabel.bottomAnchor, constant: 16).isActive = true
        collectionView.heightAnchor.constraint(equalToConstant: 126).isActive = true
    }
    
    func setupWorkingTimeLabel() {
        view.addSubview(workingTimeLabel)
        workingTimeLabel.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: 16).isActive = true
        workingTimeLabel.leadingAnchor.constraint(equalTo: workingDaysLabel.leadingAnchor).isActive = true
    }
    
    func setupStartTimeButton() {
        view.addSubview(startTimeButton)
        startTimeButton.topAnchor.constraint(equalTo: workingTimeLabel.bottomAnchor, constant: 16).isActive = true
        startTimeButton.leadingAnchor.constraint(equalTo: workingTimeLabel.leadingAnchor).isActive = true
        startTimeButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        startTimeButton.widthAnchor.constraint(equalTo: workingTimeLabel.widthAnchor, multiplier: 0.9).isActive = true
    }
    
    func setupEndTimeButton() {
        view.addSubview(endTimeButton)
        endTimeButton.topAnchor.constraint(equalTo: startTimeButton.bottomAnchor, constant: 8).isActive = true
        endTimeButton.leadingAnchor.constraint(equalTo: startTimeButton.leadingAnchor).isActive = true
        endTimeButton.heightAnchor.constraint(equalTo: startTimeButton.heightAnchor).isActive = true
        endTimeButton.widthAnchor.constraint(equalTo: startTimeButton.widthAnchor).isActive = true
    }
    
    func setupNextButton() {
        view.addSubview(nextButton)
        nextButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        nextButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
        nextButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -16).isActive = true
        nextButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    @objc private func menuIconTapped() {
        self.menu.show(self)
    }
    
    @objc private func navigationButtonTapped(_ sender: UIButton) {
        switch sender.tag {
        case 1:
            navigationController?.pushViewController(SPRegisterCompanyViewController(), animated: false)
        case 2:
            navigationController?.pushViewController(SPRegisterAddressViewController(), animated: false)
        case 4:
            navigationController?.pushViewController(SPRegisterServicesViewController(), animated: false)
        default:
            print("current view controller")
        }
    }
    
    @objc func nextButtonTapped() {
        let destination = SPRegisterServicesViewController()
        navigationController?.pushViewController(destination, animated: true)
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

extension SPRegisterDateTimeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return days.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! WeekdaySelectCell
        cell.day = days[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as? WeekdaySelectCell else {return}
        cell.isSelected = true
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width / 2
        return CGSize(width: width, height: 30)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
}
