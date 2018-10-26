//
//  ViewController.swift
//  04_ObservableSynthesis
//
//  Created by Jinu Kim on 02/10/2018.
//  Copyright © 2018 Jinu Kim. All rights reserved.
//

import UIKit
import RxSwift

class ViewController: UIViewController {
    
    let disposeBag = DisposeBag()
    
    let boys = Observable.from(["Tom", "Adam", "Yoshep"])
    let girls = Observable.from(["Annie", "Miranda", "Jany"])
    
    let employee = Observable<Int>.interval(2, scheduler: MainScheduler.instance).take(6).map {
        ["Tom", "Jhon", "Jack", "", "", "Park"][$0] }.filter { !$0.isEmpty }
    let payMoney = Observable<Int>.interval(1, scheduler: MainScheduler.instance).take(12).map { ("\($0) o'clock", "$10") }
    
    let redTeam = Observable<Int>.interval(1, scheduler: MainScheduler.instance).map { "red: \($0)" }
    let blueTeam = Observable<Int>.interval(2, scheduler: MainScheduler.instance).map { "blue: \($0)" }
    let startTime = Date().timeIntervalSince1970

    override func viewDidLoad() {
        super.viewDidLoad()
        
        Observable.combineLatest(boys, girls, resultSelector: { (boy: String, girl: String) in
            return (boy, girl)
            }).subscribe { event in
                print(event)
        }.disposed(by: disposeBag)
        
        payMoney.withLatestFrom(employee, resultSelector: { (pay: (String, String), name: String) in
            return (pay.0, pay.1, name)
            }).subscribe(onNext: { event in
                print(event)
            }).disposed(by: disposeBag)
        
        Observable.of(redTeam, blueTeam).merge().subscribe { event in
            print("\(event): \(Int(Date().timeIntervalSince1970 - startTime)")
        }.disposed(by: disposeBag)
    }


}

