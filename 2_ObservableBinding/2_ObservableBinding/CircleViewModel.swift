//
//  CircleViewModel.swift
//  2_ObservableBinding
//
//  Created by Jinu Kim on 2018. 9. 23..
//  Copyright © 2018년 Jinu Kim. All rights reserved.
//

import Foundation
import ChameleonFramework
import RxSwift
import RxCocoa

class CircleViewModel {
    var centerVariable = Variable<CGPoint?>(.zero)
    var backgroundColorObservable: Observable<UIColor>!
    
    init() {
        setup()
    }
    
    func setup() {
        backgroundColorObservable = centerVariable.asObservable()
            .map { center in
                guard let center = center else {
                    return UIColor.flatten(.black)()
                }
                
                let red: CGFloat = ((center.x + center.y).truncatingRemainder(dividingBy: 255.0)) / 255.0
                let green: CGFloat = 0.0
                let blue: CGFloat = 0.0
                
                return UIColor.flatten(UIColor(red: red, green: green, blue: blue, alpha: 1.0))()
            }
    }
}
