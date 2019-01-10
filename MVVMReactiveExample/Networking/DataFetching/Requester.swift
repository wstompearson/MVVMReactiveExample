//
//  Requester.swift
//  MVVMReactiveExample
//
//  Created by Tom Pearson on 25/12/2018.
//  Copyright © 2018 Tom Pearson. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

struct Requester<T: FetchableModel> {
    private let url: URL
    
    init<T: FetchableModel>(fetchable: T.Type, queryItems: QueryItem...) {
        self.url = QueryBuilder(queryDataType: T.queryStringPath)
            .addQueryItems(queryItems)
            .build()
    }
    
    func get<T: FetchableModel>(relay: BehaviorRelay<[T]>, disposeBag: DisposeBag, localStore: LocalStore, errorHandler: @escaping (Error) -> Void) {
        ReactiveDataFetcher().request(url: url, type: [T].self)
            .subscribe(onNext: { items in
                relay.accept(items)
            }, onError: { error in
                if case DataFetchingError.noData = error {
                    let storedModels = localStore.loadModels(storeableType: T.StoredType.self) as! [T]
                    if !storedModels.isEmpty {
                        relay.accept(storedModels)
                    } else {
                        errorHandler(error)
                    }
                } else {
                    errorHandler(error)
                }
            })
            .disposed(by: disposeBag)
    }
}
