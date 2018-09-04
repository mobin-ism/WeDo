//
//  ServiceDateAndTimeOneviewController.swift
//  WeDo
//
//  Created by Al Mobin on 21/7/18.
//  Copyright © 2018 Creativeitem. All rights reserved.
//

import UIKit
import Alamofire
import SVProgressHUD
class ServiceDateAndTimeOneViewController: UIViewController {
    
    var skipServiceOneViewController : Bool = false
    var imageArray : [UIImage] = []
    var isImageSelected : Bool = false
    var isTimeSelected : Bool = false
    var selectedDate : String?
    var selectedTime : String?
    var availableTimeSlots = ["12-3 AM", "3-6 AM", "6-9 AM", "9-12 PM", "12-3 PM", "3-6 PM", "6-9 PM", "9-12 PM"]
    
    lazy var backgroundImageView : UIImageView = {
        var imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .clear
        imageView.image = #imageLiteral(resourceName: "bigger-logo")
        return imageView
    }()
    
    lazy var descriptionButton : UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.clipsToBounds = true
        button.backgroundColor = UIColor(red:64/255, green:173/255, blue:93/255, alpha:0.9)
        button.setTitle("Description", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.titleLabel?.font = UIFont(name: OPENSANS_REGULAR, size: 12)
        button.tag = 1
        button.addTarget(self, action: #selector(navigationButtonTapped( _:)), for: .touchUpInside)
        return button
    }()
    
    lazy var locationButton : UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.clipsToBounds = true
        button.backgroundColor = UIColor(red:64/255, green:173/255, blue:93/255, alpha:0.9)
        button.setTitle("Location", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.titleLabel?.font = UIFont(name: OPENSANS_REGULAR, size: 12)
        button.tag = 2
        button.addTarget(self, action: #selector(navigationButtonTapped( _:)), for: .touchUpInside)
        return button
    }()
    
    lazy var dateAndTimeButton : UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.clipsToBounds = true
        button.backgroundColor = UIColor(red:64/255, green:173/255, blue:93/255, alpha:0.9)
        button.setTitle("Date and Time", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = UIFont(name: OPENSANS_REGULAR, size: 12)
        button.tag = 3
        button.addTarget(self, action: #selector(navigationButtonTapped( _:)), for: .touchUpInside)
        return button
    }()
    
    lazy var paymentButton : UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.clipsToBounds = true
        button.backgroundColor = UIColor(red:64/255, green:173/255, blue:93/255, alpha:0.9)
        button.setTitle("Payment", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.titleLabel?.font = UIFont(name: OPENSANS_REGULAR, size: 12)
        button.tag = 4
        button.addTarget(self, action: #selector(navigationButtonTapped( _:)), for: .touchUpInside)
        return button
    }()
    
    let selectDateLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .natural
        label.textColor = UIColor.black
        label.text = "Select date"
        label.font = UIFont(name: OPENSANS_REGULAR, size: 14)
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var dateHolder: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        view.layer.cornerRadius = 4
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isUserInteractionEnabled = true
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(showDatePicker)))
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.lightGray.cgColor
        return view
    }()
    let dateLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .natural
        label.textColor = UIColor.black
        label.text = "MM-DD-YYYY"
        label.font = UIFont(name: OPENSANS_REGULAR, size: 12)
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    lazy var downArrowIcon: UIImageView = {
        let view = UIImageView()
        view.image = #imageLiteral(resourceName: "downArrowIcon")
        view.contentMode = .scaleAspectFill
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isUserInteractionEnabled = true
        return view
    }()
    lazy var postButton : UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.clipsToBounds = true
        button.backgroundColor = UIColor(red:0.17, green:0.67, blue:0.31, alpha:1.0)
        button.setTitle("SUBMIT", for: .normal)
        button.titleLabel?.font = UIFont(name: OPENSANS_REGULAR, size: 15)
        button.layer.cornerRadius = 5
        button.addTarget(self, action: #selector(handleSubmitButton), for: .touchUpInside)
        return button
    }()
    
    lazy var calendarSelector: CalendarSelector = {
        let calendar = CalendarSelector()
        calendar.dateTimeVC = self
        return calendar
    }()
    
    let selectTimeLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .natural
        label.textColor = UIColor.black
        label.text = "Select Time"
        label.font = UIFont(name: OPENSANS_REGULAR, size: 14)
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var horizontalCollectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.backgroundColor = UIColor(red:0.98, green:0.98, blue:0.98, alpha:1.0)
        collection.alwaysBounceHorizontal = true
        collection.showsHorizontalScrollIndicator = false
        collection.delegate = self
        collection.dataSource = self
        collection.clipsToBounds = true
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.backgroundColor = .white
        return collection
    }()
    let horizontalCellID = "availableTimeSlots"
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        horizontalCollectionView.register(TimeCell.self, forCellWithReuseIdentifier: horizontalCellID)
        setNavigationBar()
        layout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        Alert.checkInternetConnection(on: self)
        if UserDefaults.standard.value(forKey: SELECTED_DATE) as! String == "" {
            self.getCurrentDate()
        }else {
            self.dateLabel.text = "\(UserDefaults.standard.value(forKey: SELECTED_DATE) as! String)"
        }
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
    
    let welcomeVC = WelcomeViewController()
    func layout() {
        setupBackgroundImageView()
        setupDescriptionButton()
        setupLocationButton()
        setupDateTimeButton()
        //setupPaymentButton()
        setSelectDateLabel()
        setDateHolder()
        setDateLabel()
        setDownArrowIcon()
        setupSelectTimeLabel()
        setupHorizontalCollectionView()
        setupPostButton()
    }
    
    func setupBackgroundImageView() {
        view.addSubview(backgroundImageView)
        backgroundImageView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        backgroundImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 25).isActive = true
        backgroundImageView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.5).isActive = true
        backgroundImageView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8).isActive = true
    }
    
    func setupDescriptionButton() {
        view.addSubview(descriptionButton)
        descriptionButton.topAnchor.constraint(equalTo: view.topAnchor, constant: Helper.barHeight+(self.navigationController?.navigationBar.frame.size.height)!).isActive = true
        descriptionButton.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        descriptionButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        descriptionButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.33).isActive = true
    }
    
    func setupLocationButton() {
        view.addSubview(locationButton)
        locationButton.topAnchor.constraint(equalTo: view.topAnchor, constant: Helper.barHeight+(self.navigationController?.navigationBar.frame.size.height)!).isActive = true
        locationButton.leftAnchor.constraint(equalTo: descriptionButton.rightAnchor).isActive = true
        locationButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        locationButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.33).isActive = true
    }
    
    func setupDateTimeButton() {
        view.addSubview(dateAndTimeButton)
        dateAndTimeButton.topAnchor.constraint(equalTo: view.topAnchor, constant: Helper.barHeight+(self.navigationController?.navigationBar.frame.size.height)!).isActive = true
        dateAndTimeButton.leftAnchor.constraint(equalTo: locationButton.rightAnchor).isActive = true
        dateAndTimeButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        dateAndTimeButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.34).isActive = true
    }
    
    func setupPaymentButton() {
        view.addSubview(paymentButton)
        paymentButton.topAnchor.constraint(equalTo: view.topAnchor, constant: Helper.barHeight+(self.navigationController?.navigationBar.frame.size.height)!).isActive = true
        paymentButton.leftAnchor.constraint(equalTo: dateAndTimeButton.rightAnchor).isActive = true
        paymentButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        paymentButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.25).isActive = true
    }
    
    private func setSelectDateLabel() {
        view.addSubview(selectDateLabel)
        selectDateLabel.topAnchor.constraint(equalTo: descriptionButton.bottomAnchor, constant: 20).isActive = true
        selectDateLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        selectDateLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
    }
    private func setDateHolder() {
        view.addSubview(dateHolder)
        dateHolder.leftAnchor.constraint(equalTo: selectDateLabel.leftAnchor).isActive = true
        dateHolder.topAnchor.constraint(equalTo: selectDateLabel.bottomAnchor, constant: 8).isActive = true
        dateHolder.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16).isActive = true
        dateHolder.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }
    
    private func setDateLabel() {
        dateHolder.addSubview(dateLabel)
        dateLabel.centerYAnchor.constraint(equalTo: dateHolder.centerYAnchor).isActive = true
        dateLabel.leadingAnchor.constraint(equalTo: dateHolder.leadingAnchor, constant: 16).isActive = true
        dateLabel.trailingAnchor.constraint(equalTo: dateHolder.trailingAnchor, constant: -16).isActive = true
    }
    
    private func setDownArrowIcon() {
        dateHolder.addSubview(downArrowIcon)
        downArrowIcon.centerYAnchor.constraint(equalTo: dateHolder.centerYAnchor).isActive = true
        downArrowIcon.rightAnchor.constraint(equalTo: dateHolder.rightAnchor, constant: -16).isActive = true
        downArrowIcon.widthAnchor.constraint(equalToConstant: 11).isActive = true
        downArrowIcon.heightAnchor.constraint(equalToConstant: 11 * 0.6).isActive = true
    }
    
    private func setupSelectTimeLabel() {
        view.addSubview(selectTimeLabel)
        selectTimeLabel.topAnchor.constraint(equalTo: dateHolder.bottomAnchor, constant: 20).isActive = true
        selectTimeLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
    }
    private func setupHorizontalCollectionView() {
        view.addSubview(horizontalCollectionView)
        horizontalCollectionView.topAnchor.constraint(equalTo: selectTimeLabel.bottomAnchor, constant: 16).isActive = true
        horizontalCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        horizontalCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
        horizontalCollectionView.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }
    
    func setupPostButton() {
        view.addSubview(postButton)
        postButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -16).isActive = true
        postButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16).isActive = true
        postButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16).isActive = true
        postButton.heightAnchor.constraint(equalToConstant: 60).isActive = true
    }
    
    func changeFromDateButtonTitle(withString title: String) {
        DispatchQueue.main.async {
            self.dateLabel.text = title
        }
    }
    
    @objc func backTapped() {
        if self.skipServiceOneViewController {
            let viewControllers: [UIViewController] = self.navigationController!.viewControllers
            for aViewController in viewControllers {
                if aViewController is AllServicesListViewController {
                    self.navigationController!.popToViewController(aViewController, animated: true)
                }
            }
        }else {
            let viewControllers: [UIViewController] = self.navigationController!.viewControllers
            for aViewController in viewControllers {
                if aViewController is ServiceDescriptionOneViewController {
                    self.navigationController!.popToViewController(aViewController, animated: true)
                }
            }
        }
    }
    
    @objc func navigationButtonTapped(_ sender: UIButton) {
        switch sender.tag {
        case 1:
            let serviceDescriptionVC = ServiceDescriptionTwoViewController()
            serviceDescriptionVC.isImageSelected = self.isImageSelected
            serviceDescriptionVC.imageArray = self.imageArray
            serviceDescriptionVC.skipServiceOneViewController = self.skipServiceOneViewController
            self.navigationController?.pushViewController(serviceDescriptionVC, animated: false)
        case 2:
            let serviceLocationVC = ServiceLocationOneViewController()
            serviceLocationVC.isImageSelected = self.isImageSelected
            serviceLocationVC.imageArray = self.imageArray
            serviceLocationVC.skipServiceOneViewController = self.skipServiceOneViewController
            self.navigationController?.pushViewController(serviceLocationVC, animated: false)
        case 4:
            let servicePaymentVC = ServicePaymentOneViewController()
            servicePaymentVC.isImageSelected = self.isImageSelected
            servicePaymentVC.imageArray = self.imageArray
            servicePaymentVC.skipServiceOneViewController = self.skipServiceOneViewController
            self.navigationController?.pushViewController(servicePaymentVC, animated: false)
        default:
            print("current view controller")
        }
    }
    
    @objc private func showDatePicker() {
        calendarSelector.show()
    }
    
    private func getCurrentDate() {
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        self.selectedDate = formatter.string(from: date)
        guard let selectedDate = self.selectedDate else { return }
        self.changeFromDateButtonTitle(withString: selectedDate)
        UserDefaults.standard.set(selectedDate, forKey: SELECTED_DATE)
    }
    
    @objc func handleSubmitButton() {
        UserDefaults.standard.set(true, forKey: SHOW_WELCOME_PAGE)
        if UserDefaults.standard.value(forKey: SELECTED_TIME) as! String == "" {
            Alert.showBasicAlert(on: self, with: "Select a timeslot", message: "Please select an available timeslot")
        }else {
            if UserDefaults.standard.value(forKey: IS_LOGGED_IN) as! Bool {
                self.requestAService()
                
            }else {
                let loginVC = LoginViewController()
                loginVC.imageArray = self.imageArray
                loginVC.isImageSelected = self.isImageSelected
                self.navigationController?.pushViewController(loginVC, animated: true)
            }
        }
    }
}

extension ServiceDateAndTimeOneViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.availableTimeSlots.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: horizontalCellID, for: indexPath) as? TimeCell else {
            let cell = collectionView.cellForItem(at: indexPath)!
            return cell
        }
        /*if self.isTimeSelected == false && indexPath.row == 0 {
            cell.isSelected = true
        }*/
        cell.mainText = self.availableTimeSlots[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? TimeCell else { return }
        cell.isSelected = true
        self.isTimeSelected = true
        UserDefaults.standard.set(self.availableTimeSlots[indexPath.row], forKey: SELECTED_TIME)
    }
}

extension ServiceDateAndTimeOneViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width: CGFloat = 80
        let height: CGFloat = 30
        return CGSize(width: width, height: height)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
}

//API CALLS
extension ServiceDateAndTimeOneViewController {
    func requestAService() {
        var serviceRequestId : Int = 0
        SVProgressHUD.setDefaultMaskType(.black)
        SVProgressHUD.show(withStatus: "Please Wait...")
        
        guard let url = URL(string: "\(BASE_URL)api/v2/member/service/request/submit") else { return }
        let params = ["MemberId" : UserDefaults.standard.value(forKey: MEMBER_ID) as! Int,
                      "AgentId" : 1,
                      "Title" : UserDefaults.standard.value(forKey: SUB_SERVICE_TITLE) as! String,
                      "Description" : UserDefaults.standard.value(forKey: DESCRIPTION) as! String,
                      "Location" : UserDefaults.standard.value(forKey: LOCATION) as! String,
                      "Latitude" : UserDefaults.standard.value(forKey: MARKED_LATITUDE) as! Double,
                      "Longitude" : UserDefaults.standard.value(forKey: MARKED_LONGITUDE) as! Double,
                      "TimeRange" : UserDefaults.standard.value(forKey: SELECTED_TIME) as! String,
                      "StartDate" : UserDefaults.standard.value(forKey: SELECTED_DATE) as! String,
                      "ServiceId" : UserDefaults.standard.value(forKey: SUB_SERVICE_ID) as! Int,
                      "RequireHours" : 0] as [String : Any]
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
                    let serviceRequestDetails = try decoder.decode(RequestAServiceModel.self, from: json)
                    if serviceRequestDetails.isSuccess {
                        self.welcomeVC.jobIdLabel.text = "\(serviceRequestDetails.data.serviceRequest.id)"
                        self.welcomeVC.amountToBePaidLabel.text = "\(serviceRequestDetails.data.serviceRequest.amount)"
                        serviceRequestId = serviceRequestDetails.data.serviceRequest.id
                    }else {
                        print("Sorry babe")
                    }
                } catch let err{
                    
                    print(err)
                }
            }
        })
        SVProgressHUD.dismiss()
        self.navigationController?.pushViewController(welcomeVC, animated: true)
        //self.sendImageToServer(serviceRequestId: serviceRequestId)
    }
}
