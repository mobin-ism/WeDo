//
//  CompanyTableViewCell.swift
//  WeDo
//
//  Created by Creativeitem on 29/7/18.
//  Copyright © 2018 Creativeitem. All rights reserved.
//

import UIKit
class CompanyTableViewCell: UITableViewCell {
    
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
    
    let lastJobDateTitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.black
        label.font = UIFont(name: OPENSANS_REGULAR, size: 11)
        label.numberOfLines = 0
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Last Job Date"
        return label
    }()
    
    let lastJobDateLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.black
        label.font = UIFont(name: OPENSANS_BOLD, size: 11)
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
    
    var lastJobDateText: String? = "" {
        didSet {
            lastJobDateLabel.text = lastJobDateText
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
        setupServiceDateTimeLable()
        setupLastJobDateTitleLabel()
        setupLastJobDateLabel()
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
    
    func setupServiceDateTimeLable() {
        self.addSubview(dateTimeLabel)
        dateTimeLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10).isActive = true
        dateTimeLabel.leftAnchor.constraint(equalTo: serviceImageView.rightAnchor, constant: 10).isActive = true
    }
    
    func setupLastJobDateTitleLabel() {
        self.addSubview(lastJobDateTitleLabel)
        lastJobDateTitleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 16).isActive = true
        lastJobDateTitleLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -16).isActive = true
    }
    
    func setupLastJobDateLabel() {
        self.addSubview(lastJobDateLabel)
        lastJobDateLabel.topAnchor.constraint(equalTo: lastJobDateTitleLabel.bottomAnchor, constant: 5).isActive = true
        lastJobDateLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -16).isActive = true
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
