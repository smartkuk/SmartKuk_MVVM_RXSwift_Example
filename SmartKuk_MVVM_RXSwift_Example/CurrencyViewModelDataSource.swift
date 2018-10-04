//
//  CurrencyViewModelDataSource.swift
//  SmartKuk_MVVM_RXSwift_Example
//
//  Created by SmartKuk on 10/1/18.
//  Copyright © 2018 SmartCompany. All rights reserved.
//

import Foundation

/// CurrencyViewCell 화면을 설정할때 사용하는 데이터소스
protocol CurrencyViewModelDataSource {
    var currencyCode: String? { get }
    var countryCode: String? { get }
    var currencyValue: String? { get }
}
