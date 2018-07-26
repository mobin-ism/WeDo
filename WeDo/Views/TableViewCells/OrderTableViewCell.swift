//
//  OrderTableViewCell.swift
//  WeDo
//
//  Created by Creativeitem on 26/7/18.
//  Copyright © 2018 Creativeitem. All rights reserved.
//

import UIKit

class OrderTableViewCell: UITableViewCell {
    
    let serviceImageView : UIImageView = {
       var imageview = UIImageView()
        imageview.translatesAutoresizingMaskIntoConstraints = false
        imageview.clipsToBounds = true
        imageview.contentMode = .scaleToFill
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
        label.textColor = UIColor.black
        label.font = UIFont(name: OPENSANS_REGULAR, size: 12)
        label.numberOfLines = 0
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let subTitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.black
        label.font = UIFont(name: OPENSANS_REGULAR, size: 11)
        label.numberOfLines = 0
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let quoteLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.black
        label.font = UIFont(name: OPENSANS_REGULAR, size: 12)
        label.numberOfLines = 0
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Quote: "
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
    
    let expandButton : UIButton = {
       var button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.clipsToBounds = true
        button.setImage(#imageLiteral(resourceName: "down-arrow"), for: .normal)
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
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
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
        serviceImageView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 16).isActive = true
        serviceImageView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        serviceImageView.widthAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    func setupTitleLabel() {
        self.addSubview(titleLabel)
        titleLabel.topAnchor.constraint(equalTo: serviceImageView.topAnchor).isActive = true
        titleLabel.leftAnchor.constraint(equalTo: serviceImageView.rightAnchor, constant: 10).isActive = true
    }
    
    func setupStatusLabel() {
        self.addSubview(statusLabel)
        statusLabel.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor).isActive = true
        statusLabel.leftAnchor.constraint(equalTo: titleLabel.rightAnchor, constant: 5).isActive = true
    }
    
    func setupSubTitleLabel() {
        self.addSubview(subTitleLabel)
        subTitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10).isActive = true
        subTitleLabel.leftAnchor.constraint(equalTo: serviceImageView.rightAnchor, constant: 10).isActive = true
    }
    
    func setupExpandButton() {
        self.addSubview(expandButton)
        expandButton.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        expandButton.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        expandButton.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 1).isActive = true
        expandButton.widthAnchor.constraint(equalToConstant: 55).isActive = true
    }
    
    func setupQuoteNumber() {
        self.addSubview(quoteNumberLabel)
        quoteNumberLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        quoteNumberLabel.rightAnchor.constraint(equalTo: expandButton.leftAnchor).isActive = true
    }
    
    func setupQuoteLable() {
        self.addSubview(quoteLabel)
        quoteLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        quoteLabel.rightAnchor.constraint(equalTo: quoteNumberLabel.leftAnchor, constant: -10).isActive = true
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
