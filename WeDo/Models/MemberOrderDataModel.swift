//
//  MemberOrderDataModel.swift
//  WeDo
//
//  Created by Tanvir Hasan Piash on 5/10/18.
//  Copyright © 2018 Creativeitem. All rights reserved.
//

import Foundation

struct MemberOrderDataModel: Decodable {
    let data: MemberOrderData
    let code: Int
    let message: String
    let isSuccess: Bool
}

struct MemberOrderData: Decodable {
    let jobRequestList: [MemberJobRequestList]
}

struct MemberJobRequestList: Decodable {
    let id: Int
    let title: String?
    let description: String?
    let serviceId: Int
    let serviceTitle: String
    let serviceIcon: String
    let serviceIconTwo: String
    let serviceIconThree: String
    let serviceIconFour: String
    let parentServiceTitle: String
    let parentServiceIcon: String
    let parentServiceIconTwo: String
    let parentServiceIconThree: String
    let parentServiceIconFour: String
    let area: String
    let latitude: Double
    let longitude: Double
    let time: String
    let isShowPriceButton: Bool
    let startDateTime: String
    let startDate: String
    let status: String
    let bidAmount: Int
    let isQuickBid: Bool
    let isNormalBid: Bool
    let jobImages: [String]?
    let jobThumbnails: [String]?
    let isCompletedByAgent: Bool
    let agentCompletedDate: String
    let isCompletedByMember: Bool
    let memberCompletedDate: String
    let isAgentSelected: Bool
    let paymentType: String
    let paymentCode: String
    let isPaymentComplete: Bool
    let isCancelled:  Bool
    let createdTimeStamp: Int
    let customerId: Int
    let customerName: String
    let customerPhone: String
    let customerArea: String
    let customerLocation: String
    let totalAgent: Int
    let agents: [MemberAgent]?
}

struct MemberAgent: Decodable {
    let id: Int
    let phoneNumber: String
    let name: String?
    let email: String?
    let photo: String?
    let cityId: Int
    let jobCategory: String?
    let workExperience: Int
    let rating: Int
    let totalReviews: Int
    let totalJobDone: Int
    let latitude: Double
    let longitude: Double
    let address: String?
    let rate: String
    let perHourRate: String
    let perDayRate: String
    let isIndividual: Bool
    let companyName: String?
    let companyEmail: String?
    let companyAddress: String?
    let companyLogo: String?
    let companyPhone: String?
    let serviceRequestBidId: Int
    let serviceRequestBidAmount: Int
    let sortKey: Int
}
