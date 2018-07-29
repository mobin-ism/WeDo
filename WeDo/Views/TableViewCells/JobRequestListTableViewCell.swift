//
//  JobRequestListTableViewCell.swift
//  WeDo
//
//  Created by Creativeitem on 29/7/18.
//  Copyright © 2018 Creativeitem. All rights reserved.
//

import UIKit
import HCSStarRatingView

class JobRequestListTableViewCell: UITableViewCell {
    
    let serviceImageView : UIImageView = {
        var imageview = UIImageView()
        imageview.translatesAutoresizingMaskIntoConstraints = false
        imageview.clipsToBounds = true
        imageview.contentMode = .scaleToFill
        imageview.layer.cornerRadius = 5
        return imageview
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = GREENISH_COLOR
        label.font = UIFont(name: OPENSANS_REGULAR, size: 14)
        label.numberOfLines = 0
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let subTitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = GREENISH_COLOR
        label.font = UIFont(name: OPENSANS_REGULAR, size: 11)
        label.numberOfLines = 1
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let serviceChargeLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.black
        label.font = UIFont(name: OPENSANS_BOLD, size: 14)
        label.numberOfLines = 0
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var starRatingView : HCSStarRatingView = {
        var view = HCSStarRatingView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        view.maximumValue = 5
        view.minimumValue = 1
        view.value = 3
        view.tintColor = UIColor(red:0.96, green:0.50, blue:0.09, alpha:1.0)
        view.allowsHalfStars = true
        view.isUserInteractionEnabled = false
        view.isEnabled = false
        view.alpha = 1
        return view
    }()
    
    let numberOfReviewLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.gray
        label.font = UIFont(name: OPENSANS_REGULAR, size: 11)
        label.numberOfLines = 0
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var titleText: String? = "" {
        didSet {
            titleLabel.text = titleText
        }
    }
    
    var subTitleText: String? = "" {
        didSet {
            subTitleLabel.text = subTitleText
        }
    }
    
    var serviceChargeText: String? = "" {
        didSet {
            serviceChargeLabel.text = serviceChargeText
        }
    }
    
    var numberOfReviewText: String? = "" {
        didSet {
            numberOfReviewLabel.text = numberOfReviewText
        }
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.backgroundColor = UIColor.clear
        self.selectionStyle = .none
        setupSubviews()
    }
    
    func setupSubviews() {
        setupServiceImageView()
        setupTitleLabel()
        setupSubTitleLabel()
        setupServiceChargeLable()
        setupNumberOfReviewLabel()
        setupStarReviewView()
    }
    
    func setupServiceImageView() {
        self.addSubview(serviceImageView)
        serviceImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        serviceImageView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 16).isActive = true
        serviceImageView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        serviceImageView.widthAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    func setupTitleLabel() {
        self.addSubview(titleLabel)
        titleLabel.topAnchor.constraint(equalTo: serviceImageView.topAnchor).isActive = true
        titleLabel.leftAnchor.constraint(equalTo: serviceImageView.rightAnchor, constant: 10).isActive = true
    }
    
    func setupSubTitleLabel() {
        self.addSubview(subTitleLabel)
        subTitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5).isActive = true
        subTitleLabel.leftAnchor.constraint(equalTo: serviceImageView.rightAnchor, constant: 10).isActive = true
    }
    
    func setupServiceChargeLable() {
        self.addSubview(serviceChargeLabel)
        serviceChargeLabel.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor).isActive = true
        serviceChargeLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -16).isActive = true
    }
    
    func setupNumberOfReviewLabel() {
        self.addSubview(numberOfReviewLabel)
        numberOfReviewLabel.topAnchor.constraint(equalTo: serviceChargeLabel.bottomAnchor, constant: 5).isActive = true
        numberOfReviewLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -16).isActive = true
    }
    
    func setupStarReviewView(){
        self.addSubview(starRatingView)
        starRatingView.centerYAnchor.constraint(equalTo: numberOfReviewLabel.centerYAnchor).isActive = true
        starRatingView.rightAnchor.constraint(equalTo: numberOfReviewLabel.leftAnchor, constant: -5).isActive = true
        starRatingView.heightAnchor.constraint(equalToConstant: 60).isActive = true
        starRatingView.widthAnchor.constraint(equalToConstant: 70).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
