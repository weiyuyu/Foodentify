//
//  SearchQuery.swift
//  Foodentify
//
//  Created by Wayne Yu on 12/6/18.
//  Copyright © 2018 Wayne Yu. All rights reserved.
//

import Foundation

struct SearchQuery: Codable {
    let list: SearchList
}

struct SearchList: Codable {
    let q, sr, ds: String
    let start, end, total: Int
    let group, sort: String
    let item: [SearchItem]
}

struct SearchItem: Codable {
    let offset: Int
    let group, name, ndbno, ds: String
    let manu: String
}

