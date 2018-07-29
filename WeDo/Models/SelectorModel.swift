//
//  SelectorModel.swift
//  WeDo
//
//  Created by Al Mobin on 30/7/18.
//  Copyright © 2018 Creativeitem. All rights reserved.
//

import Foundation
class LanguageNSObject : NSObject {
    
    private var _languageId   : Int
    private var _languageName : String
    
    var languageId : Int {
        get{
            return _languageId
        }
    }
    var languageName : String {
        
        get {
            return _languageName
        }
    }
    
    init(languageId : Int, languageName : String){
        
        self._languageId = languageId
        self._languageName = languageName
    }
    
}
