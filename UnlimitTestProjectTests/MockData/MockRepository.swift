//
//  MockRepository.swift
//  UnlimitTestProjectTests
//
//  Created by Paras Gupta on 14/07/23.
//

import Foundation
@testable import UnlimitTestProject

final class MockJokesLocalDataStore: JokesLocalDataStoreProtocol {
    var mockJokes: [Joke] = []
    var jokeCount: Int {
        mockJokes.count
    }
    
    func getJokes() -> [Joke] {
        mockJokes
    }
    
    func saveJoke(_ joke: Joke) {
        mockJokes.append(joke)
    }
    
    func removeFirst() {
        mockJokes.removeFirst()
    }
}

final class MockJokesRemoteDataStore: JokesRemoteDataStoreProtocol {
    var mockJoke: Joke = Joke(joke: "I am remote Joke")
                        
    func getJokes(completion: @escaping (Joke) -> (Void)) {
        completion(mockJoke)
    }
}
