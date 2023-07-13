//
//  JokesRemoteDataStore.swift
//  UnlimitTestProject
//
//  Created by Paras Gupta on 13/07/23.
//

import Foundation

protocol JokesRemoteDataStoreProtocol {
    func getJokes(completion: @escaping (Joke) -> (Void))
}

final class JokesRemoteDataStore: JokesRemoteDataStoreProtocol {
    func getJokes(completion: @escaping (Joke) -> (Void)) {
        // Api end point construction
        let apiEndPoint = APIServiceURL.jokesList.rawValue
        // Data from remote api server
        NetworkServiceUtil.shared.requestData(apiEndPoint: apiEndPoint) { data in
            completion(data)
        }
    }
}
