//
//  CurrencyServiceProtocol.swift
//  SmartKuk_MVVM_RXSwift_Example
//
//  Created by SmartKuk on 10/1/18.
//  Copyright © 2018 SmartCompany. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

protocol CurrencyServiceProtocol {
    
    /// 환율 조회
    ///
    /// - Parameters:
    ///   - base: 기준 환율코드
    ///   - date: 기준 날짜
    ///   - symbols: 기준 환율코드를 기초로 조회할 환율 코드 배열
    /// - Returns: 관찰 할 수 있는 환율 모델 배열
    func fetch(base: String?, _ date: String?, _ symbols: [String]?) -> Observable<[CurrencyModel]>
}
