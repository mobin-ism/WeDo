//
//  SPRegisterAddressViewController.swift
//  WeDo
//
//  Created by Tanvir Hasan Piash on 15/9/18.
//  Copyright © 2018 Creativeitem. All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlaces

class SPRegisterAddressViewController: UIViewController {
    
    lazy var menu: Menu = {
        let slideMenu = Menu()
        slideMenu.spRegisterAddressVC = self
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
    
    lazy var mapView: GMSMapView = {
        let view = GMSMapView()
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        view.settings.myLocationButton = true
        view.delegate = self
        return view
    }()
    
    lazy var locationSearchView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isUserInteractionEnabled = true
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(searchViewTapped)))
        return view
    }()
    
    let searchImageView: UIImageView = {
        let view = UIImageView(image: #imageLiteral(resourceName: "search"))
        view.contentMode = .scaleAspectFit
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var locationSearchLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = UIColor.black
        label.numberOfLines = 1
        label.font = UIFont(name: OPENSANS_REGULAR, size: 13)
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        label.isUserInteractionEnabled = true
        label.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(searchViewTapped)))
        return label
    }()
    
    lazy var locationSearchViewController: GMSAutocompleteViewController = {
        let viewController = GMSAutocompleteViewController()
        let filter = GMSAutocompleteFilter()
        filter.country = "UAE"
        viewController.autocompleteFilter = filter
        viewController.delegate = self
        return viewController
    }()
    
    let addressLabel: UILabel = {
        let label = UILabel()
        label.text = "Address".localized()
        label.textAlignment = .left
        label.textColor = UIColor.black
        label.numberOfLines = 1
        label.font = UIFont(name: OPENSANS_REGULAR, size: 16)
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
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
    
    let addressValue: UILabel = {
        let label = UILabel()
        label.text = "..."
        label.textAlignment = .left
        label.textColor = UIColor.black
        label.numberOfLines = 4
        label.font = UIFont(name: OPENSANS_REGULAR, size: 14)
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        locationManager.requestWhenInUseAuthorization()
        setNavigationBar()
        layout()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        addressButton.titleLabel?.font = UIFont(name: OPENSANS_BOLD, size: 12)
    }
    
    private func setNavigationBar() {
        navigationController?.navigationBar.barTintColor = NAVBAR_BG_COLOR
        let logo = UIImage(named: "logo.png")
        let imageView = UIImageView(image:logo)
        self.navigationItem.titleView = imageView
        //navigationItem.leftBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "back-icon"), style: .plain, target: self, action: #selector(backTapped))
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "menu"), style: .plain, target: self, action: #selector(menuIconTapped))
    }
    
    private func layout() {
        setupBackgroundImageView()
        setupCompanyButton()
        setupAddressButton()
        setupDateTimeButton()
        setupServicesButton()
        setupMapView()
        setupLocationSearchView()
        setupSearchImage()
        setupSearchLabel()
        setupAddressLabel()
        setupNextButton()
        setupAddressValue()
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
    
    func setupMapView() {
        view.addSubview(mapView)
        mapView.topAnchor.constraint(equalTo: companyButton.bottomAnchor).isActive = true
        mapView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        mapView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        mapView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.6).isActive = true
    }
    
    func setupLocationSearchView() {
        view.addSubview(locationSearchView)
        locationSearchView.topAnchor.constraint(equalTo: companyButton.bottomAnchor, constant: 16).isActive = true
        locationSearchView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8).isActive = true
        locationSearchView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8).isActive = true
        locationSearchView.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }
    
    func setupSearchImage() {
        locationSearchView.addSubview(searchImageView)
        searchImageView.centerYAnchor.constraint(equalTo: locationSearchView.centerYAnchor).isActive = true
        searchImageView.leadingAnchor.constraint(equalTo: locationSearchView.leadingAnchor, constant: 8).isActive = true
        searchImageView.heightAnchor.constraint(equalToConstant: 24).isActive = true
        searchImageView.widthAnchor.constraint(equalToConstant: 24).isActive = true
    }
    
    func setupSearchLabel() {
        locationSearchView.addSubview(locationSearchLabel)
        locationSearchLabel.centerYAnchor.constraint(equalTo: locationSearchView.centerYAnchor).isActive = true
        locationSearchLabel.leadingAnchor.constraint(equalTo: searchImageView.trailingAnchor, constant: 8).isActive = true
        locationSearchLabel.trailingAnchor.constraint(equalTo: locationSearchView.trailingAnchor, constant: -8).isActive = true
    }
    
    func setupAddressLabel() {
        view.addSubview(addressLabel)
        addressLabel.topAnchor.constraint(equalTo: mapView.bottomAnchor, constant: 16).isActive = true
        addressLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
    }
    
    func setupNextButton() {
        view.addSubview(nextButton)
        nextButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        nextButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
        nextButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -16).isActive = true
        nextButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    func setupAddressValue() {
        view.addSubview(addressValue)
        addressValue.leadingAnchor.constraint(equalTo: addressLabel.leadingAnchor).isActive = true
        addressValue.topAnchor.constraint(equalTo: addressLabel.bottomAnchor, constant: 10).isActive = true
        addressValue.trailingAnchor.constraint(equalTo: nextButton.trailingAnchor).isActive = true
    }
    
    @objc func searchViewTapped() {
        present(locationSearchViewController, animated: true, completion: nil)
    }
    
    @objc private func menuIconTapped() {
        self.menu.show(self)
    }
    
    @objc private func navigationButtonTapped(_ sender: UIButton) {
        switch sender.tag {
        case 1:
            navigationController?.pushViewController(SPRegisterCompanyViewController(), animated: false)
        case 3:
            navigationController?.pushViewController(SPRegisterDateTimeViewController(), animated: false)
        case 4:
            navigationController?.pushViewController(SPRegisterServicesViewController(), animated: false)
        default:
            print("current view controller")
        }
    }
    
    @objc func nextButtonTapped() {
        let destination = SPRegisterDateTimeViewController()
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

extension SPRegisterAddressViewController: GMSMapViewDelegate {
    
}

extension SPRegisterAddressViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        guard status == .authorizedWhenInUse else { return }
        locationManager.startUpdatingLocation()
        mapView.isMyLocationEnabled = true
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        mapView.camera = GMSCameraPosition(target: location.coordinate, zoom: 12, bearing: 0, viewingAngle: 0)
        locationManager.stopUpdatingLocation()
    }
    
}

extension SPRegisterAddressViewController: GMSAutocompleteViewControllerDelegate {
    func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
        print(place.name)
    }
    
    func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error) {
        print(error.localizedDescription)
    }
    
    func wasCancelled(_ viewController: GMSAutocompleteViewController) {
        dismiss(animated: true, completion: nil)
    }
    
    func didRequestAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
    }
    
    func didUpdateAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
    }
    
}
