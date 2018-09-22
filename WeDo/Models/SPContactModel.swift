//
//  SPContactModel.swift
//  WeDo
//
//  Created by Tanvir Hasan Piash on 21/9/18.
//  Copyright © 2018 Creativeitem. All rights reserved.
//

import Foundation

struct SPContactModel: Decodable {
    let data: ContactData
    let code: Int
    let message: String
    let isSuccess: Bool
}

struct ContactData: Decodable {
    let contact: ContactValue
}

struct ContactValue: Decodable {
    let id: Int
    let title: String
    let address: String
    let email: String
    let phoneNumber: String
}
