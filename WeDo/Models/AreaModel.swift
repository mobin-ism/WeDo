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
