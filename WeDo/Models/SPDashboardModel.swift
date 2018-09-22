//
//  SPDashboardModel.swift
//  WeDo
//
//  Created by Tanvir Hasan Piash on 22/9/18.
//  Copyright © 2018 Creativeitem. All rights reserved.
//

import Foundation

struct SPDashboardModel: Decodable {
    let data: SPDashboardData
    let code: Int
    let message: String
    let isSuccess: Bool
}

struct SPDashboardData: Decodable {
    let totalJob: Int
    let totalRunning: Int
    let totalDue: Int?
    let selectedJob: [SPDashboardJob]
    let jobRequestList: [SPDashboardJob]
    let newJobList: [SPDashboardJob]
}

struct SPDashboardJob: Decodable {
    let id: Int
    let title: String?
    let description: String
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
    let area: String?
    let latitude: Double
    let longitude: Double
    let time: String
    let price: Int
    let isShowPriceButton: Bool
    let startDateTime: String
    let status: String
    let jobImages: [String]?
    let jobThumbnails: [String]?
    let bidAmount: Int
    let isQuickBid: Bool
    let isNormalBid: Bool
    let isCompletedByAgent: Bool
    let agentCompletedDate: String
    let isCompletedByMember: Bool
    let memberCompletedDate: String
    let isAgentSelected: Bool
    let paymentType: String
    let paymentCode: String
    let isPaymentComplete: Bool
    let isCancelled: Bool
    let createdTimeStamp: Int
    let customerId: Int
    let customerName: String
    let customerPhone: String
    let customerArea: String
    let customerLocation: String?
    let serviceRequestBidId: Int
    let serviceRequestBidAmount: Int
}
