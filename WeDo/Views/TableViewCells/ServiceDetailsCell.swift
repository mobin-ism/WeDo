//
//  ServiceDetailsCell.swift
//  WeDo
//
//  Created by Creativeitem on 18/7/18.
//  Copyright © 2018 Creativeitem. All rights reserved.
//

import UIKit

class ServiceDetailsCell: UITableViewCell {
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.black
        label.font = UIFont(name: OPENSANS_REGULAR, size: 15)
        label.numberOfLines = 0
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let priceLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.black
        label.font = UIFont(name: OPENSANS_REGULAR, size: 15)
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
    
    var priceText: String? = "" {
        didSet {
            priceLabel.text = priceText
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.backgroundColor = UIColor.clear
        self.selectionStyle = .none
        setupSubviews()
    }
    
    func setupSubviews() {
        setupTitleLabel()
        setupPriceLabel()
    }
    
    func setupTitleLabel() {
        self.addSubview(titleLabel)
        titleLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        titleLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 16).isActive = true
    }
    
    func setupPriceLabel() {
        self.addSubview(priceLabel)
        priceLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        priceLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -16).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
