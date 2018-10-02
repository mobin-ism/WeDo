//
//  SPCurrentJobDetailsViewController.swift
//  WeDo
//
//  Created by Tanvir Hasan Piash on 16/9/18.
//  Copyright © 2018 Creativeitem. All rights reserved.
//

import UIKit

class SPCurrentJobDetailsViewController: UIViewController {
    
    var selectedIndex: Int = 0
    var object: SPDashboardModel?
    
    let backgroundImageView : UIImageView = {
        var imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .clear
        imageView.image = #imageLiteral(resourceName: "bigger-logo")
        return imageView
    }()
    
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
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = GREENISH_COLOR
        label.font = UIFont(name: OPENSANS_REGULAR, size: 18)
        label.numberOfLines = 0
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = UIColor.black
        label.font = UIFont(name: OPENSANS_REGULAR, size: 12)
        label.numberOfLines = 0
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.backgroundColor = UIColor.clear
        view.showsHorizontalScrollIndicator = false
        view.alwaysBounceHorizontal = true
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        view.delegate = self
        view.dataSource = self
        return view
    }()
    
    let addressLabel: UILabel = {
        let label = UILabel()
        label.text = "Address".localized()
        label.textAlignment = .left
        label.textColor = GREENISH_COLOR
        label.font = UIFont(name: OPENSANS_REGULAR, size: 12)
        label.numberOfLines = 0
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let addressValue: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = UIColor.black
        label.font = UIFont(name: OPENSANS_REGULAR, size: 12)
        label.numberOfLines = 0
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let dateLabel: UILabel = {
        let label = UILabel()
        label.text = "Date & Time".localized()
        label.textAlignment = .left
        label.textColor = GREENISH_COLOR
        label.font = UIFont(name: OPENSANS_REGULAR, size: 12)
        label.numberOfLines = 0
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let dateValue: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = UIColor.black
        label.font = UIFont(name: OPENSANS_REGULAR, size: 12)
        label.numberOfLines = 0
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let amountLabel: UILabel = {
        let label = UILabel()
        label.text = "Amount".localized()
        label.textAlignment = .left
        label.textColor = GREENISH_COLOR
        label.font = UIFont(name: OPENSANS_REGULAR, size: 12)
        label.numberOfLines = 0
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let amountValue: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = UIColor.black
        label.font = UIFont(name: OPENSANS_BOLD, size: 14)
        label.numberOfLines = 0
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var notesTextView: UITextView = {
        let view = UITextView()
        view.text = "Note".localized()
        view.backgroundColor = UIColor.clear
        view.textColor = UIColor.lightGray
        view.textAlignment = .left
        view.font = UIFont(name: OPENSANS_REGULAR, size: 12)
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.borderColor = UIColor.init(white: 0.9, alpha: 0.9).cgColor
        view.layer.borderWidth = 1
        view.layer.cornerRadius = 5
        view.delegate = self
        return view
    }()
    
    lazy var jobDoneButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("JOB DONE".localized(), for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.backgroundColor = GREENISH_COLOR
        button.titleLabel?.font = UIFont(name: OPENSANS_REGULAR, size: 16)
        button.clipsToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 5
        button.layer.borderColor = GREENISH_COLOR.cgColor
        button.layer.borderWidth = 1
        button.addTarget(self, action: #selector(jobDoneButtonTapped), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        collectionView.register(SingleImageCell.self, forCellWithReuseIdentifier: SingleImageCell.cellId)
        setNavigationBar()
        layout()
        setupData()
    }
    
    private func setNavigationBar() {
        navigationController?.navigationBar.barTintColor = NAVBAR_BG_COLOR
        let logo = UIImage(named: "logo.png")
        let imageView = UIImageView(image:logo)
        self.navigationItem.titleView = imageView
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "back-icon"), style: .plain, target: self, action: #selector(backTapped))
        //navigationItem.leftBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "menu"), style: .plain, target: self, action: #selector(menuIconTapped))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        Alert.checkInternetConnection(on: self)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        guard let object = object else { return }
        if object.data.selectedJob[selectedIndex].isCompletedByAgent {
            Alert.showBasicAlert(on: self, with: "Message".localized(), message: "Job completed request already sent".localized())
        }
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
    
    private func layout() {
        setupBackgroundImageView()
        setupScrollView()
        setupTitleLabel()
        setupDescriptionLabel()
        setupCollectionView()
        setupAddressLabel()
        setupAddressValue()
        setupDateLabel()
        setupDateValue()
        setupAmountLabel()
        setupAmountValue()
        guard let object = object else { return }
        if !object.data.selectedJob[selectedIndex].isCompletedByAgent {
            setupNotesTextView()
            setupJobDoneButton()
        }
    }
    
    func setupData() {
        guard let object = object else { return }
        titleLabel.text = object.data.selectedJob[selectedIndex].serviceTitle
        descriptionLabel.text = object.data.selectedJob[selectedIndex].description
        addressValue.text = object.data.selectedJob[selectedIndex].area ?? ""
        dateValue.text = object.data.selectedJob[selectedIndex].startDateTime
        amountValue.text = "AED \(object.data.selectedJob[selectedIndex].price)"
    }
    
    func setupBackgroundImageView() {
        view.addSubview(backgroundImageView)
        backgroundImageView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        backgroundImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 25).isActive = true
        backgroundImageView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.5).isActive = true
        backgroundImageView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8).isActive = true
    }
    
    func setupScrollView() {
        view.addSubview(scrollView)
        scrollView.topAnchor.constraint(equalTo: view.topAnchor, constant: Helper.barHeight+(self.navigationController?.navigationBar.frame.size.height)!).isActive = true
        scrollView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        scrollView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    func setupTitleLabel() {
        scrollView.addSubview(titleLabel)
        titleLabel.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16).isActive = true
        titleLabel.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 16).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
    }
    
    func setupDescriptionLabel() {
        scrollView.addSubview(descriptionLabel)
        descriptionLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor).isActive = true
        descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8).isActive = true
        descriptionLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor, constant: 0).isActive = true
    }
    
    func setupCollectionView() {
        scrollView.addSubview(collectionView)
        collectionView.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor).isActive = true
        collectionView.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 16).isActive = true
        collectionView.heightAnchor.constraint(equalToConstant: 80).isActive = true
    }
    
    func setupAddressLabel() {
        scrollView.addSubview(addressLabel)
        addressLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor).isActive = true
        addressLabel.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: 16).isActive = true
        addressLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.3).isActive = true
    }
    
    func setupAddressValue() {
        scrollView.addSubview(addressValue)
        addressValue.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor).isActive = true
        addressValue.topAnchor.constraint(equalTo: addressLabel.bottomAnchor, constant: 4).isActive = true
        addressValue.widthAnchor.constraint(equalTo: addressLabel.widthAnchor).isActive = true
    }
    
    func setupDateLabel() {
        scrollView.addSubview(dateLabel)
        dateLabel.leadingAnchor.constraint(equalTo: addressLabel.trailingAnchor, constant: 12).isActive = true
        dateLabel.topAnchor.constraint(equalTo: addressLabel.topAnchor).isActive = true
        dateLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.3).isActive = true
    }
    
    func setupDateValue() {
        scrollView.addSubview(dateValue)
        dateValue.leadingAnchor.constraint(equalTo: dateLabel.leadingAnchor).isActive = true
        dateValue.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 4).isActive = true
        dateValue.widthAnchor.constraint(equalTo: dateLabel.widthAnchor).isActive = true
    }
    
    func setupAmountLabel() {
        scrollView.addSubview(amountLabel)
        amountLabel.leadingAnchor.constraint(equalTo: dateLabel.trailingAnchor, constant: 12).isActive = true
        amountLabel.topAnchor.constraint(equalTo: addressLabel.topAnchor).isActive = true
        amountLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8).isActive = true
    }
    
    func setupAmountValue() {
        scrollView.addSubview(amountValue)
        amountValue.leadingAnchor.constraint(equalTo: amountLabel.leadingAnchor).isActive = true
        amountValue.topAnchor.constraint(equalTo: amountLabel.bottomAnchor, constant: 4).isActive = true
        amountValue.trailingAnchor.constraint(equalTo: amountLabel.trailingAnchor).isActive = true
    }
    
    func setupNotesTextView() {
        scrollView.addSubview(notesTextView)
        notesTextView.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor).isActive = true
        notesTextView.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor).isActive = true
        notesTextView.topAnchor.constraint(equalTo: addressValue.bottomAnchor, constant: 24).isActive = true
        notesTextView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.2).isActive = true
    }
    
    func setupJobDoneButton() {
        scrollView.addSubview(jobDoneButton)
        jobDoneButton.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor).isActive = true
        jobDoneButton.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor).isActive = true
        jobDoneButton.topAnchor.constraint(equalTo: notesTextView.bottomAnchor, constant: 24).isActive = true
        jobDoneButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    @objc private func backTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc private func jobDoneButtonTapped() {
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
}

extension SPCurrentJobDetailsViewController: UIScrollViewDelegate {
    
}

extension SPCurrentJobDetailsViewController: UITextViewDelegate {
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.text = nil
            textView.textColor = UIColor.black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "Note".localized()
            textView.textColor = UIColor.lightGray
        }
    }
    
}

extension SPCurrentJobDetailsViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let object = object else { return 0 }
        if object.data.selectedJob[selectedIndex].jobThumbnails?.count == 0 {
            return 1
        } else {
            return (object.data.selectedJob[selectedIndex].jobThumbnails?.count)!
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SingleImageCell.cellId, for: indexPath) as? SingleImageCell else {
            let cell = UICollectionViewCell()
            return cell
        }
        if object?.data.selectedJob[selectedIndex].jobThumbnails?.count == 0 {
            cell.image = #imageLiteral(resourceName: "placeholder")
        } else {
            cell.imageView.sd_setImage(with: URL(string: (object?.data.selectedJob[selectedIndex].jobThumbnails![indexPath.item].addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!)!))
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = collectionView.frame.height
        return CGSize(width: height + 16, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
}
