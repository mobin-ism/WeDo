//
//  SPProfileModel.swift
//  WeDo
//
//  Created by Tanvir Hasan Piash on 22/9/18.
//  Copyright © 2018 Creativeitem. All rights reserved.
//

import Foundation

struct SPProfileModel: Decodable {
    let data: SPProfileData
    let code: Int
    let message: String
    let isSuccess: Bool
}

struct SPProfileData: Decodable {
    let basicInformation: SPBasicInformation
    let serviceDetails: [SPServiceDetails]
    let serviceLocationDetails: [String]?
}

struct SPBasicInformation: Decodable {
    let id: Int
    let phoneNumber: String
    let name: String?
    let email: String?
    let cityId: Int
    let image: String
    let jobCategory: String?
    let workExperience: Int
    let rating: Double
    let totalReviews: Int
    let totalFiveStars: Int
    let totalFourStars: Int
    let totalThreeStars: Int
    let totalTwoStars: Int
    let totalOneStars: Int
    let totalJobDone: Int
    let latitude: Double
    let longitude: Double
    let address: String?
    let companyName: String
    let companyEmail: String
    let companyAddress: String
    let companyLogo: String
    let companyPhone: String
}

struct SPServiceDetails: Decodable {
    let agentServiceId: Int
    let agentId: Int
    let serviceId: Int
    let serviceTitle: String
    let serviceSubTitle: String?
    let serviceIcon: String
    let serviceParentId: Int
    let serviceParentTitle: String
    let serviceParentIcon: String
    let isHourlyBasis: Bool
    let isAcceptBid: Bool
    let hourlyRate: Int
    let daylyRate: Int
}
