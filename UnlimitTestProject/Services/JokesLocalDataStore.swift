//
//  JokesLocalDataStore.swift
//  UnlimitTestProject
//
//  Created by Paras Gupta on 14/07/23.
//

import Foundation

protocol JokesLocalDataStoreProtocol {
    var jokeCount: Int { get }
    func getJokes() -> [Joke]
    func saveJoke(_ joke: Joke)
    func removeFirst()
}

final class JokesLocalDataStore: JokesLocalDataStoreProtocol {
    private var jokes: [Joke] = []
    private let userDefault: UserDefaults
    private let userDefaultKey = "local_jokes"
    
    init(_ userDefault: UserDefaults = UserDefaults.standard) {
        self.userDefault = userDefault
    }
    
    var jokeCount: Int {
        jokes.count
    }
    
    func getJokes() -> [Joke] {
        guard let jokeData = userDefault.object(forKey: userDefaultKey) as? Data else { return [] }
        do {
            let decoder = JSONDecoder()
            let jokesFromUserDefault = try decoder.decode([Joke].self, from: jokeData)
                jokes = jokesFromUserDefault
                return jokesFromUserDefault
            } catch {
                print("Unable to get jokes from user default")
                return []
        }
    }
    
    func saveJoke(_ joke: Joke) {
        jokes.append(joke)
        saveJokesInDefaults(jokes)
    }
    
    func removeFirst() {
        jokes.removeFirst()
        saveJokesInDefaults(jokes)
    }
    
    private func saveJokesInDefaults(_ jokes: [Joke]) {
        do {
            let encoder = JSONEncoder()
            let jokeData = try encoder.encode(jokes)
            userDefault.setValue(jokeData, forKey: userDefaultKey)
        } catch {
            print("Unable to save joke")
        }
    }
}

