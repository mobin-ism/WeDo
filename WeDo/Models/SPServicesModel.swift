//
//  SPServicesModel.swift
//  WeDo
//
//  Created by Tanvir Hasan Piash on 22/9/18.
//  Copyright © 2018 Creativeitem. All rights reserved.
//

import Foundation

struct SPServicesModel: Decodable {
    let services: [SPService]
    let code: Int
    let message: String
    let isSuccess: Bool
}

struct SPService: Decodable {
    let id: Int
    let title: String
    let subTitle: String?
    let horizontalScroll: Bool
    let smallIconOne: String
    let bigIconOne: String
    let smallIconTwo: String
    let bigIconTwo: String
    let child: [SPServiceChild]
}

struct SPServiceChild: Decodable {
    let id: Int
    let title: String
    let subTitle: String?
    let smallIconOne: String
    let bigIconOne: String
    let smallIconTwo: String
    let bigIconTwo: String
}
