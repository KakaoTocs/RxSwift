//
//  Repository.swift
//  3_Networking
//
//  Created by Jinu Kim on 2018. 9. 24..
//  Copyright © 2018년 Jinu Kim. All rights reserved.
//

import Mapper

struct Repository: Mappable {
    let identifier: Int
    let language: String
    let name: String
    let fullName: String
    
    init(map: Mapper) throws {
        try identifier = map.from("id")
        try language = map.from("language")
        try name = map.from("name")
        try fullName = map.from("full_name")
    }
}
