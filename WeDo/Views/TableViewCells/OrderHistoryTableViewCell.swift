//
//  OrderHistoryTableViewCell.swift
//  WeDo
//
//  Created by Creativeitem on 29/7/18.
//  Copyright © 2018 Creativeitem. All rights reserved.
//

import UIKit
class OrderHistoryTableViewCell: UITableViewCell {
    
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
        label.textColor = UIColor.black
        label.font = UIFont(name: OPENSANS_REGULAR, size: 14)
        label.numberOfLines = 0
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let subTitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.gray
        label.font = UIFont(name: OPENSANS_REGULAR, size: 11)
        label.numberOfLines = 2
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let dateTimeLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.gray
        label.font = UIFont(name: OPENSANS_REGULAR, size: 11)
        label.numberOfLines = 1
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let jobLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.black
        label.font = UIFont(name: OPENSANS_REGULAR, size: 14)
        label.numberOfLines = 0
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let serviceChargeLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.black
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
    
    var dateTimeText: String? = "" {
        didSet {
            dateTimeLabel.text = dateTimeText
        }
    }
    
    var jobText: String? = "" {
        didSet {
            jobLabel.text = jobText
        }
    }
    
    var serviceChargeText: String? = "" {
        didSet {
            serviceChargeLabel.text = serviceChargeText
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
        setupDateTimeLabel()
        setupJobLabel()
        setupServiceChargeLable()
        setupSubTitleLabel()
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
        subTitleLabel.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor).isActive = true
        subTitleLabel.leftAnchor.constraint(equalTo: titleLabel.rightAnchor, constant: 5).isActive = true
        subTitleLabel.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.3).isActive = true
    }
    
    func setupDateTimeLabel() {
        self.addSubview(dateTimeLabel)
        dateTimeLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10).isActive = true
        dateTimeLabel.leftAnchor.constraint(equalTo: serviceImageView.rightAnchor, constant: 10).isActive = true
    }
    
    func setupJobLabel() {
        self.addSubview(jobLabel)
        jobLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 16).isActive = true
        jobLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -16).isActive = true
    }
    
    func setupServiceChargeLable() {
        self.addSubview(serviceChargeLabel)
        serviceChargeLabel.topAnchor.constraint(equalTo: jobLabel.bottomAnchor, constant: 5).isActive = true
        serviceChargeLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -16).isActive = true
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

