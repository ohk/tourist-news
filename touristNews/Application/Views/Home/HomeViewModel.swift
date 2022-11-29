//
//  HomeViewModel.swift
//  touristNews
//
//  Created by Ömer Hamid Kamışlı on 11/27/22.
//

import Foundation
import RxSwift
import RxCocoa

enum SelectionType: Int {
    case news
    case users
}

class HomeViewModel {
    let disposeBag = DisposeBag()
    let pageSize = BehaviorRelay<Int>(value: 10)
    let pageNewsCount = BehaviorRelay<Int>(value: 1)
    let pageUsersCount = BehaviorRelay<Int>(value: 1)
    let pageType = BehaviorRelay<SelectionType>(value: .news)
    let newsData = BehaviorRelay<[NewsModelData]>(value: [])
    let usersData = BehaviorRelay<[UsersModelData]>(value: [])
    private var requestWaitStatus = false
    private var subscribeDataStatus = false
    init() {
        getData()
        
    }
    
    func getDataCount() -> Int {
        let selectionType = pageType.value
        var data = Int.max
        if selectionType == .news {
            data = newsData.value.count
        } else {
            data = usersData.value.count
        }
        return data
    }
    
    func subscribeData() {
        subscribeDataStatus = true
        pageType.observe(on: MainScheduler.instance).skip(1).subscribe(onNext: { [weak self] data in
            if self?.requestWaitStatus == false && self?.getDataCount() == 0 {
                self?.getData()
            }
        }).disposed(by: disposeBag)
        
        pageNewsCount.observe(on: MainScheduler.instance).skip(1).subscribe(onNext: { [weak self] data in
            if self?.requestWaitStatus == false {
                self?.getData()
            }
        }).disposed(by: disposeBag)
        
        pageUsersCount.observe(on: MainScheduler.instance).skip(1).subscribe(onNext: { [weak self] data in
            if self?.requestWaitStatus == false {
                self?.getData()
            }
        }).disposed(by: disposeBag)
        
    }
    
    func getIndexedDataCount(row: Int) -> Any? {
        let selectionType = pageType.value
        if selectionType == .news {
            if row > newsData.value.count {
                return nil
            } else {
                return  newsData.value[row]
            }
        } else {
            if row > usersData.value.count {
                return nil
            } else {
                return  usersData.value[row]
            }
        }
    }
    
    func handlePageCount(row: Int) {
        if requestWaitStatus == false && getDataCount() - row < pageSize.value  {
            let selectionType = pageType.value
            if selectionType == .news {
                pageNewsCount.accept(pageNewsCount.value + 1)
            } else {
                pageUsersCount.accept(pageUsersCount.value + 1)
            }
        }
    }
    
    func handlePageType(selectedIndex: Int) {
        requestWaitStatus = false
        pageType.accept(SelectionType(rawValue: selectedIndex) ?? .news)
    }
    
    func getData() {
        if requestWaitStatus == false {
            requestWaitStatus = true
            let selectionType = pageType.value
            if selectionType == .news {
                RequestHandler.shared.getRequest(url: "http://restapi.adequateshop.com/api/Feed/GetNewsFeed?page=\(pageNewsCount.value)", model: NewsModel.self) { [weak self] data in
                    guard let self = self else { return }
                    let nData = self.newsData.value
                    let nValue = nData + (data?.data ?? [])
                    self.newsData.accept(nValue)
                    self.requestWaitStatus = false
                    if self.subscribeDataStatus == false {
                        self.subscribeData()
                    }
                }
            } else {
                RequestHandler.shared.getRequest(url: "http://restapi.adequateshop.com/api/Tourist?page=\(pageUsersCount.value)", model: UsersModel.self) { [weak self] data in
                    guard let self = self else { return }
                    let nData = self.usersData.value
                    let nValue = nData + (data?.data ?? [])
                    self.usersData.accept(nValue)
                    self.requestWaitStatus = false
                    if self.subscribeDataStatus == false {
                        self.subscribeData()
                    }
                }
            }
        }
    }
}
