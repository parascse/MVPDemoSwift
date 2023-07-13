//
//  JokeListRepository.swift
//  UnlimitTestProject
//
//  Created by Paras Gupta on 14/07/23.
//

import Foundation

final class JokeListRepository {
    
    private let localRepository: JokesLocalDataStoreProtocol
    private let remoteRepository: JokesRemoteDataStoreProtocol
    let jokeLimit: Int
    
    init(localRepository: JokesLocalDataStoreProtocol = JokesLocalDataStore(),
         remoteRepository: JokesRemoteDataStoreProtocol = JokesRemoteDataStore(),
         jokeLimit: Int = 10) {
        self.localRepository = localRepository
        self.remoteRepository = remoteRepository
        self.jokeLimit = jokeLimit
    }
    
    func getJokes(completion: @escaping ([Joke]) -> (Void)) {
        let localData = self.localRepository.getJokes()
        if !localData.isEmpty {
            remoteRepository.getJokes { [weak self] joke in
                guard let self = self else { return }
                if self.isSaveJokeLimitOver {
                    self.localRepository.removeFirst()
                }
                self.localRepository.saveJoke(joke)
                let allJokes = self.localRepository.getJokes()
                completion(allJokes)
            }
        } else {
            completion(localData)
        }
    }
    
    var isSaveJokeLimitOver: Bool {
        localRepository.jokeCount >= jokeLimit
    }
}
