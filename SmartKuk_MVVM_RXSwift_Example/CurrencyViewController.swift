//
//  CurrencyViewController.swift
//  SmartKuk_MVVM_RXSwift_Example
//
//  Created by SmartKuk on 10/1/18.
//  Copyright © 2018 SmartCompany. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

final class CurrencyViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var loadingView: UIActivityIndicatorView!
    
    /// 쓰레기통
    let disposableBag = DisposeBag()
    
    // 식별자가 길어서 변수로 빼놓음
    let identifier: String = "CurrencyViewCell"
    
    /// 재사용 Cell 타입
    let cellType: CurrencyViewCell.Type = CurrencyViewCell.self
    
    /// 뷰컨트롤러 관리용 데이터소스
    var currencyDataSource: CurrencyListDataSource!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        currencyDataSource = CurrencyListDataSource()
        
        setUpUI()
        
        currencyDataSource.fetch()
        
        setUpRx()
    }
}

extension CurrencyViewController {
    
    func setUpUI() {
        
        tableView.register(UINib(nibName: identifier, bundle: Bundle.main), forCellReuseIdentifier: identifier)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: nil, action: nil)
    }
    
    func setUpRx() {
        
        navigationItem.rightBarButtonItem?.rx.tap
            .debounce(0.0, scheduler: MainScheduler.instance)
            .subscribe(){ event in
                self.currencyDataSource.fetch()
            }
            .disposed(by: disposableBag)
        
        currencyDataSource.title
            .bind(to: navigationItem.rx.title)
            .disposed(by: disposableBag)
        
        currencyDataSource.isFetching
            .bind(to: self.loadingView.rx.isAnimating)
            .disposed(by: disposableBag)
        
        currencyDataSource.models?
            .bind(to: tableView.rx.items(cellIdentifier: identifier, cellType: cellType))
            { (_, data, cell) in cell.configure(CurrencyViewModel(data)) }
            .disposed(by: disposableBag)
    }
}
