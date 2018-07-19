//
//  Helper.swift
//  WeDo
//
//  Created by Creativeitem on 17/7/18.
//  Copyright © 2018 Creativeitem. All rights reserved.
//

import UIKit

class Helper {
    
    public static var isIphoneX: Bool {
        if UIDevice().userInterfaceIdiom == .phone {
            switch UIScreen.main.nativeBounds.height {
            case 2436:
                return true
            default:
                return false
            }
        }
        return false
    }
    
    public static func getDateAndTime(timeInterval : Int, dateFormat : String) -> String {
        
        let date = Date(timeIntervalSince1970: TimeInterval(timeInterval / 1000))
        let dayTimePeriodFormatter = DateFormatter()
        dayTimePeriodFormatter.dateFormat = dateFormat // MMM dd YYYY hh:mm a
        dayTimePeriodFormatter.timeZone = TimeZone(identifier: TIME_ZONE)
        let dateString = dayTimePeriodFormatter.string(from: date as Date)
        
        return dateString
    }
    
    public static var barHeight : CGFloat {
        return UIApplication.shared.statusBarFrame.height
    }
}
