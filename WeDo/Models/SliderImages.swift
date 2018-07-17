//
//  SliderImages.swift
//  WeDo
//
//  Created by Creativeitem on 17/7/18.
//  Copyright © 2018 Creativeitem. All rights reserved.
//

import UIKit

class SliderImages: NSObject {
    
    private var _image: String
    
    var image: String {
        get {
            return _image
        }
    }
    
    init(image: String) {
        self._image = image
    }
    
}
