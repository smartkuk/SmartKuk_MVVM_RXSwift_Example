//
//  CurrencyService.swift
//  SmartKuk_MVVM_RXSwift_Example
//
//  Created by SmartKuk on 10/1/18.
//  Copyright © 2018 SmartCompany. All rights reserved.
//

import Foundation
import Alamofire
import RxSwift

/// CurrencyServiceProtocol 프로토콜 구현체
final class CurrencyService: CurrencyServiceProtocol {
    
    func fetch(base: String?, _ date: String?, _ symbols: [String]?) -> Observable<[CurrencyModel]> {
        
        return Observable.create({ (observer) -> Disposable in
            
            // thank you https://api.exchangeratesapi.io
            let baseUrl = "https://api.exchangeratesapi.io"
            
            let dateParameter: String = (date == nil) ? "latest" : "\(date!)"
            
            let baseParameter: String = "base=\(base ?? Locale.current.currencyCode ?? "KRW")"
            
            var requestUrl = baseUrl + "/" + dateParameter + "?" + baseParameter
            
            if let codes = symbols {
                
                requestUrl += "&symbols=\(codes.reduce("", { $0.isEmpty || $0 == "" ? $1 : "\($0),\($1)" }))"
            }
            
            let request = Alamofire.request(requestUrl).responseJSON { (response) in
                
                var results: [CurrencyModel] = [CurrencyModel]()
                
                if let json = response.result.value as? [String: Any] {
                    
                    if let currencyList = json["rates"] as? [String: Any] {
                        
                        currencyList.forEach({
                            
                            let key = $0
                            
                            let value = "\($1)"
                            
                            results.append(CurrencyModel(currencyCode: key, countryCode: key, currencyValue: value))
                        })
                    }
                }
                
                observer.onNext(results)
                observer.onCompleted()
            }
            
            return Disposables.create {
                request.cancel()
            }
        })
    }
}
