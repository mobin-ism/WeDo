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
        //button.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
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
        layout()
    }
    
    private func layout() {
        setupBackgroundImageView()
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
    
    func setupMapView() {
        view.addSubview(mapView)
        mapView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        mapView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        mapView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        mapView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.6).isActive = true
    }
    
    func setupLocationSearchView() {
        view.addSubview(locationSearchView)
        locationSearchView.topAnchor.constraint(equalTo: view.topAnchor, constant: 16).isActive = true
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
