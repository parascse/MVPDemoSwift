//
//  JokesListViewController.swift
//  UnlimitTestProject
//
//  Created by Paras Gupta on 13/07/23.
//

import Foundation
import UIKit

class JokesListViewController: UIViewController {
    private var jokesListPresenter: JokesListPresenter!
    var tblView = UITableView()
    //MARK: Public properties
    fileprivate let CellIdentifier = "jokesListCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addTableView()
        jokesListPresenter = JokesListPresenter()
        jokesListPresenter.getJokesList()
        jokesListPresenter.reloadTableView = {
            DispatchQueue.main.async { [weak self] in
                self?.tblView.reloadData()
            }
        }
    }
    
    func addTableView(){
        view.addSubview(tblView)
        tblView.translatesAutoresizingMaskIntoConstraints = false
        tblView.topAnchor.constraint(equalTo:view.topAnchor).isActive = true
        tblView.leftAnchor.constraint(equalTo:view.leftAnchor).isActive = true
        tblView.rightAnchor.constraint(equalTo:view.rightAnchor).isActive = true
        tblView.bottomAnchor.constraint(equalTo:view.bottomAnchor).isActive = true
        tblView.delegate = self
        tblView.dataSource = self
        tblView.register(UITableViewCell.self, forCellReuseIdentifier: CellIdentifier)
    }
}
extension JokesListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return jokesListPresenter.numberOfRows()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier, for: indexPath)
        cell.textLabel?.numberOfLines = 0
        cell.textLabel?.text = jokesListPresenter.getCellData(for: indexPath).joke
        return cell
    }
}
