//
//  ViewController.swift
//  02_ObservableCreate
//
//  Created by Jinu Kim on 29/09/2018.
//  Copyright © 2018 Jinu Kim. All rights reserved.
//

import UIKit
import RxSwift

class ViewController: UIViewController {
    
    let disposeBag = DisposeBag()
    
    let createTest = Observable<String>.create { observer -> Disposable in
        observer.on(.next("next"))
        observer.on(.completed)
        return Disposables.create {
            print("dispose")
        }
    }
    
    let generateTest = Observable.generate(initialState: 1, condition: { $0 < 30 }, iterate: {$0 + 10 })
    
    let justTest = Observable<String>.just("just one")
    
    let ofTest = Observable<String>.of("My", "name", "is", "KakaoTocs")
    
    let arr = ["My", "name", "is", "IKEA"]
    
    let deferTest = Observable<String>.deferred({ Observable.just("defer") })

    let repeatTest = Observable<String>.repeatElement("repeat")
    let rangeTest = Observable<Int>.range(start: 0, count: 3)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        createTest.subscribe(onNext: { event in
            print(event)
        }).disposed(by: disposeBag)
        
        generateTest.subscribe(onNext: { event in
            print(event)
        }).disposed(by: disposeBag)
        
        justTest.subscribe { event in
            print(event)
        }.disposed(by: disposeBag)
        
        ofTest.subscribe { event in
            print(event)
        }.disposed(by: disposeBag)
        
        let fromTest = Observable<String>.from(arr)
        fromTest.subscribe { event in
            print(event)
        }.disposed(by: disposeBag)
        
        deferTest.subscribe { event in
            print(event)
        }.disposed(by: disposeBag)
        
//        repeatTest.subscribe { event in
//            print(event)
//        }.disposed(by: disposeBag)
        
        rangeTest.subscribe { event in
            print(event)
        }.disposed(by: disposeBag)
        
    }


}

