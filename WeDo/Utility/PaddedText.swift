//
//  PaddedText.swift
//  WeDo
//
//  Created by Al Mobin on 22/7/18.
//  Copyright © 2018 Creativeitem. All rights reserved.
//

import UIKit

class PaddedTextField: UITextField {
    
    let padding = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 5);
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return UIEdgeInsetsInsetRect(bounds, padding)
    }
    
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return UIEdgeInsetsInsetRect(bounds, padding)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return UIEdgeInsetsInsetRect(bounds, padding)
    }
}

class PaddedTextView: UITextView {
    override func layoutSubviews() {
        super.layoutSubviews()
        setup()
    }
    func setup() {
        textContainerInset = UIEdgeInsets.init(top: 16, left: 16, bottom: 16, right: 16)
        textContainer.lineFragmentPadding = 0
    }
}

