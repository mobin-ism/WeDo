//
//  SPServiceHeaderCell.swift
//  WeDo
//
//  Created by Tanvir Hasan Piash on 22/9/18.
//  Copyright © 2018 Creativeitem. All rights reserved.
//

import UIKit

class SPServiceHeaderCell: UITableViewHeaderFooterView {
    
    public static let cellId = "SPServiceHeaderCellId"
    
    let mainImageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let mainLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.black
        label.textAlignment = .left
        label.font = UIFont(name: OPENSANS_REGULAR, size: 16)
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        layout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func layout() {
        addSubview(mainImageView)
        mainImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16).isActive = true
        mainImageView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        mainImageView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.6).isActive = true
        mainImageView.widthAnchor.constraint(equalTo: heightAnchor, multiplier: 0.6).isActive = true
        addSubview(mainLabel)
        mainLabel.centerYAnchor.constraint(equalTo: mainImageView.centerYAnchor).isActive = true
        mainLabel.leadingAnchor.constraint(equalTo: mainImageView.trailingAnchor, constant: 16).isActive = true
    }
    
}
