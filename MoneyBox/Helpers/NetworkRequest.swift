//
//  NetworkRequest.swift
//  MoneyBox
//
//  Created by Cerebro on 02/03/2018.
//  Copyright © 2018 thundercatchris. All rights reserved.
//

import Foundation
import Alamofire

// reusable http requests
class NetworkRequest {
    
    private var headers: HTTPHeaders = [
        "AppId":"8cb2237d0679ca88db6464",
        "appVersion":"4.0.0",
        "apiVersion":"3.0.0"]
    
    func postRequest(url: String, parameters: [String : Any], useAuthKey: Bool, completionHandler: @escaping (_ returnedDict: NSDictionary) -> Void) -> Void{
        DispatchQueue.global(qos: .background).async {
            if useAuthKey {
                let defaults = UserDefaults.standard
                let authKey = defaults.string(forKey: "authKey")
                self.headers["Authorization"] = authKey
            }
            
            Alamofire.request(url, method: .post, parameters: parameters, headers: self.headers).responseJSON { response in
                if let data = response.data {
                    do {
                        let json = try JSONSerialization.jsonObject(with: data, options: []) as! NSDictionary
                        completionHandler(json)
                    } catch let error as NSError {
                        print("Failed to load: \(error.localizedDescription)")
                        return
                    }
                }
            }
        }
    }
    
    func getRequest(url: String, completionHandler: @escaping (_ returnedDict: Any?) -> Void) -> Void{
        DispatchQueue.global(qos: .background).async {
            let defaults = UserDefaults.standard
            self.headers["Authorization"] = defaults.string(forKey: "authKey")
            Alamofire.request(url, headers: self.headers).responseJSON { response in
                if let json = response.result.value  {// serialized json response
                    completionHandler(json)
                } else {
                    completionHandler(nil)
                }
            }
        }
    }

    // although this is also a Post request, the parameters are sufficiently different to warrant its own method, IE response type, imputs and outputs
    func logOut(completionHandler: @escaping (_ success: Bool) -> Void) -> Void{
        DispatchQueue.global(qos: .background).async {
            let defaults = UserDefaults.standard
            let authKey = defaults.string(forKey: "authKey")
            self.headers["Authorization"] = authKey
            Alamofire.request("https://api-test00.moneyboxapp.com/users/logout", method: .post, headers: self.headers).responseString { response in
                if response.result.isSuccess {
                    defaults.removeObject(forKey: "authKey")
                }
                completionHandler(response.result.isSuccess)
            }
        }
    }
    
}
