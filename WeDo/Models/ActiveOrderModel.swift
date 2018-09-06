//
//  ActiveOrderModel.swift
//  WeDo
//
//  Created by Creativeitem on 5/9/18.
//  Copyright © 2018 Creativeitem. All rights reserved.
//

import Foundation
struct ActiveOrderModel : Decodable {
    let data : ActiveOrderData
}

struct ActiveOrderData : Decodable {
    let jobRequestList : [JobRequestList]
}

struct JobRequestList : Decodable {
    let id : Int
    let serviceId : Int
    let parentServiceTitle : String
    let serviceTitle : String
    let description : String?
    let serviceIcon : String?
    let status : String?
    let startDateTime : String?
    let bidAmount : Int?
}

class ActiveOrderNSObject {
    private var _id : Int
    private var _serviceId : Int
    private var _parentServiceTitle : String
    private var _serviceTitle : String
    private var _description : String
    private var _serviceIcon : String
    private var _status : String
    private var _startDateTime : String
    private var _bidAmount : Int
    
    var id : Int {
        get{
            return _id        }
    }
    
    var serviceId : Int {
        get{
            return _serviceId        }
    }
    
    var parentServiceTitle : String {
        get{
            return _parentServiceTitle        }
    }
    
    var serviceTitle : String {
        get{
            return _serviceTitle        }
    }
    
    var description : String {
        get{
            return _description        }
    }
    
    var serviceIcon : String {
        get{
            return _serviceIcon        }
    }
    
    var status : String {
        get{
            return _status        }
    }
    
    var startDateTime : String {
        get{
            return _startDateTime        }
    }
    
    var bidAmount : Int {
        get{
            return _bidAmount        }
    }
    
    
    
    init(id : Int, serviceId : Int, parentServiceTitle : String, serviceTitle : String, description : String, serviceIcon : String, status : String, startDateTime : String, bidAmount : Int) {
        self._id = id
        self._serviceId = serviceId
        self._parentServiceTitle = parentServiceTitle
        self._serviceTitle = serviceTitle
        self._description = description
        self._serviceIcon = serviceIcon
        self._status = status
        self._startDateTime = startDateTime
        self._bidAmount = bidAmount
    }
}
