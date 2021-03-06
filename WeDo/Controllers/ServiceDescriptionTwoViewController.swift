//
//  ServiceDescriptionTwoViewController.swift
//  WeDo
//
//  Created by Creativeitem on 19/7/18.
//  Copyright © 2018 Creativeitem. All rights reserved.
//

import UIKit
class ServiceDescriptionTwoViewController: UIViewController {
    
    var skipServiceOneViewController : Bool = false
    var imagePicker = UIImagePickerController()
    var imageArray = [#imageLiteral(resourceName: "placeholder"), #imageLiteral(resourceName: "placeholder"), #imageLiteral(resourceName: "placeholder")]
    var isImageSelected : Bool = false
    var numberOfItems : Int!
    lazy var backgroundImageView : UIImageView = {
        var imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .clear
        imageView.image = #imageLiteral(resourceName: "bigger-logo")
        return imageView
    }()
    
    lazy var serviceIconImageView : UIImageView = {
        var imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .clear
        //imageView.image = #imageLiteral(resourceName: "dummy2")
        return imageView
    }()
    
    lazy var scrollView: UIScrollView = {
        let scroll = UIScrollView(frame: .zero)
        scroll.showsVerticalScrollIndicator = false
        scroll.backgroundColor = UIColor.clear
        scroll.delegate = self
        scroll.translatesAutoresizingMaskIntoConstraints = false
        return scroll
    }()
    
    lazy var serviceTitleLabel : UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.clipsToBounds = true
        label.textAlignment = .left
        //label.text = "Cleaning"
        label.numberOfLines = 0
        label.textColor = UIColor.black
        label.font = UIFont(name: OPENSANS_REGULAR, size: 16)
        return label
    }()
    
    lazy var subServiceTitleLabel : UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.clipsToBounds = true
        label.textAlignment = .left
        //label.text = "Full House Cleaning"
        label.numberOfLines = 0
        label.textColor = UIColor.gray
        label.font = UIFont(name: OPENSANS_REGULAR, size: 12)
        return label
    }()
    
    lazy var descriptionButton : UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.clipsToBounds = true
        button.backgroundColor = UIColor(red:64/255, green:173/255, blue:93/255, alpha:0.9)
        button.setTitle("Description", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
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
    
    lazy var horizontalLineOne : UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        view.backgroundColor = UIColor(red:0.62, green:0.62, blue:0.62, alpha:0.5)
        return view
    }()
    
    lazy var horizontalLineTwo : UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        view.backgroundColor = UIColor(red:0.62, green:0.62, blue:0.62, alpha:0.5)
        return view
    }()
    
    lazy var jobTitleLabel : UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.clipsToBounds = true
        label.textAlignment = .left
        //label.text = "1 Bed Room"
        label.numberOfLines = 0
        label.textColor = UIColor.black
        label.font = UIFont(name: OPENSANS_REGULAR, size: 15)
        return label
    }()
    
    lazy var servicePriceLabel : UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.clipsToBounds = true
        label.textAlignment = .right
        //label.text = "100 AED"
        label.numberOfLines = 0
        label.textColor = UIColor.black
        label.font = UIFont(name: OPENSANS_REGULAR, size: 15)
        return label
    }()
    
    lazy var addImageLabel : UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.clipsToBounds = true
        label.textAlignment = .center
        label.text = "Add Images(Optional)"
        label.numberOfLines = 0
        label.textColor = UIColor.black
        label.font = UIFont(name: OPENSANS_REGULAR, size: 15)
        return label
    }()
    
    lazy var descriptionLabel : UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.clipsToBounds = true
        label.textAlignment = .center
        label.text = "Description"
        label.numberOfLines = 0
        label.textColor = UIColor.black
        label.font = UIFont(name: OPENSANS_REGULAR, size: 15)
        return label
    }()
    
    lazy var nextButton : UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.clipsToBounds = true
        button.backgroundColor = UIColor(red:0.17, green:0.67, blue:0.31, alpha:1.0)
        button.setTitle("Next", for: .normal)
        button.titleLabel?.font = UIFont(name: OPENSANS_REGULAR, size: 15)
        button.layer.cornerRadius = 5
        button.addTarget(self, action: #selector(handleNextButton), for: .touchUpInside)
        return button
    }()
    
    lazy var descriptionTextField : PaddedTextView = {
        var textview = PaddedTextView()
        textview.isEditable = true
        textview.translatesAutoresizingMaskIntoConstraints = false
        textview.clipsToBounds = true
        textview.layer.borderWidth = 1
        textview.layer.borderColor = UIColor(red:0.62, green:0.62, blue:0.62, alpha:0.5).cgColor
        textview.layer.cornerRadius = 5
        textview.font = UIFont(name: OPENSANS_REGULAR, size: 12)
        textview.text = "Write your job details"
        textview.textColor = UIColor.black
        textview.delegate = self
        return textview
    }()
    
    let cancelButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("CANCEL", for: .normal)
        button.titleLabel?.font = UIFont(name: OPENSANS_SEMIBOLD, size: 14)
        button.setTitleColor(UIColor.black, for: .normal)
        button.backgroundColor = UIColor.white
        button.layer.cornerRadius = 4
        button.layer.borderColor = UIColor.black.cgColor
        button.layer.borderWidth = 1
        button.clipsToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(cancelButtonTapped(_:)), for: .touchUpInside)
        button.titleLabel?.textAlignment = .center
        return button
    }()
    
    let addImageButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("+", for: .normal)
        button.titleLabel?.font = UIFont(name: OPENSANS_BOLD, size: 20)
        button.setTitleColor(UIColor.white, for: .normal)
        button.backgroundColor = UIColor.black
        button.layer.cornerRadius = 4
        button.layer.borderColor = UIColor.black.cgColor
        button.layer.borderWidth = 1
        button.clipsToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(addNewImageButtonTapped(_:)), for: .touchUpInside)
        button.titleLabel?.lineBreakMode = NSLineBreakMode.byWordWrapping
        button.titleLabel?.textAlignment = .center
        return button
    }()
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.backgroundColor = UIColor.clear
        collection.showsVerticalScrollIndicator = false
        collection.alwaysBounceVertical = false
        collection.delegate = self
        collection.dataSource = self
        collection.clipsToBounds = true
        collection.translatesAutoresizingMaskIntoConstraints = false
        return collection
    }()
    
    let serviceRequestImageCellID = "ServiceRequestImageCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        numberOfItems = self.imageArray.count
        view.backgroundColor = UIColor.white
        setNavigationBar()
        layout()
        collectionView.register(ServiceRequestImageCell.self, forCellWithReuseIdentifier: serviceRequestImageCellID)
        
        self.imagePicker.delegate = self
        
        // Adding outside tap will dismiss the keyboard
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.collectionView.reloadData()
        if !self.skipServiceOneViewController {
            self.getSubServiceDetails(subServiceId: UserDefaults.standard.value(forKey: SUB_SERVICE_ID) as! Int, selectedJobId: UserDefaults.standard.value(forKey: JOB_ID) as! Int)
        }
        
        self.descriptionTextField.text = UserDefaults.standard.value(forKey: DESCRIPTION) as! String
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        var contentHeight: CGFloat = 0
        for view in scrollView.subviews {
            contentHeight = contentHeight + view.frame.size.height
        }
        scrollView.contentSize = CGSize(width: view.frame.width, height: contentHeight + 140)
        self.addImageButton.layer.cornerRadius = addImageButton.frame.height / 2
    }
    
    private func setNavigationBar() {
        navigationController?.navigationBar.barTintColor = NAVBAR_BG_COLOR
        let logo = UIImage(named: "logo.png")
        let imageView = UIImageView(image:logo)
        self.navigationItem.titleView = imageView
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "back-icon"), style: .plain, target: self, action: #selector(backTapped))
        self.navigationController?.navigationBar.shadowImage = UIImage()
    }
    
    func layout() {
        setupBackgroundImageView()
        setupDescriptionButton()
        setupLocationButton()
        setupDateTimeButton()
        //setupPaymentButton()
        setupScrollView()
        if !self.skipServiceOneViewController {
            setupServiceIconImageView()
            setupServiceTitleLabel()
            setupSubServiceTitleLabel()
            setupHorizontalLabelOne()
            setupJobTitleLabel()
            setupServicePriceLabel()
            setupHorizontalLabelTwo()
        }
        setupDescriptionLabel()
        setupDescriptionTextField()
        setupNextButton()
        setCollectionView()
        setAddNewImageButton()
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
    
    func setupServiceIconImageView() {
        scrollView.addSubview(serviceIconImageView)
        serviceIconImageView.topAnchor.constraint(equalTo: descriptionButton.bottomAnchor, constant: 20).isActive = true
        serviceIconImageView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16).isActive = true
        serviceIconImageView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        serviceIconImageView.widthAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    func setupServiceTitleLabel() {
        scrollView.addSubview(serviceTitleLabel)
        serviceTitleLabel.topAnchor.constraint(equalTo: descriptionButton.bottomAnchor, constant: 20).isActive = true
        serviceTitleLabel.leftAnchor.constraint(equalTo: serviceIconImageView.rightAnchor, constant: 10).isActive = true
    }
    
    func setupSubServiceTitleLabel() {
        scrollView.addSubview(subServiceTitleLabel)
        subServiceTitleLabel.topAnchor.constraint(equalTo: serviceTitleLabel.bottomAnchor, constant: 5).isActive = true
        subServiceTitleLabel.leftAnchor.constraint(equalTo: serviceIconImageView.rightAnchor, constant: 10).isActive = true
    }
    
    func setupHorizontalLabelOne() {
        view.addSubview(horizontalLineOne)
        horizontalLineOne.topAnchor.constraint(equalTo: serviceIconImageView.bottomAnchor, constant: 16).isActive = true
        horizontalLineOne.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        horizontalLineOne.heightAnchor.constraint(equalToConstant: 1).isActive = true
    }
    
    func setupJobTitleLabel() {
        scrollView.addSubview(jobTitleLabel)
        jobTitleLabel.topAnchor.constraint(equalTo: horizontalLineOne.bottomAnchor, constant: 16).isActive = true
        jobTitleLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16).isActive = true
        jobTitleLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.7).isActive = true
    }
    
    func setupServicePriceLabel() {
        scrollView.addSubview(servicePriceLabel)
        servicePriceLabel.centerYAnchor.constraint(equalTo: jobTitleLabel.centerYAnchor).isActive = true
        servicePriceLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16).isActive = true
        servicePriceLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.3).isActive = true
    }
    
    func setupHorizontalLabelTwo() {
        view.addSubview(horizontalLineTwo)
        horizontalLineTwo.topAnchor.constraint(equalTo: jobTitleLabel.bottomAnchor, constant: 16).isActive = true
        horizontalLineTwo.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        horizontalLineTwo.heightAnchor.constraint(equalToConstant: 1).isActive = true
    }
    
    func setupDescriptionLabel() {
        scrollView.addSubview(descriptionLabel)
        if self.skipServiceOneViewController {
            descriptionLabel.topAnchor.constraint(equalTo: descriptionButton.bottomAnchor, constant: 20).isActive = true
        }else {
            descriptionLabel.topAnchor.constraint(equalTo: horizontalLineTwo.bottomAnchor, constant: 16).isActive = true
        }
        descriptionLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16).isActive = true
    }
    
    func setupDescriptionTextField() {
        scrollView.addSubview(descriptionTextField)
        descriptionTextField.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 10).isActive = true
        descriptionTextField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16).isActive = true
        descriptionTextField.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16).isActive = true
        descriptionTextField.heightAnchor.constraint(equalToConstant: 100).isActive = true
    }
    
    func setupNextButton() {
        scrollView.addSubview(nextButton)
        nextButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -16).isActive = true
        nextButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16).isActive = true
        nextButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16).isActive = true
        nextButton.heightAnchor.constraint(equalToConstant: 60).isActive = true
    }
    
    private func setCollectionView() {
        scrollView.addSubview(collectionView)
        let rows: CGFloat = (CGFloat(numberOfItems)/3).rounded(.up)
        _ = (view.frame.width / 3) * (rows) - 32
        collectionView.topAnchor.constraint(equalTo: descriptionTextField.bottomAnchor, constant: 50).isActive = true
        collectionView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16).isActive = true
        collectionView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: nextButton.topAnchor, constant: -16).isActive = true
    }
    
    private func setAddNewImageButton(){
        scrollView.addSubview(addImageButton)
        addImageButton.topAnchor.constraint(equalTo: collectionView.topAnchor, constant: -25).isActive = true
        addImageButton.rightAnchor.constraint(equalTo: collectionView.rightAnchor, constant: -10).isActive = true
        addImageButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        addImageButton.widthAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    @objc func rightBarButtonTapped() {
        
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
        case 2:
            let locationVC = ServiceLocationOneViewController()
            locationVC.isImageSelected = self.isImageSelected
            locationVC.imageArray = self.imageArray
            locationVC.skipServiceOneViewController = self.skipServiceOneViewController
            self.navigationController?.pushViewController(locationVC, animated: false)
        case 3:
            let dateTimeVC = ServiceDateAndTimeOneViewController()
            dateTimeVC.isImageSelected = self.isImageSelected
            dateTimeVC.imageArray = self.imageArray
            dateTimeVC.skipServiceOneViewController = self.skipServiceOneViewController
            self.navigationController?.pushViewController(dateTimeVC, animated: false)
        case 4:
            let paymentVC  = ServicePaymentOneViewController()
            paymentVC.isImageSelected = self.isImageSelected
            paymentVC.imageArray = self.imageArray
            paymentVC.skipServiceOneViewController = self.skipServiceOneViewController
            self.navigationController?.pushViewController(paymentVC, animated: false)
        default:
            print("current view controller")
        }
    }
    
    @objc private func cancelButtonTapped(_ sender: UIButton){
        
    }
    
    @objc private func addNewImageButtonTapped(_ sender: UIButton){
        let alert = UIAlertController(title: "Choose Image", message: nil, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Camera", style: .default, handler: { _ in
            self.openCamera()
        }))
        
        alert.addAction(UIAlertAction(title: "Gallery", style: .default, handler: { _ in
            self.openGallary()
        }))
        alert.addAction(UIAlertAction.init(title: "Cancel", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    private func openCamera() {
        if UIImagePickerController.isSourceTypeAvailable(.camera){
            
            imagePicker.sourceType = .camera
            imagePicker.allowsEditing = false
            
            self.present(imagePicker, animated: true, completion: nil)
        }
        else
        {
            let alert  = UIAlertController(title: "Warning", message: "You don't have camera", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    private func openGallary() {
        if UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum){
            
            imagePicker.sourceType = .savedPhotosAlbum
            imagePicker.allowsEditing = false
            
            self.present(imagePicker, animated: true, completion: nil)
        }
        else
        {
            let alert  = UIAlertController(title: "Warning", message: "You don't have camera", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    @objc func dismissKeyboard(){
        view.endEditing(true)
    }
    
    @objc func handleNextButton() {
        let locationVC = ServiceLocationOneViewController()
        locationVC.isImageSelected = self.isImageSelected
        locationVC.imageArray = self.imageArray
        locationVC.skipServiceOneViewController = self.skipServiceOneViewController
        self.navigationController?.pushViewController(locationVC, animated: false)
    }
}

extension ServiceDescriptionTwoViewController : UIScrollViewDelegate {
    
}

extension ServiceDescriptionTwoViewController: UISearchControllerDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.imageArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: serviceRequestImageCellID, for: indexPath) as? ServiceRequestImageCell else {
            let cell = collectionView.cellForItem(at: indexPath)!
            return cell
        }
        if !self.isImageSelected {
            cell.removeButton.alpha = 0
        }
        else {
            cell.removeButton.alpha = 1
            cell.removeButton.tag = indexPath.row
            cell.removeButton.addTarget(self, action: #selector(removeImage(sender:)), for: .touchUpInside)
        }
        cell.mainImage = imageArray[indexPath.row]
        
        return cell
    }
    
    @objc private func removeImage(sender: UIButton) {
        
        self.imageArray.remove(at: sender.tag)
        self.collectionView.reloadData()
    }
}

extension ServiceDescriptionTwoViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width: CGFloat = collectionView.frame.width / 3 - 4
        let height: CGFloat = width
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 4
    }
    
}

extension ServiceDescriptionTwoViewController : UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
// Local variable inserted by Swift 4.2 migrator.
let info = convertFromUIImagePickerControllerInfoKeyDictionary(info)

        
        if let image = info[convertFromUIImagePickerControllerInfoKey(UIImagePickerController.InfoKey.originalImage)] as? UIImage {
            
            if !isImageSelected {
                self.imageArray.removeAll()
            }
            
            self.imageArray.append(image)
            self.isImageSelected = true
            self.numberOfItems = self.imageArray.count
            
            self.collectionView.reloadData()
            self.collectionView.collectionViewLayout.invalidateLayout()
        }
        
        picker.dismiss(animated: true, completion: nil);
    }
    
    private func resizeImage(image: UIImage, targetSize: CGSize) -> UIImage {
        
        let size = image.size
        
        let widthRatio  = targetSize.width  / size.width
        let heightRatio = targetSize.height / size.height
        
        // Figure out what our orientation is, and use that to form the rectangle
        var newSize: CGSize
        if(widthRatio > heightRatio) {
            newSize = CGSize(width: size.width * heightRatio, height: size.height * heightRatio)
        } else {
            newSize = CGSize(width: size.width * widthRatio,  height: size.height * widthRatio)
        }
        
        // This is the rect that we've calculated out and this is what is actually used below
        let rect = CGRect(origin: CGPoint(x: 0,y :0), size: CGSize(width: newSize.width, height: newSize.height))
        
        // Actually do the resizing to the rect using the ImageContext stuff
        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        image.draw(in: rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage!
    }
    
    func resizeImage2(image: UIImage, newWidth: CGFloat) -> UIImage {
        
        let scale = newWidth / image.size.width
        let newHeight = image.size.height * scale
        UIGraphicsBeginImageContext(CGSize(width: newWidth, height: newHeight))
        image.draw(in: CGRect(origin: CGPoint(x: 0,y :0), size: CGSize(width: newWidth, height: newHeight)))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage!
        
    }
}

extension ServiceDescriptionTwoViewController : UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
}

extension ServiceDescriptionTwoViewController : UITextViewDelegate {
    /*func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.text = nil
            textView.textColor = UIColor.black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "Write your job details"
            textView.textColor = UIColor.lightGray
        }
    }*/
    func textViewDidChange(_ textView: UITextView) { //Handle the text changes here
        UserDefaults.standard.set(textView.text, forKey: DESCRIPTION)
    }
}


// API CALLS
extension ServiceDescriptionTwoViewController {
    func getSubServiceDetails(subServiceId : Int, selectedJobId : Int) {
        guard let url2 = URL(string: "\(BASE_URL)api/v2/general/child/sub/services/\(subServiceId)") else { return }
        HTTPRequestHandler.makeGetHttpRequest(url: url2, parameter: [:]) { (response, nil) in
            guard let response = response else { return }
            
            if let json = response.data {
                let decoder = JSONDecoder()
                do {
                    let subServiceDetailsList = try decoder.decode(SubServiceDetails.self, from: json)
                    for jobList in subServiceDetailsList.data.services {
                        if  jobList.id == selectedJobId {
                            self.serviceTitleLabel.text = jobList.parentTitle
                            self.subServiceTitleLabel.text = jobList.childTitle
                            self.serviceIconImageView.sd_setImage(with: URL(string: jobList.parentSmallIconOne), placeholderImage: #imageLiteral(resourceName: "cloud-download"), options: [.continueInBackground], completed: nil)
                            self.jobTitleLabel.text = jobList.title
                            self.servicePriceLabel.text = "\(jobList.rate) AED"
                        }
                    }
                }catch let err {
                    print(err)
                }
            }
        }
    }
}

// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertFromUIImagePickerControllerInfoKeyDictionary(_ input: [UIImagePickerController.InfoKey: Any]) -> [String: Any] {
	return Dictionary(uniqueKeysWithValues: input.map {key, value in (key.rawValue, value)})
}

// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertFromUIImagePickerControllerInfoKey(_ input: UIImagePickerController.InfoKey) -> String {
	return input.rawValue
}
