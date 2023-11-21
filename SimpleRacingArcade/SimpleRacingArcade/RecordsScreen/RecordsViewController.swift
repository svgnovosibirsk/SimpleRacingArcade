//
//  RecordsViewController.swift
//  SimpleRacingArcade
//
//  Created by Sergey on 21.11.2023.
//

import UIKit

final class RecordsViewController: UIViewController {
    //MARK: - Constants
    private enum localConstants {
        static let cellId = "cellId"
    }

    //MARK: - Properties
    private let tableView = UITableView()
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = Constants.recordsScreenTitle
        setupTableView()
    }
    
    //MARK: - Flow
    //MARK: - TableView
    private func setupTableView() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        tableView.frame = view.bounds
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: localConstants.cellId)
        tableView.backgroundColor = .systemGreen
        tableView.delegate = self
        tableView.dataSource = self
    }
}

//MARK: - UITableViewDelegate, UITableViewDataSource
extension RecordsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Player.sampleData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: localConstants.cellId, for: indexPath)
        let player = Player.sampleData.sorted{$0.score > $1.score}[indexPath.row]
        cell.backgroundColor = .systemGreen
        cell.textLabel?.text = "\(player.name): \(player.score)"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
