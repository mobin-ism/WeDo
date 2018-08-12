//
//  HTTPRequestHandler.swift
//  WeDo
//
//  Created by Creativeitem on 6/8/18.
//  Copyright © 2018 Creativeitem. All rights reserved.
//

import UIKit
import Alamofire
import SVProgressHUD

class HTTPRequestHandler: UIViewController {
    public static func makeGetHttpRequest(url: URL, parameter: NSDictionary, completionHandler: @escaping (DataResponse<Any>?, Error?) -> ()) {
        SVProgressHUD.setDefaultMaskType(.black)
        SVProgressHUD.show(withStatus: "Please Wait...")
        
        Alamofire.request(url,method: .get, parameters: nil, encoding: URLEncoding.default, headers: ["Content-Type" : "application/x-www-form-urlencoded", "Authorization": AUTH_KEY]).responseJSON(completionHandler: {
            response in
            switch response.result {
            case .success( _):
                SVProgressHUD.dismiss()
                completionHandler(response, nil)
            case .failure(let error):
                SVProgressHUD.dismiss()
                completionHandler(nil, error)
            }
        })
    }
}
