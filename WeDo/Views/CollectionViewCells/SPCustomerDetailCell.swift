//
//  SPCustomerDetailCell.swift
//  WeDo
//
//  Created by Tanvir Hasan Piash on 17/9/18.
//  Copyright © 2018 Creativeitem. All rights reserved.
//

import UIKit

class SPCustomerDetailCell: UICollectionViewCell {
    
    public static let cellId = "SPCustomerDetailCellId"
    
    let itemName: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.black
        label.textAlignment = .left
        label.font = UIFont(name: OPENSANS_REGULAR, size: 12)
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let itemValue: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.lightGray
        label.textAlignment = .left
        label.font = UIFont(name: OPENSANS_REGULAR, size: 12)
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let divider: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.init(white: 0.9, alpha: 0.9)
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.clear
        layout()
    }
    
    func layout() {
        addSubview(itemName)
        itemName.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        itemName.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16).isActive = true
        addSubview(itemValue)
        itemValue.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        itemValue.leadingAnchor.constraint(equalTo: itemName.trailingAnchor, constant: 8).isActive = true
        addSubview(divider)
        divider.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        divider.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        divider.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        divider.heightAnchor.constraint(equalToConstant: 1).isActive = true
    }
    
    func setData(name: String, value: String) {
        itemName.text = name
        itemValue.text = value
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
