//
//  TImeCell.swift
//  WeDo
//
//  Created by Creativeitem on 2/9/18.
//  Copyright © 2018 Creativeitem. All rights reserved.
//

import UIKit
class TimeCell: UICollectionViewCell {
    
    var titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = UIColor.black
        label.font = UIFont(name: OPENSANS_REGULAR, size: 11)
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var mainText: String? = "" {
        didSet {
            titleLabel.text = mainText
        }
    }
    
    var bgColor: UIColor? = .white {
        didSet {
            self.backgroundColor = .white
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.white
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.lightGray.cgColor
        self.layer.cornerRadius = 4
        layout()
    }
    
    override var isSelected: Bool {
        didSet {
            layer.borderColor = isSelected ? GREENISH_COLOR.cgColor : UIColor.lightGray.cgColor
            self.backgroundColor = isSelected ? GREENISH_COLOR : UIColor.white
            self.titleLabel.textColor = isSelected ? UIColor.white : UIColor.black
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func layout() {
        setTitleLabel()
    }
    
    private func setTitleLabel() {
        addSubview(titleLabel)
        titleLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        titleLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 5).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -5).isActive = true
    }
    
}
