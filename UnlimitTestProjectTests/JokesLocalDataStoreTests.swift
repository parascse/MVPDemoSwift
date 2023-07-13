//
//  JokesLocalDataStoreTests.swift
//  UnlimitTestProjectTests
//
//  Created by Paras Gupta on 14/07/23.
//

import XCTest
@testable import UnlimitTestProject

final class JokesLocalDataStoreTests: XCTestCase {
    
    private var jokesLocalDataStore: JokesLocalDataStoreProtocol?
    
    override func setUp() {
        if let mockUserDefaults = UserDefaults(suiteName: #file) {
            mockUserDefaults.removePersistentDomain(forName: #file)
            jokesLocalDataStore = JokesLocalDataStore(mockUserDefaults)
        }
    }
    
    override func tearDown() {
        jokesLocalDataStore = nil
    }
    
    func testNewJokeDataIsStoredAndRetrived() throws {
        /// Check initially no data in local data store
        XCTAssertTrue(jokesLocalDataStore?.getJokes().count == 0)
        
        /// Save new Joke
        let newJoke: Joke = Joke(joke: "I am new Joke")
        jokesLocalDataStore?.saveJoke(newJoke)
        
        /// Test new joke is retrived and saved
        XCTAssertTrue(jokesLocalDataStore?.getJokes().count == 1)
        XCTAssertEqual(jokesLocalDataStore?.getJokes().first?.joke, newJoke.joke)
    }
    
    func testRemoveFirst() {
        /// Initally save 2  new Joke
        let newJoke1: Joke = Joke(joke: "I am first Joke")
        let newJoke2: Joke = Joke(joke: "I am second Joke")
        jokesLocalDataStore?.saveJoke(newJoke1)
        jokesLocalDataStore?.saveJoke(newJoke2)
        
        /// Verify both are saved
        XCTAssertTrue(jokesLocalDataStore?.getJokes().count == 2)
        XCTAssertEqual(jokesLocalDataStore?.getJokes().first?.joke, newJoke1.joke)
        XCTAssertEqual(jokesLocalDataStore?.getJokes()[1].joke, newJoke2.joke)
        
        /// Now remove first
        jokesLocalDataStore?.removeFirst()
        
        /// Verify remove
        XCTAssertTrue(jokesLocalDataStore?.getJokes().count == 1)
        XCTAssertEqual(jokesLocalDataStore?.getJokes().first?.joke, newJoke2.joke)
        
    }
}
