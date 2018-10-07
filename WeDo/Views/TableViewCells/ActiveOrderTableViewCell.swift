//
//  OrderTableViewCell.swift
//  WeDo
//
//  Created by Creativeitem on 26/7/18.
//  Copyright © 2018 Creativeitem. All rights reserved.
//

import UIKit

class ActiveOrderTableViewCell: UITableViewCell {
    
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
        label.font = UIFont(name: OPENSANS_REGULAR, size: 15)
        label.numberOfLines = 0
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let statusLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.darkGray
        label.font = UIFont(name: OPENSANS_REGULAR, size: 12)
        label.numberOfLines = 0
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let subTitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.darkGray
        label.font = UIFont(name: OPENSANS_REGULAR, size: 11)
        label.numberOfLines = 0
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let quoteLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.darkGray
        label.font = UIFont(name: OPENSANS_REGULAR, size: 12)
        label.numberOfLines = 0
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let quoteNumberLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.black
        label.font = UIFont(name: OPENSANS_REGULAR, size: 15)
        label.numberOfLines = 0
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var expandButton : UIButton = {
       var button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.clipsToBounds = true
        return button
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
    
    var statusText: String? = "" {
        didSet {
            statusLabel.text = statusText
        }
    }
    
    var quoteNumber: String? = "" {
        didSet {
            quoteNumberLabel.text = quoteNumber
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.backgroundColor = UIColor.clear
        self.selectionStyle = .none
        
        
        setupSubviews()
    }
    
    func setupSubviews() {
        setupServiceImageView()
        setupTitleLabel()
        setupStatusLabel()
        setupSubTitleLabel()
        setupExpandButton()
        setupQuoteNumber()
        setupQuoteLable()
    }
    
    func setupServiceImageView() {
        self.addSubview(serviceImageView)
        serviceImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        serviceImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16).isActive = true
        serviceImageView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        serviceImageView.widthAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    func setupTitleLabel() {
        self.addSubview(titleLabel)
        titleLabel.topAnchor.constraint(equalTo: serviceImageView.topAnchor).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: serviceImageView.trailingAnchor, constant: 10).isActive = true
    }
    
    func setupStatusLabel() {
        self.addSubview(statusLabel)
        statusLabel.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor).isActive = true
        statusLabel.leadingAnchor.constraint(equalTo: titleLabel.trailingAnchor, constant: 5).isActive = true
    }
    
    func setupSubTitleLabel() {
        self.addSubview(subTitleLabel)
        subTitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10).isActive = true
        subTitleLabel.leadingAnchor.constraint(equalTo: serviceImageView.trailingAnchor, constant: 10).isActive = true
    }
    
    func setupExpandButton() {
        self.addSubview(expandButton)
        expandButton.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        expandButton.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        expandButton.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 1).isActive = true
        expandButton.widthAnchor.constraint(equalToConstant: 55).isActive = true
    }
    
    func setupQuoteNumber() {
        self.addSubview(quoteNumberLabel)
        quoteNumberLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        quoteNumberLabel.trailingAnchor.constraint(equalTo: expandButton.leadingAnchor).isActive = true
    }
    
    func setupQuoteLable() {
        self.addSubview(quoteLabel)
        quoteLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        quoteLabel.trailingAnchor.constraint(equalTo: quoteNumberLabel.leadingAnchor, constant: -10).isActive = true
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        serviceImageView.image = nil
        expandButton.setImage(nil, for: .normal)
        quoteNumberLabel.text = ""
        quoteLabel.text = ""
    }
}
