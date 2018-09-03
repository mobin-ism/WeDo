//
//  MemberModel.swift
//  WeDo
//
//  Created by Creativeitem on 3/9/18.
//  Copyright © 2018 Creativeitem. All rights reserved.
//

import Foundation
struct Member : Decodable {
    let data : MemberData
    let isSuccess : Bool
}
struct MemberData : Decodable {
    let member : MemberDetails
}
struct MemberDetails : Decodable {
    let id : Int
    let securityCode : String
    let token : String
}

