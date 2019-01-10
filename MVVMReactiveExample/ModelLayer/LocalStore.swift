//
//  LocalStore.swift
//  MVVMReactiveExample
//
//  Created by Tom Pearson on 27/12/2018.
//  Copyright © 2018 Tom Pearson. All rights reserved.
//

import RxCocoa

protocol LocalStore {
    func listen<T: FetchableModel>(relay: BehaviorRelay<[T]>) 
    func loadModels<T: RealmStoreable>(storeableType: T.Type) -> [T.AssociatedModel]
}
