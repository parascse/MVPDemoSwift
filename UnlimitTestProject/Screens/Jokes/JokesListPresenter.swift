//
//  JokesListPresenter.swift
//  UnlimitTestProject
//
//  Created by Paras Gupta on 13/07/23.
//

import Foundation

final class JokesListPresenter {
    
    var reloadTableView: (() -> ()) = {}
    private var jokeListRepository: JokeListRepository!
    private var jokes: [Joke] = [] {
        didSet {
            // inform view to refresh data
            reloadTableView()
        }
    }
    
    init(_ jokeListRepository: JokeListRepository = JokeListRepository()){
        self.jokeListRepository = jokeListRepository
//        getJokesList()
        timerToFetchNewJokes()
    }
    
    //MARK: Public methods
    //Fetch currency list from api
    @objc func getJokesList(){
        jokeListRepository.getJokes { [weak self] jokes in
            self?.jokes = jokes
        }
    }
    /// Method return the number of cells for select currency table view
    func numberOfRows() -> Int {
        return self.jokes.count
    }
    ///  Data source provider for table cell data
    /// - Parameter indexPath: index path of cell
    /// - Returns: SelectCurrencyCellViewModel type data
    func getCellData(for indexPath: IndexPath) -> Joke {
        return self.jokes[indexPath.row]
    }
    func timerToFetchNewJokes(){
        let timer = Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(getJokesList), userInfo: nil, repeats: true)
        RunLoop.current.add(timer, forMode: .common)
    }
}
