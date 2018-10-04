//
//  CurrencyDataSource.swift
//  SmartKuk_MVVM_RXSwift_Example
//
//  Created by SmartKuk on 10/1/18.
//  Copyright © 2018 SmartCompany. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

/// ViewController 관리하는 데이터소스
final class CurrencyListDataSource {
    
    let disposableBag = DisposeBag()
    
    var currencyService: CurrencyServiceProtocol
    
    var models: Observable<[CurrencyModel]>?
    
    let latestDateObserver: AnyObserver<Date>
    
    let title: Observable<String>
    
    let fetchObserver: AnyObserver<Bool>
    
    let isFetching: Observable<Bool>
    
    init(currencyService: CurrencyServiceProtocol = CurrencyService()) {
        
        self.currencyService = currencyService
        
        let _latestDate = BehaviorSubject<Date>(value: Date())
        
        self.latestDateObserver = _latestDate.asObserver()
        
        self.title = _latestDate.asObservable().map { "\($0)" }
        
        let _isFetching = BehaviorSubject<Bool>(value: false)
        
        self.fetchObserver = _isFetching.asObserver()
        
        self.isFetching = _isFetching.asObservable()
    }
    
    func fetch() {
        
        fetchObserver.on(Event.next(true))
        
        latestDateObserver.on(Event.next(Date()))
        
        models = currencyService.fetch(base: "KRW", "2018-09-26", ["USD","JPY"])
        
        fetchObserver.on(Event.next(false))
    }
}
