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
    let smallIconTwo : String
    let child : [SubServices]
}

struct SubServices : Decodable {
    let id : Int
    let title : String
    let smallIconOne : String
}

struct SubServiceDetails : Decodable {
    let data : SubServiceDetailsData
}

struct SubServiceDetailsData : Decodable {
    let services : [SubServiceDetailsServices]
}

struct SubServiceDetailsServices : Decodable {
    let parentTitle : String
    let parentSmallIconOne : String
    let childTitle : String
    let id : Int
    let title : String
    let rate : Int
}

class ServicesNSObject : NSObject {
    private var _id : Int
    private var _title : String
    private var _smallIconOne : String
    private var _smallIconTwo : String
    
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
    
    var serviceIconRegular : String {
        get {
            return _smallIconOne
        }
    }
    
    var serviceIconWhite : String {
        get {
            return _smallIconTwo
        }
    }
    
    init(serviceId : Int, serviceTtile : String, serviceIconRegular : String, serviceIconWhite : String) {
        self._id = serviceId
        self._title = serviceTtile
        self._smallIconOne = serviceIconRegular
        self._smallIconTwo  = serviceIconWhite
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
