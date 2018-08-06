//
//  ServiceModel.swift
//  WeDo
//
//  Created by Creativeitem on 6/8/18.
//  Copyright © 2018 Creativeitem. All rights reserved.
//

import Foundation

struct Services : Decodable {
    let services : [ServicesDetails]
}

struct ServicesDetails : Decodable {
    let id : Int
    let title : String
    let smallIconOne : String
    let child : [SubServices]
}

struct SubServices : Decodable {
    let id : Int
    let title : String
    let subTitle : String
    let smallIconOne : String
}

class ServicesNSObject : NSObject {
    private var _id : Int
    private var _title : String
    private var _smallIconOne : String
    
    var serviceId : Int {
        get {
            return _id
        }
    }
    
    var serviceTitle : String {
        get {
            return _title
        }
    }
    
    var serviceIcon : String {
        get {
            return _smallIconOne
        }
    }
    
    init(serviceId : Int, serviceTtile : String, serviceIcon : String) {
        self._id = serviceId
        self._title = serviceTtile
        self._smallIconOne = serviceIcon
    }
}

class SubServicesNSObject : NSObject {
    private var _id : Int
    private var _title : String
    private var _smallIconOne : String
    
    var subServiceId : Int {
        get {
            return _id
        }
    }
    
    var serviceTitle : String {
        get {
            return _title
        }
    }
    
    var serviceIcon : String {
        get {
            return _smallIconOne
        }
    }
    
    init(subServiceId : Int, serviceTtile : String, serviceIcon : String) {
        self._id = subServiceId
        self._title = serviceTtile
        self._smallIconOne = serviceIcon
    }
}
