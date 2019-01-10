//
//  Query.swift
//  MVVMReactiveExample
//
//  Created by Tom Pearson on 23/12/2018.
//  Copyright © 2018 Tom Pearson. All rights reserved.
//

import Foundation

enum QueryItem {
    case limit(Int)
    case idFilter(Int)
    case from(startIndex: Int)
    case to(endIndex: Int) //non inclusive
    
    var key: String {
        switch self {
        case .limit:
            return "_limit"
        case .idFilter:
            return "id"
        case .from:
            return "_start"
        case .to:
            return "_end"
        }
    }
    
    var value: String {
        switch self {
        case .limit(let limit):
            return String(describing: limit)
        case .idFilter(let id):
            return String(describing: id)
        case .from(let startIndex):
            return String(describing: startIndex)
        case .to(let endIndex):
            return String(describing: endIndex)
        }
    }
}
