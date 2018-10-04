//
//  CurrencyViewCell.swift
//  SmartKuk_MVVM_RXSwift_Example
//
//  Created by SmartKuk on 10/1/18.
//  Copyright © 2018 SmartCompany. All rights reserved.
//

import UIKit

final class CurrencyViewCell: UITableViewCell {
    
    @IBOutlet weak var currencyCode: UILabel!
    
    @IBOutlet weak var countryCode: UILabel!
    
    @IBOutlet weak var currencyValue: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}

extension CurrencyViewCell: CurrencyViewModelDelegate {
    
    func configure(_ datasource: CurrencyViewModelDataSource) {
        
        currencyCode.text = datasource.currencyCode

        countryCode.text = datasource.countryCode

        currencyValue.text = datasource.currencyValue
    }
}
