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

/// CurrencyViewController 관리하는 데이터소스
final class CurrencyListDataSource {
    
    /// 쓰레기통
    let disposableBag = DisposeBag()
    
    /// 환율 정보를 제공하는 서비스
    let currencyService: CurrencyServiceProtocol
    
    /// 관찰 가능한 뷰모델
    let viewModels: Observable<[CurrencyViewModel]>
    
    /// 새로고침 버튼 이벤트와 bind 되는 관찰자
    let reload: AnyObserver<Void>
    
    /// 메인 스레드 사용하는 관찰 가능한 Driver
    let loading: Driver<Bool>
    
    init(service: CurrencyServiceProtocol = CurrencyService()) {
        
        currencyService = service
        
        let _loading = ActivityIndicator()
        
        loading = _loading.asDriver()
        
        let _reload = PublishSubject<Void>()
        
        reload = _reload.asObserver()
        
        // Element가 CurrencyViewModel인 Observable 요소로 전환
        viewModels = _reload.asObservable()
            .flatMapLatest { _ in
                return service.fetch(base: "KRW", "2018-09-26", ["USD","JPY"])
                    .trackActivity(_loading)
                    .asDriver(onErrorJustReturn: [CurrencyModel]())
            }
            .map({ $0.map({ CurrencyViewModel($0) }) })
    }
}
