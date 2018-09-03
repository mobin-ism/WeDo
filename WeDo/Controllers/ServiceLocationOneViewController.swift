//
//  ServiceLocationOneViewController.swift
//  WeDo
//
//  Created by Al Mobin on 21/7/18.
//  Copyright © 2018 Creativeitem. All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlaces

class ServiceLocationOneViewController: UIViewController {
    var markedLatitude : Double = 0.0
    var markedLongitude : Double = 0.0
    var skipServiceOneViewController : Bool = false
    var imageArray : [UIImage] = []
    var isImageSelected : Bool = false
    
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
    
    lazy var mapView: GMSMapView = {
        let view = GMSMapView()
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isUserInteractionEnabled = true
        view.isMyLocationEnabled = true
        view.settings.myLocationButton = true
        view.delegate = self
        return view
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
        button.setTitleColor(UIColor.white, for: .normal)
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
        button.setTitleColor(UIColor.black, for: .normal)
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
    
    let addressLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = UIColor.black
        label.text = "Address"
        label.font = UIFont(name: OPENSANS_REGULAR, size: 12)
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let addressLineOneLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = UIColor.black
        label.text = "P Block, Emaar Bussiness Park"
        label.font = UIFont(name: OPENSANS_REGULAR, size: 15)
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 2
        return label
    }()
    
    let addressLineTwoLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = UIColor.black
        label.text = "341 Jake Island Suite 419"
        label.font = UIFont(name: OPENSANS_REGULAR, size: 13)
        label.clipsToBounds = true
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var horizontalLine : UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        view.backgroundColor = UIColor(red:0.74, green:0.74, blue:0.74, alpha:0.5)
        return view
    }()
    
    let extraDirectionLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = UIColor.black
        label.text = "Extra Directions"
        label.font = UIFont(name: OPENSANS_REGULAR, size: 14)
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let extraDirectionTextField : PaddedTextField = {
       var textfield = PaddedTextField()
        textfield.translatesAutoresizingMaskIntoConstraints = false
        textfield.clipsToBounds = true
        textfield.placeholder = "Extra Direction"
        textfield.layer.cornerRadius = 5
        textfield.layer.borderWidth = 1
        textfield.layer.borderColor = UIColor(red:0.62, green:0.62, blue:0.62, alpha:0.5).cgColor
        textfield.addTarget(self, action: #selector(extraDirectionTextFieldChanged), for: .editingChanged)
        return textfield
    }()
    
    let apartmentNoLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = UIColor.black
        label.text = "Apartment no / Villa no"
        label.font = UIFont(name: OPENSANS_REGULAR, size: 14)
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let apartmentNoTextField : PaddedTextField = {
        var textfield = PaddedTextField()
        textfield.translatesAutoresizingMaskIntoConstraints = false
        textfield.clipsToBounds = true
        textfield.placeholder = "Extra Direction"
        textfield.layer.cornerRadius = 5
        textfield.layer.borderWidth = 1
        textfield.layer.borderColor = UIColor(red:0.62, green:0.62, blue:0.62, alpha:0.5).cgColor
        textfield.addTarget(self, action: #selector(apartmentNoTextFieldChanged), for: .editingChanged)
        return textfield
    }()
    
    lazy var nextButton : UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.clipsToBounds = true
        button.backgroundColor = UIColor(red:0.17, green:0.67, blue:0.31, alpha:1.0)
        button.setTitle("NEXT", for: .normal)
        button.titleLabel?.font = UIFont(name: OPENSANS_REGULAR, size: 15)
        button.layer.cornerRadius = 5
        button.addTarget(self, action: #selector(handleNextButton), for: .touchUpInside)
        return button
    }()
    
    let mapPinImageView: UIImageView = {
        let view = UIImageView(image: #imageLiteral(resourceName: "mappin"))
        view.contentMode = .scaleAspectFit
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let locationManager = CLLocationManager()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        setNavigationBar()
        layout()
        
        extraDirectionTextField.delegate = self
        apartmentNoTextField.delegate = self
        
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        
        // set map view to current location
        self.setMapViewToCurrentLocation()
        
        // Adding outside tap will dismiss the keyboard
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        Alert.checkInternetConnection(on: self)
        
        self.extraDirectionTextField.text = "\(UserDefaults.standard.value(forKey: EXTRA_DIRECTION) as! String)"
        self.apartmentNoTextField.text = "\(UserDefaults.standard.value(forKey: APARTMENT_NUMBER) as! String)"
    }
    
    func setMapViewToCurrentLocation() {
        
        guard let currentLatitude  = locationManager.location?.coordinate.latitude else { return }
        guard let currentLongitude = locationManager.location?.coordinate.longitude else { return }
        self.markedLatitude  = currentLatitude
        self.markedLongitude = currentLongitude
        let currentLocation = CLLocationCoordinate2DMake(currentLatitude, currentLongitude)
        mapView.animate(toLocation: currentLocation)
        mapView.animate(toZoom: 16)
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
        setupDescriptionButton()
        setupLocationButton()
        setupDateTimeButton()
        //setupPaymentButton()
        setupScrollView()
        setupMapView()
        setMapPinImageView()
        setupAddressLabel()
        setupAddressLineOneLabel()
        setupAddressLineTwoLabel()
        setupHorizontalLine()
        setupExtraDirectionLabel()
        setupExtraDirectionTextField()
        setupApartmentLabel()
        setupApartmentTextField()
        setupnextButton()
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
    
    func setupScrollView() {
        view.addSubview(scrollView)
        scrollView.topAnchor.constraint(equalTo: descriptionButton.bottomAnchor).isActive = true
        scrollView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        scrollView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    func setupMapView() {
        scrollView.addSubview(mapView)
        mapView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        mapView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        mapView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        if Helper.isIphoneX {
            mapView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.35).isActive = true
        } else {
            mapView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.40).isActive = true
        }
    }
    private func setMapPinImageView() {
        mapView.addSubview(mapPinImageView)
        mapPinImageView.centerXAnchor.constraint(equalTo: mapView.centerXAnchor).isActive = true
        mapPinImageView.centerYAnchor.constraint(equalTo: mapView.centerYAnchor, constant: -25).isActive = true
        mapPinImageView.widthAnchor.constraint(equalToConstant: 50).isActive = true
        mapPinImageView.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    func setupAddressLabel() {
        self.scrollView.addSubview(addressLabel)
        addressLabel.topAnchor.constraint(equalTo: mapView.bottomAnchor, constant: 16).isActive = true
        addressLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16).isActive = true
    }
    
    func setupAddressLineOneLabel() {
        self.scrollView.addSubview(addressLineOneLabel)
        addressLineOneLabel.topAnchor.constraint(equalTo: addressLabel.bottomAnchor, constant: 5).isActive = true
        addressLineOneLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16).isActive = true
        addressLineOneLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16).isActive = true
    }
    
    func setupAddressLineTwoLabel() {
        self.scrollView.addSubview(addressLineTwoLabel)
        addressLineTwoLabel.topAnchor.constraint(equalTo: addressLineOneLabel.bottomAnchor, constant: 5).isActive = true
        addressLineTwoLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16).isActive = true
        addressLineTwoLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16).isActive = true
    }
    
    func setupHorizontalLine() {
        self.scrollView.addSubview(horizontalLine)
        horizontalLine.topAnchor.constraint(equalTo: addressLineTwoLabel.bottomAnchor, constant: 20).isActive = true
        horizontalLine.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        horizontalLine.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        horizontalLine.heightAnchor.constraint(equalToConstant: 0.5).isActive = true
    }
    
    func setupExtraDirectionLabel() {
        self.scrollView.addSubview(extraDirectionLabel)
        extraDirectionLabel.topAnchor.constraint(equalTo: horizontalLine.bottomAnchor, constant: 20).isActive = true
        extraDirectionLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16).isActive = true
    }
    
    func setupExtraDirectionTextField() {
        self.scrollView.addSubview(extraDirectionTextField)
        extraDirectionTextField.topAnchor.constraint(equalTo: extraDirectionLabel.bottomAnchor, constant: 5).isActive = true
        extraDirectionTextField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16).isActive = true
        extraDirectionTextField.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16).isActive = true
        extraDirectionTextField.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    func setupApartmentLabel() {
        self.scrollView.addSubview(apartmentNoLabel)
        apartmentNoLabel.topAnchor.constraint(equalTo: extraDirectionTextField.bottomAnchor, constant: 16).isActive = true
        apartmentNoLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16).isActive = true
    }
    
    func setupApartmentTextField() {
        self.scrollView.addSubview(apartmentNoTextField)
        apartmentNoTextField.topAnchor.constraint(equalTo: apartmentNoLabel.bottomAnchor, constant: 5).isActive = true
        apartmentNoTextField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16).isActive = true
        apartmentNoTextField.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16).isActive = true
        apartmentNoTextField.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    func setupnextButton() {
        self.scrollView.addSubview(nextButton)
        nextButton.topAnchor.constraint(equalTo: apartmentNoTextField.bottomAnchor, constant: 20).isActive = true
        nextButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16).isActive = true
        nextButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16).isActive = true
        nextButton.heightAnchor.constraint(equalToConstant: 60).isActive = true
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
        UserDefaults.standard.set(self.markedLatitude, forKey: MARKED_LATITUDE)
        UserDefaults.standard.set(self.markedLongitude, forKey: MARKED_LONGITUDE)
        switch sender.tag {
        case 1:
            let serviceDescriptionVC = ServiceDescriptionTwoViewController()
            serviceDescriptionVC.isImageSelected = self.isImageSelected
            serviceDescriptionVC.imageArray = self.imageArray
            serviceDescriptionVC.skipServiceOneViewController = self.skipServiceOneViewController
            self.navigationController?.pushViewController(serviceDescriptionVC, animated: false)
        case 3:
            let dateTimeVC = ServiceDateAndTimeOneViewController()
            dateTimeVC.isImageSelected = self.isImageSelected
            dateTimeVC.imageArray = self.imageArray
            dateTimeVC.skipServiceOneViewController = self.skipServiceOneViewController
            self.navigationController?.pushViewController(dateTimeVC, animated: false)
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
    
    @objc func handleNextButton() {
        UserDefaults.standard.set(self.markedLatitude, forKey: MARKED_LATITUDE)
        UserDefaults.standard.set(self.markedLongitude, forKey: MARKED_LONGITUDE)
        let dateTimeVC = ServiceDateAndTimeOneViewController()
        dateTimeVC.isImageSelected = self.isImageSelected
        dateTimeVC.imageArray = self.imageArray
        dateTimeVC.skipServiceOneViewController = self.skipServiceOneViewController
        self.navigationController?.pushViewController(dateTimeVC, animated: false)
    }
    
    @objc func touchTapped(_ sender: UITapGestureRecognizer) {
        
    }
    
    @objc func dismissKeyboard(){
        view.endEditing(true)
    }
    
    @objc func apartmentNoTextFieldChanged() {
        UserDefaults.standard.set(self.apartmentNoTextField.text!, forKey: APARTMENT_NUMBER)
    }
    
    @objc func extraDirectionTextFieldChanged() {
        UserDefaults.standard.set(self.extraDirectionTextField.text!, forKey: EXTRA_DIRECTION)
    }
}

extension ServiceLocationOneViewController : UIScrollViewDelegate {
    
}

extension ServiceLocationOneViewController: CLLocationManagerDelegate {

    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        guard status == .authorizedWhenInUse else { return }
        locationManager.startUpdatingLocation()
        mapView.isMyLocationEnabled = true
    }
}


extension ServiceLocationOneViewController : GMSMapViewDelegate {
    
    // MARK: GMSMapViewDelegate
    func mapView(_ mapView: GMSMapView, idleAt position: GMSCameraPosition) {
        let bottomPoint: CGPoint = CGPoint(x: mapPinImageView.center.x, y: mapPinImageView.center.y + mapPinImageView.frame.height / 2)
        let coordinate = mapView.projection.coordinate(for: bottomPoint)
        
        let geocoder = GMSGeocoder()
        geocoder.reverseGeocodeCoordinate(coordinate) { (response, error) in
            guard let response = response else { return }
            guard let address = response.firstResult() else { return }
            guard let lines = address.lines, let country = address.country else { return }
            var formattedAddress: String = ""
            for line in lines {
                if line != "" {
                    formattedAddress = "\(formattedAddress) \(line),"
                    UserDefaults.standard.set(formattedAddress, forKey: LOCATION)
                }
            }
            formattedAddress.removeLast()
            self.addressLineOneLabel.text = formattedAddress
            self.addressLineTwoLabel.text = country
            
            self.markedLatitude = coordinate.latitude
            self.markedLongitude = coordinate.longitude
        }
    }
}


extension ServiceLocationOneViewController : UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        if textField == self.extraDirectionTextField {
            
            scrollView.setContentOffset(CGPoint(x: 0, y: 320), animated: true)
        }
        else if textField == self.apartmentNoTextField {
            
            scrollView.setContentOffset(CGPoint(x: 0, y: 320), animated: true)
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
