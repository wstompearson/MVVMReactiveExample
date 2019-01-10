//
//  RealmStoreable.swift
//  MVVMReactiveExample
//
//  Created by Tom Pearson on 30/12/2018.
//  Copyright © 2018 Tom Pearson. All rights reserved.
//

import RealmSwift

protocol RealmStoreable where Self: Object {
    associatedtype AssociatedModel: FetchableModel
    
    init(model: AssociatedModel)
}

extension RealmStoreable {
    static func transform(_ results: Results<Self>) -> [AssociatedModel] {
        return results.map { AssociatedModel.init(object: $0 as! AssociatedModel.StoredType) }
    }
}
