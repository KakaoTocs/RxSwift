//
//  ViewController.swift
//  01_Basic
//
//  Created by DGSW_TEACHER on 2018. 4. 19..
//  Copyright © 2018년 KakaoTocs. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class ViewController: UIViewController, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var shownCities = [String]()
    let allCities = ["New York", "London", "Oslo", "Warsaw", "Berlin", "Praga"]
    let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        tableView.dataSource = self
        
        searchBar
            .rx.text
            .orEmpty // 옵셔널이 아니도록 만듬
            .debounce(0.5, scheduler: MainScheduler.instance) //0.5초 기다림
            .distinctUntilChanged() // 새로운 값이 이전의 값과 같은지 확인
            .filter { !$0.isEmpty } // 빈 쿼리문 필터링
            .subscribe(onNext: { [unowned self] query in // 새 값 구독
                self.shownCities = self.allCities.filter { $0.hasPrefix(query) } // 쿼리문에 해당하는 값 필터링
                self.tableView.reloadData() // 테이블 뷰 새로고침
            })
            .addDisposableTo(disposeBag)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shownCities.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cityPrototypeCell", for: indexPath)
        cell.textLabel?.text = shownCities[indexPath.row]
        
        return cell
    }
}

