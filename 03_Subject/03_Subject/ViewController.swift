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
    
    // PublishSubject
    // subscribe된 시점 이후 발생하는 이벤트를 해당 observer에게 전달
    let publishTest = PublishSubject<String>()
    
    // BehaviorSubject
    // 초기 이벤트를 가진 subject로 subscribe시 가장 최근 이벤트(혹은 초기 이벤트)를 전달받아 이후 발생되는 이벤트들을 전달 받는다.
    let behaviorTest = BehaviorSubject<Person>(value: Person(name: "KakaoTocs"))
    
    // ReplaySubject
    // 지정된 버터수만큼 발생된 이벤트를 가지고 있다가 subscribe시 전달한다.(가장 최근 이벤트기준으로 지정된 개수의 이벤트를 저장하고 있는다.)
    let replayTest = ReplaySubject<Person>.create(bufferSize: 2)

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // completed 전까지 이벤트를 전달받아 출력한다.(completed시 정상적으로 종료된다.)
        publishTest.subscribe { event in
            print(event)
        }.disposed(by: disposeBag)
        publishTest.on(.next("I"))
        publishTest.on(.next("am"))
        publishTest.on(.next("KakaoTocs"))
        publishTest.on(.completed)
        publishTest.on(.next("ATOM"))
        
        // 초기 이벤트값인 "KakaoTocs"가 전달되고 completed발생전까지 이벤트를 출력한다.
        behaviorTest.subscribe { event in
            print(event)
        }.disposed(by: disposeBag)
        behaviorTest.on(.next(Person(name: "Joy")))
        behaviorTest.on(.next(Person(name: "May")))
        behaviorTest.on(.completed)
        behaviorTest.on(.next(Person(name: "Maya")))
        
        // 이벤트는 3번 발생했지만 버퍼크기가 2라 최근 2개 데이터만 출력
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
