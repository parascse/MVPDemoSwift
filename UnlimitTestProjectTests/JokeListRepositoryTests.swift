//
//  JokeListRepositoryTests.swift
//  UnlimitTestProjectTests
//
//  Created by Paras Gupta on 14/07/23.
//
import XCTest
@testable import UnlimitTestProject

final class JokeListRepositoryTests: XCTestCase {
    private var jokesLocalDataStore: JokesLocalDataStoreProtocol!
    private var jokesRemoteDataStore: JokesRemoteDataStoreProtocol!
    private var jokeListRepository: JokeListRepository!
    private var mockJokeLimit: Int = 2
    
    override func setUp() {
        jokesLocalDataStore = MockJokesLocalDataStore()
        jokesRemoteDataStore = MockJokesRemoteDataStore()

        jokeListRepository = JokeListRepository(localRepository: jokesLocalDataStore,
                                                remoteRepository: jokesRemoteDataStore,
                                                jokeLimit: mockJokeLimit)
    }
    
    func testIsSaveJokeLimitOver() {
   
        /// Verify initially is not over
        XCTAssertFalse(jokeListRepository.isSaveJokeLimitOver)
      
        /// Initally save 2  new Joke
        let newJoke1: Joke = Joke(joke: "I am first Joke")
        let newJoke2: Joke = Joke(joke: "I am second Joke")
        jokesLocalDataStore?.saveJoke(newJoke1)
        jokesLocalDataStore?.saveJoke(newJoke2)
        
        /// Verify both are saved
        XCTAssertTrue(jokesLocalDataStore?.getJokes().count == 2)
        XCTAssertEqual(jokesLocalDataStore?.getJokes().first?.joke, newJoke1.joke)
        XCTAssertEqual(jokesLocalDataStore?.getJokes()[1].joke, newJoke2.joke)
        
        /// Now Test its should be over
        XCTAssertTrue(jokeListRepository.isSaveJokeLimitOver)
      
    }
}
