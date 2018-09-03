//
//  AreaModel.swift
//  WeDo
//
//  Created by Creativeitem on 6/8/18.
//  Copyright © 2018 Creativeitem. All rights reserved.
//

import Foundation

struct Area : Decodable {
    let data : AreaData
}

struct AreaData : Decodable {
    let city : [AreaCity]
}
struct AreaCity : Decodable {
    let id : Int
    let name : String
}

class AreaNSObject : NSObject {
    
    private var _areaId   : Int
    private var _areaName : String
    
    var areaId : Int {
        get{
            return _areaId
        }
    }
    var areaName : String {
        
        get {
            return _areaName
        }
    }
    
    init(areaId : Int, areaName : String){
        
        self._areaId = areaId
        self._areaName = areaName
    }
}
