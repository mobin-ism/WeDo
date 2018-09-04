//
//  RequestAServiceModel.swift
//  WeDo
//
//  Created by Creativeitem on 4/9/18.
//  Copyright © 2018 Creativeitem. All rights reserved.
//

import Foundation
struct RequestAServiceModel : Decodable {
    let data : RequestAServiceModelData
    let isSuccess : Bool
}

struct RequestAServiceModelData : Decodable {
    let serviceRequest : ServiceRequest
}

struct ServiceRequest : Decodable {
    let id : Int
    let amount : Int
}
