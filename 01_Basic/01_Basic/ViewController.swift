//
//  ViewController.swift
//  01_Basic
//
//  Created by Jinu Kim on 26/09/2018.
//  Copyright © 2018 Jinu Kim. All rights reserved.
//

import UIKit
import RxSwift

class ViewController: UIViewController {
    let zootopia = Zootopia()

    override func viewDidLoad() {
        super.viewDidLoad()
    }

}

// Zootopia는 토끼가 틔어나오고, 이를 관찰하는 것을 하나의 덩어리로 본다?
class Zootopia {
    struct Rabbit {
        let comment = "토끼 등장!"
    }
    
    let disposeBag = DisposeBag()
    // 3초마다 Int이벤트 발생
    let timer = Observable<Int>.interval(3.0, scheduler: MainScheduler.instance)
    
    init() {
        // 발생된 이벤트 값을 무시하고 발생 시점마다 토끼 객체 생성(타이머 발생 값을 객체로 바꾸는 작업)
        timer.map{ _ in
            Rabbit()
        // 발생된 토끼인스턴스를 읽어 comment출력
        }.subscribe({rabbit in
            print(rabbit.element?.comment)
        // Obsercer종료
        }).disposed(by: disposeBag)
    }
}
