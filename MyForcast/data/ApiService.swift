//
//  ApiService.swift
//  MyForcast
//
//  Created by Nidhal on 21/2/2022.
//

import Foundation
import Alamofire

func apiRequest(url: String,
                params: [String: Any],
                headers: [String: String],
                completion:@escaping(_ finished: Bool,
                                     _ response: AnyObject?,
                                     _ statusCode: Int) -> Void) {
    
    let headers = HTTPHeaders(headers)
    AF.request(url, method: .get,
               parameters: params,
               encoding: URLEncoding.default,
               headers: headers).response { response in
        switch response.result {
        case .success:
            if let data = response.data {
                completion(true,
                           data as AnyObject?,
                           response.response?.statusCode ?? -1)
            } else {
                completion(true,
                           response.response as AnyObject?,
                           response.response?.statusCode ?? -1)
            }
            
        case .failure(let error):
            print(error)
            /* If Case is failure, we can send it to VM to goal to tell user */
            completion(false,
                       response.error as AnyObject?,
                       response.response?.statusCode ?? -1)
        }
    }
}
