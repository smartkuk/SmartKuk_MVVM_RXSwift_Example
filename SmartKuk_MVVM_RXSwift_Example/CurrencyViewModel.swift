//
//  CurrencyViewModel.swift
//  SmartKuk_MVVM_RXSwift_Example
//
//  Created by SmartKuk on 10/1/18.
//  Copyright © 2018 SmartCompany. All rights reserved.
//

import Foundation

/// CurrencyViewModelDataSource 프로토콜을 구현한 클래스
final class CurrencyViewModel: CurrencyViewModelDataSource {
    
    var currencyCode: String? {
        return model.currencyCode
    }
    
    var countryCode: String? {
        return model.countryCode
    }
    
    var currencyValue: String? {
        return model.currencyValue
    }
    
    var model: CurrencyModel
    
    init(_ m: CurrencyModel) {
        model = m
    }
}
