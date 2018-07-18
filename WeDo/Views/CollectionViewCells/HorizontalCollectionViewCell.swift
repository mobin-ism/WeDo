//
//  HorizontalCollectionViewCell.swift
//  WeDo
//
//  Created by Creativeitem on 18/7/18.
//  Copyright © 2018 Creativeitem. All rights reserved.
//

import UIKit
class HorizontalCollectionViewCell: UICollectionViewCell {
    
    lazy var imageContainerView  : UIView = {
       var view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        view.backgroundColor = .clear
        
        return view
    }()
    
    lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.systemLayoutSizeFitting(CGSize(width: 200, height: 200))
        return imageView
    }()
    
    var titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = UIColor.black
        label.font = UIFont(name: OPENSANS_REGULAR, size: 13)
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var mainImage: UIImage? = nil {
        didSet {
            imageView.image = mainImage
        }
    }
    
    var mainText: String? = "" {
        didSet {
            titleLabel.text = mainText
        }
    }
    
    var bgColor: UIColor? = .white {
        didSet {
            self.backgroundColor = bgColor
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.white
        layout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func layout() {
        setImageContainerView()
        setImageView()
        setTitleLabel()
    }
    
    private func setImageContainerView() {
        addSubview(imageContainerView)
        imageContainerView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        imageContainerView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        imageContainerView.heightAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1).isActive = true
        imageContainerView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1).isActive = true
    }
    private func setImageView() {
        imageContainerView.addSubview(imageView)
        imageView.centerYAnchor.constraint(equalTo: imageContainerView.centerYAnchor).isActive = true
        imageView.centerXAnchor.constraint(equalTo: imageContainerView.centerXAnchor).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 60).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 60).isActive = true
    }
    
    private func setTitleLabel() {
        addSubview(titleLabel)
        titleLabel.topAnchor.constraint(equalTo: imageContainerView.bottomAnchor, constant: 5).isActive = true
        titleLabel.centerXAnchor.constraint(equalTo: imageContainerView.centerXAnchor).isActive = true
    }
    
}
