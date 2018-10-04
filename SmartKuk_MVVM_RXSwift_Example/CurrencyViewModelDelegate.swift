//
//  CurrencyViewModelDelegate.swift
//  SmartKuk_MVVM_RXSwift_Example
//
//  Created by SmartKuk on 10/1/18.
//  Copyright © 2018 SmartCompany. All rights reserved.
//

import Foundation

/// CurrencyViewCell 화면을 그리는 대리자
protocol CurrencyViewModelDelegate {
    
    /// CurrencyViewModelDataSource 사용하여 화면을 설정
    ///
    /// - Parameter datasource: CurrencyViewModelDataSource 구현체
    func configure(_ datasource: CurrencyViewModelDataSource)
}
