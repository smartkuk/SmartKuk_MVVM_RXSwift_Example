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

    @IBOutlet var tableView: UITableView!
    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    
    private let refresh = UIBarButtonItem(barButtonSystemItem: .refresh, target: nil, action: nil)
    
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
        
        tableView.register(UINib(nibName: identifier, bundle: Bundle.main), forCellReuseIdentifier: identifier)
        
        navigationItem.rightBarButtonItem = refresh
        
        navigationItem.title = "SmartKuk Sample"
        
        currencyDataSource = CurrencyListDataSource()
        
        setUpRx()
        
        currencyDataSource.reload.onNext(())
    }
}

extension CurrencyViewController {
    
    /// UI 컴포넌트들과 바인딩
    func setUpRx() {
        
        // UIBarButtonItem 과 Driver와 연결
        currencyDataSource.loading
            .drive(activityIndicator.rx.isAnimating)
            .disposed(by: disposableBag)
        
        // 버튼의 tap 이벤트에 옵저버를 바인딩
        refresh.rx.tap
            .debounce(0.5, scheduler: MainScheduler.asyncInstance)
            .bind(to: currencyDataSource.reload)
            .disposed(by: disposableBag)

        // 뷰모델의 변경이 발생하면 테이블뷰를 그림
        currencyDataSource.viewModels
            .observeOn(MainScheduler.instance)
            .bind(to: tableView.rx.items(cellIdentifier: identifier, cellType: cellType))
            { (_, data, cell) in cell.configure(data) }
            .disposed(by: disposableBag)
    }
}
