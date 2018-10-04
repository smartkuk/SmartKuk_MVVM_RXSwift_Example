//
//  Currency.swift
//  SmartKuk_MVVM_RXSwift_Example
//
//  Created by SmartKuk on 10/1/18.
//  Copyright © 2018 SmartCompany. All rights reserved.
//

import Foundation

/// 환율 모델
struct CurrencyModel {
    
    var currencyCode: String
    
    var countryCode: String
    
    var currencyValue: String
    
    init(currencyCode: String, countryCode: String, currencyValue: String) {
        
        self.currencyCode = currencyCode
        
        self.countryCode = countryCode
        
        self.currencyValue = currencyValue
    }
}
