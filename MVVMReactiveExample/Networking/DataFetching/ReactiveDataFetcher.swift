//
//  ReactiveDataFetcher.swift
//  MVVMReactiveExample
//
//  Created by Tom Pearson on 24/12/2018.
//  Copyright © 2018 Tom Pearson. All rights reserved.
//

import Foundation
import RxSwift

struct ReactiveDataFetcher {
    func request<T: Decodable>(url: URL, type: T.Type) -> Observable<T> {
        return Observable.create { observer in
            let task = URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
                guard let data = data else {
                    observer.onError(DataFetchingError.noData)
                    return
                }
                guard error == nil else {
                    observer.onError(error!)
                    return
                }
                do {
                    let result = try JSONDecoder().decode(T.self, from: data)
                    observer.onNext(result)
                } catch {
                    observer.onError(error)
                }
                observer.onCompleted()
            })
            task.resume()
            
            return Disposables.create {
                task.cancel()
            }
        }
    }
}
