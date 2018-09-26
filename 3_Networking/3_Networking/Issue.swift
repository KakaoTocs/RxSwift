//
//  Issue.swift
//  3_Networking
//
//  Created by Jinu Kim on 2018. 9. 24..
//  Copyright © 2018년 Jinu Kim. All rights reserved.
//

import Mapper

struct Issue: Mappable {
    let identifier: Int
    let number: Int
    let title: String
    let body: String
    
    init(map: Mapper) throws {
        try identifier = map.from("id")
        try number = map.from("number")
        try title = map.from("title")
        try body = map.from("body")
    }
}
