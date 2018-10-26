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
    
    // MARK: - Observable
    // Create
    // 가장 기본적인 생성 메서드
    let createTest = Observable<String>.create { observer -> Disposable in
        // next이벤트 발생(emit)
        observer.on(.next("next"))
        // completed이벤트 발생
        observer.on(.completed)
        return Disposables.create {
            // dispose될때 처리가 필요시
            print("dispose")
        }
    }
    
    // Generate
    // 초기값을 1을가지고 30보다 작을때까지 10씩 더해가며 이벤트(숫자값)를 발생시킨다.
    let generateTest = Observable.generate(initialState: 1, condition: { $0 < 30 }, iterate: {$0 + 10 })
    
    // Just
    // "just one"이라는 단일 이벤트를 발생시킨다.
    let justTest = Observable<String>.just("just one")
    
    // Of
    // 값들(배열의 값)을 순차적으로 이벤트로 발생시킨다.
    let ofTest = Observable<String>.of("My", "name", "is", "KakaoTocs")
    
    // From
    let arr = ["My", "name", "is", "IKEA"]
    
    // Deferred
    // subscribe가 발생할때 observable을 생성
    let deferTest = Observable<String>.deferred({ Observable.just("defer") })

    // Repeat
    // 반복 이벤트 발생
    let repeatTest = Observable<String>.repeatElement("repeat")
    
    // Range
    // 일정한 수만큼 반복해서 이벤트를 발생
    let rangeTest = Observable<Int>.range(start: 0, count: 3)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // MARK: - Observer
        // 발생된 이벤트를 읽어서 출력
        createTest.subscribe(onNext: { event in
            print(event)
        }).disposed(by: disposeBag)
        
        // 발생된 이벤트 즉 값을 읽어서 출력
        generateTest.subscribe(onNext: { event in
            print(event)
        }).disposed(by: disposeBag)
        
        // 발생된 이벤트를 출력(하나만 발생해가 끝나는 Observable이므로 한번출력후 끝)
        justTest.subscribe { event in
            print(event)
        }.disposed(by: disposeBag)
        
        // 순차적으로 발생되는 이벤트를 출력
        ofTest.subscribe { event in
            print(event)
        }.disposed(by: disposeBag)
        
        // 순차적으로 발생되는 이벤트를 출력
        // 배열을 받아 배열내 값을 순차적으로 이벤트로 발생시킨다.
        let fromTest = Observable<String>.from(arr)
        fromTest.subscribe { event in
            print(event)
        }.disposed(by: disposeBag)
        
        // subscribe시 발생된 "defer"을 전달받아 출력
        deferTest.subscribe { event in
            print(event)
        }.disposed(by: disposeBag)
        
        // 끝없이 계속 발생되는 이벤트 출력
//        repeatTest.subscribe { event in
//            print(event)
//        }.disposed(by: disposeBag)
        
        // 일정한 수 만큼 발생된 이벤트 출력
        rangeTest.subscribe { event in
            print(event)
        }.disposed(by: disposeBag)
        
    }


}

