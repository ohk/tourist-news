//
//  HomeViewController.swift
//  touristNews
//
//  Created by Ömer Hamid Kamışlı on 11/27/22.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

class HomeViewController: UIViewController {
    let vm = HomeViewModel()
    
    let homeTableView: UITableView = {
        let table = UITableView()
        table.register(NewsTableViewCell.self, forCellReuseIdentifier: "newsTableViewCell")
        table.register(UserTableViewCell.self, forCellReuseIdentifier: "userTableViewCell")
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()
    
    let segmentedControl: UISegmentedControl = {
        var sC = UISegmentedControl (items: ["News","Users"])
        sC.selectedSegmentIndex = 0
        sC.translatesAutoresizingMaskIntoConstraints=false
        return sC
    }()
    
    @objc func segmentedControlValueChanged(_ sender: UISegmentedControl) {
        homeTableView.setContentOffset(.zero, animated: true)
        vm.handlePageType(selectedIndex: sender.selectedSegmentIndex)
    }
    
    override func viewDidLoad() {
        homeTableView.delegate = self
        homeTableView.dataSource = self
        view.backgroundColor = .white
        navigationItem.title = "News"
        view.addSubview(segmentedControl)
        view.addSubview(homeTableView)
        segmentedControl.addTarget(self, action: #selector(segmentedControlValueChanged), for: .valueChanged)
        segmentedControl.addTarget(self, action: #selector(segmentedControlValueChanged), for: .touchUpInside)
        subscribeData()
    }
    
    func subscribeData() {
        self.vm.newsData.observe(on: MainScheduler.instance).subscribe(onNext: { [weak self] data in
            if data.count > 0 {
                self?.homeTableView.reloadData()
            }
        }).disposed(by: vm.disposeBag)
        
        self.vm.usersData.observe(on: MainScheduler.instance).subscribe(onNext: { [weak self] data in
            if data.count > 0 {
                self?.homeTableView.reloadData()
            }
        }).disposed(by: vm.disposeBag)
        
        self.vm.pageType.observe(on: MainScheduler.instance).subscribe(onNext: { [weak self] data in
            self?.homeTableView.reloadData()
        }).disposed(by: vm.disposeBag)
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
        return vm.getDataCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let data = vm.getIndexedDataCount(row: indexPath.row) {
            if let hd = data as? NewsModelData {
                let cell = homeTableView.dequeueReusableCell(withIdentifier: "newsTableViewCell", for: indexPath) as! NewsTableViewCell
                cell.setupCell(data: hd)
                return cell
            }
            
            if let hd = data as? UsersModelData {
                let cell = homeTableView.dequeueReusableCell(withIdentifier: "userTableViewCell", for: indexPath) as! UserTableViewCell
                cell.setupCell(data: hd)
                return cell
            }
        }
        return UITableViewCell()
    }
    
    private func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        vm.handlePageCount(row: indexPath.row)
    }
    
}
