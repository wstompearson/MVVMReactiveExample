//
//  LocalStore.swift
//  MVVMReactiveExample
//
//  Created by Tom Pearson on 27/12/2018.
//  Copyright © 2018 Tom Pearson. All rights reserved.
//

import RxSwift
import RealmSwift
import RxCocoa

class RealmLocalStore: LocalStore {
    private let disposeBag = DisposeBag()

    func listen<T: FetchableModel>(relay: BehaviorRelay<[T]>) {
        relay
            .subscribe(onNext: { items in
                for item in items {
                    Database().createOrUpdate(item)
                }
            })
            .disposed(by: disposeBag)
    }

    func loadModels<T: RealmStoreable>(storeableType: T.Type) -> [T.AssociatedModel] {
        return Database().fetch(storedType: T.self)
    }
}
