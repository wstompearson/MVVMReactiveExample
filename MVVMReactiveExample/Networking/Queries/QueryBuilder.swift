//
//  QueryBuilder.swift
//  MVVMReactiveExample
//
//  Created by Tom Pearson on 23/12/2018.
//  Copyright © 2018 Tom Pearson. All rights reserved.
//

import Foundation

class QueryBuilder {
    private var components: URLComponents
    
    init(url: URL = .baseUrl, queryDataType type: String) {
        self.components = URLComponents(url: url.appendingPathComponent(type), resolvingAgainstBaseURL: false)!
    }
    
    @discardableResult
    func addQueryItem(_ item: QueryItem) -> QueryBuilder {
        if components.queryItems == nil {
            components.queryItems = []
        }
        
        let queryItem = URLQueryItem(name: item.key, value: item.value)
        components.queryItems?.append(queryItem)
        
        return self
    }
    
    @discardableResult
    func addQueryItems(_ items: [QueryItem]) -> QueryBuilder {
        for item in items {
            addQueryItem(item)
        }
        
        return self
    }
    
    func build() -> URL {
        assert(components.url != nil, "URL was malformed")
        return components.url!
    }
}

private extension URL {
    static let baseUrl = URL(string: "https://jsonplaceholder.typicode.com")!
}
