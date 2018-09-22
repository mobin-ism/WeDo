//
//  ServiceProviderModel.swift
//  WeDo
//
//  Created by Tanvir Hasan Piash on 21/9/18.
//  Copyright © 2018 Creativeitem. All rights reserved.
//

import Foundation

struct ServiceProviderModel: Decodable {
    let data: ServiceProviderData
    let code: Int
    let message: String
    let isSuccess: Bool
}

struct ServiceProviderData: Decodable {
    let agent: Agent
    let isNew: Bool
}

struct Agent: Decodable {
    let id: Int
    let phoneNumber: String
    let name: String?
    let email: String?
    let rating: Double
    let totalReviews: Int
    let totalFiveStars: Int
    let totalFourStars: Int
    let totalThreeStars: Int
    let totalTwoStars: Int
    let totalOneStars: Int
    let totalJobDone: Int
    let cityId: Int
    let image: String
    let token: String
    let isIndividual: Bool
    let companyName: String
    let companyEmail: String
    let companyAddress: String
    let companyLogo: String
    let companyPhone: String
    let cities: [String]?
    let services: [Service]
}

struct Service: Decodable {
    let id: Int
    let agentId: Int
    let serviceId: Int
    let serviceName: String
    let hourlyRate: Int
    let perDayRate: Int
    let isBidAccept: Bool
    let isHourly: Bool
}
