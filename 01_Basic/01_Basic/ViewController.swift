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

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    let zootopia = Zootopia()
}

class Zootopia {
    struct Rabbit {
        let comment = "토끼 등장!"
    }
    
    let disposeBag = DisposeBag()
    let timer = Observable<Int>.interval(3.0, scheduler: MainScheduler.instance)
    
    init() {
        timer.map{ _ in
            Rabbit()
        }.subscribe({rabbit in
            print(rabbit.element?.comment)
        }).disposed(by: disposeBag)
    }
}
