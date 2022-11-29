//
//  HomeViewController.swift
//  touristNews
//
//  Created by Ömer Hamid Kamışlı on 11/27/22.
//

import Foundation
import UIKit

class HomeViewController: UIViewController {
    let homeTableView: UITableView = {
        let table = UITableView()
        table.register(UITableViewCell.self, forCellReuseIdentifier: "homeTableViewCell")
        table.translatesAutoresizingMaskIntoConstraints = false

        return table
    }()
    
    let segmentedControl: UISegmentedControl = {
        var sC = UISegmentedControl (items: ["News","Users"])
        sC.selectedSegmentIndex = 0
        sC.translatesAutoresizingMaskIntoConstraints=false
        return sC
    }()
    
    override func viewDidLoad() {
        homeTableView.delegate = self
        homeTableView.dataSource = self
        view.backgroundColor = .white
        navigationItem.title = "News"
        view.addSubview(segmentedControl)
        view.addSubview(homeTableView)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        segmentedControl.rightAnchor.constraint(equalTo: view.safeRightAnchor ).isActive = true
        segmentedControl.leftAnchor.constraint(equalTo: view.safeLeftAnchor).isActive = true
        segmentedControl.topAnchor.constraint(equalTo: view.safeTopAnchor).isActive = true
        homeTableView.topAnchor.constraint(equalTo: segmentedControl.bottomAnchor, constant: 15).isActive = true
        homeTableView.rightAnchor.constraint(equalTo: view.safeRightAnchor ).isActive = true
        homeTableView.leftAnchor.constraint(equalTo: view.safeLeftAnchor).isActive = true
        homeTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 150
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = homeTableView.dequeueReusableCell(withIdentifier: "homeTableViewCell", for: indexPath)
        cell.textLabel?.text = "Hello World"
        return cell
    }
    
    
}
