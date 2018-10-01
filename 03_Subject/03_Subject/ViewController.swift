//
//  ViewController.swift
//  03_Subject
//
//  Created by Jinu Kim on 01/10/2018.
//  Copyright © 2018 Jinu Kim. All rights reserved.
//

import UIKit
import RxSwift

class ViewController: UIViewController {
    let disposeBag = DisposeBag()
    
    let publishTest = PublishSubject<String>()
    
    let behaviorTest = BehaviorSubject<Person>(value: Person(name: "KakaoTocs"))
    
    let replayTest = ReplaySubject<Person>.create(bufferSize: 2)

    override func viewDidLoad() {
        super.viewDidLoad()
        
        publishTest.subscribe { event in
            print(event)
        }.disposed(by: disposeBag)
        publishTest.on(.next("I"))
        publishTest.on(.next("am"))
        publishTest.on(.next("KakaoTocs"))
        publishTest.on(.completed)
        publishTest.on(.next("ATOM"))
        
        behaviorTest.subscribe { event in
            print(event)
        }.disposed(by: disposeBag)
        behaviorTest.on(.next(Person(name: "Joy")))
        behaviorTest.on(.next(Person(name: "May")))
        behaviorTest.on(.completed)
        behaviorTest.on(.next(Person(name: "Maya")))
        
        replayTest.subscribe { event in
            print("subscribe 1: \(event)")
        }.disposed(by: disposeBag)
        replayTest.on(.next(Person(name: "Rothy")))
        replayTest.on(.next(Person(name: "Jhon")))
        replayTest.on(.next(Person(name: "Shino")))
        replayTest.subscribe { event in
            print("subscribe 2: \(event)")
        }.disposed(by: disposeBag)
    }


}

struct Person {
    let name: String
}
