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
        label.textColor = UIColor.lightGray
        label.font = UIFont(name: OPENSANS_REGULAR, size: 12)
        label.numberOfLines = 2
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.backgroundColor = UIColor.clear
        self.selectionStyle = .none
        
        
        setupSubviews()
    }
    
    func setupSubviews() {
        setupServiceImageView()
        setupTitleLabel()
        setupSubTitleLabel()
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
        titleLabel.leadingAnchor.constraint(equalTo: serviceImageView.trailingAnchor, constant: 12).isActive = true
    }
    
    func setupSubTitleLabel() {
        self.addSubview(subTitleLabel)
        subTitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4).isActive = true
        subTitleLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor).isActive = true
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        serviceImageView.image = nil
    }
}

