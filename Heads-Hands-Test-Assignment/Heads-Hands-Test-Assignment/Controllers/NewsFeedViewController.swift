//
//  NewsFeedViewController.swift
//  Heads-Hands-Test-Assignment
//
//  Created by Kirill Pustovalov on 16.09.2021.
//

import UIKit

class NewsFeedViewController: UIViewController {
    private let newsFeedView = NewsFeedView()
    private let newsFeedSizeCalculator = NewsFeedSizeCalculator()
    private let newsFeedDataLoader = NewsFeedDataLoader()
    
    private var dataSource: FeedResponse?
    private var startFetchingFrom: String?
    
    override func loadView() {
        view = newsFeedView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationBar()
        setupDelegates()
        setupTargets()
        
        loadFirstNews()
        newsFeedView.startActivityIndicator()
        
        registerCells()
    }
    func setupDelegates() {
        newsFeedView.tableView.delegate = self
        newsFeedView.tableView.dataSource = self
        
        newsFeedDataLoader.delegate = self
    }
    func setupTargets() {
        newsFeedView.tableViewTopRefreshControl.addTarget(self, action: #selector(loadFirstNews), for: .valueChanged)
    }
    func registerCells() {
        newsFeedView.tableView.register(NewsFeedTableViewCell.self, forCellReuseIdentifier: "newsCell")
    }
    func setupNavigationBar() {
        title = "Feed"
        
        navigationController?.navigationBar.barStyle = .black
        navigationController?.navigationBar.isTranslucent = true
        
        navigationController?.navigationBar.barTintColor = UIColor(named: "AccentColor")
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
    }
}

extension NewsFeedViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        dataSource?.items.count ?? 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "newsCell", for: indexPath) as! NewsFeedTableViewCell
        guard let dataSource = self.dataSource else { return UITableViewCell() }
        
        let dataProvider = NewsFeedDataProvider(dataSource: dataSource, newsFeedSizeCalculator: newsFeedSizeCalculator, viewWidth: view.bounds.width)
        
        dataProvider.provideData(cell: cell, row: indexPath.row)
        return cell
    }
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        let model = dataSource?.items[indexPath.row]
        
        let estimatedHeight = newsFeedSizeCalculator.calculateEstimatedRowHeightDependingOnConstants(model: model, viewWidth: view.bounds.width)
        
        return estimatedHeight
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == (dataSource?.items.count ?? 1) - 1 {
            newsFeedDataLoader.loadOldNews(startingFrom: startFetchingFrom, oldDataSource: dataSource)
        }
    }
}

extension NewsFeedViewController: NewsFeedDataLoaderDelegate {
    @objc private func loadFirstNews() {
        newsFeedDataLoader.loadNews(startingFrom: nil) { (feedResponse) in
            DispatchQueue.main.async {
                guard let feedResponse = feedResponse else { return }
                let shouldInsertRows = self.dataSource == nil
                
                self.dataSource = feedResponse
                self.startFetchingFrom = feedResponse.nextFrom
                
                if shouldInsertRows {
                    let indexPaths = feedResponse.items.enumerated().map { IndexPath(row: $0.offset, section: 0) }
                    self.newsFeedView.tableView.insertRows(at: indexPaths, with: .automatic)
                } else {
                    self.newsFeedView.tableView.reloadSections([0], with: .automatic)
                }
                self.newsFeedView.stopActivityIndicator()
                self.newsFeedView.tableViewTopRefreshControl.perform(#selector(UIRefreshControl.endRefreshing), with: nil, afterDelay: 0.00) // more fluent than .endRefreshing()
            }
        }
    }
    
    func oldDataLoaded(newDataSource: FeedResponse?, newItems: [IndexPath], startFetchingFrom: String?) {
        self.dataSource = newDataSource
        self.startFetchingFrom = startFetchingFrom
        
        self.newsFeedView.tableView.insertRows(at: newItems, with: .top)
    }
}
