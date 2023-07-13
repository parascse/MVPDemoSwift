//
//  NetworkServiceUtil.swift
//  UnlimitTestProject
//
//  Created by Paras Gupta on 12/07/23.
//

import Foundation

import Foundation

enum APIError: String, Error {
    case noNetwork = "No Network"
    case invalidData = "Unexpected data from api"
}

class NetworkServiceUtil {
    
    static let shared = NetworkServiceUtil()
        
    func requestData<T: Codable>(apiEndPoint: String, completion: @escaping (T) -> Void){
        // API Request
        let urlRequest = URLRequest(url: URL(string: apiEndPoint)!)
        URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            if let data = data {
                //Store in persistent store
                UserDefaults.standard.setValue(data, forKey: apiEndPoint)
                //Parse the daya
                let jsonDecoder = JSONDecoder()
                let data = try! jsonDecoder.decode(T.self, from: data)
                completion(data)
            }
        }.resume()
    }
}
