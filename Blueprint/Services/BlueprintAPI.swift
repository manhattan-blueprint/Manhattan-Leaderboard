//
//  BlueprintAPI.swift
//  Blueprint
//
//  Created by Jay Lees on 26/02/2019.
//  Copyright © 2019 Manhattan. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireSwiftyJSON

public class BlueprintAPI {
    private static let baseURL = "http://smithwjv.ddns.net"
    private static let authenticateURL = "\(baseURL):8000/api/v1"
    private static let inventoryURL = "\(baseURL):8001/api/v1"
    private static let resourceURL = "\(baseURL):8002/api/v1"

    public class func login(username: String, password: String, callback: @escaping (Result<Void, String>) -> Void) {
        let params = ["username": username, "password": password]
        
        Alamofire.request("\(authenticateURL)/authenticate", method: HTTPMethod.post, parameters: params, encoding: JSONEncoding.default).responseSwiftyJSON { response in
            switch response.result {
            case .success(let data):
                guard let refreshToken = data["refresh"].string, let accessToken = data["access"].string else {
                    callback(.failure(data["error"].string ?? "An unknown error occurred"))
                    return
                }
                
                KeychainManager.accessToken = accessToken
                KeychainManager.refreshToken = refreshToken
                callback(Result.success(Void()))
                
            case .failure(let error):
                callback(.failure(error.localizedDescription))
            }
        }
    }
}