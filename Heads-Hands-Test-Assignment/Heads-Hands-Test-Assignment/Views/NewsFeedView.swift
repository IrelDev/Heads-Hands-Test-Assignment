//
//  NewsFeedView.swift
//  Heads-Hands-Test-Assignment
//
//  Created by Kirill Pustovalov on 16.09.2021.
//

import UIKit

class NewsFeedView: UIView {
    let tableViewTopRefreshControl: UIRefreshControl = {
        let tableViewTopRefreshControl = UIRefreshControl()
        tableViewTopRefreshControl.tintColor = UIColor(named: "AccentColor")
        
        return tableViewTopRefreshControl
    }()
    let activityIndicatorView: UIActivityIndicatorView = {
        let activityIndicatorView = UIActivityIndicatorView()
        
        activityIndicatorView.color = UIColor(named: "AccentColor")
        activityIndicatorView.alpha = 0
        activityIndicatorView.isHidden = true
        
        activityIndicatorView.style = .large
        
        return activityIndicatorView
    }()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        tableView.tableHeaderView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 0.001))

        return tableView
    }()
    
    init() {
        super.init(frame: .zero)
        
        backgroundColor = .systemBackground
        setupViews()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func startActivityIndicator() {
        activityIndicatorView.isHidden = false
        
        activityIndicatorView.startAnimating()
        activityIndicatorView.alpha = 1
    }
    func stopActivityIndicator() {
        UIView.animate(withDuration: 0.3) { [self] in
            activityIndicatorView.stopAnimating()
            activityIndicatorView.alpha = 0
        } completion: { _ in
            self.activityIndicatorView.isHidden = true
        }
        
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        
        activityIndicatorView.center = tableView.center
    }
}

extension NewsFeedView {
    func setupViews() {
        addSubview(tableView)
        tableView.refreshControl = tableViewTopRefreshControl
        
        addSubview(activityIndicatorView)
    }
}
