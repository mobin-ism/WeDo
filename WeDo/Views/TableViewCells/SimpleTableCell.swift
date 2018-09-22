//
//  SimpleTableCell.swift
//  WeDo
//
//  Created by Tanvir Hasan Piash on 23/9/18.
//  Copyright © 2018 Creativeitem. All rights reserved.
//

import UIKit

class SimpleTableCell: UITableViewCell {
    
    public static let cellId = "SimpleTableCellId"
    
    let mainLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = UIColor.black
        label.font = UIFont(name: OPENSANS_REGULAR, size: 14)
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = UIColor.clear
        selectionStyle = .none
        addSubview(mainLabel)
        mainLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        mainLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16).isActive = true
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        accessoryType = selected ? .checkmark : .none
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
