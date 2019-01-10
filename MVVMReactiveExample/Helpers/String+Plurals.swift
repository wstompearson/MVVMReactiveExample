//
//  String+Plurals.swift
//  MVVMReactiveExample
//
//  Created by Tom Pearson on 25/12/2018.
//  Copyright © 2018 Tom Pearson. All rights reserved.
//

extension String {
    func makePluralIfNecessary<T>(_ items: [T]) -> String {
        return self + "\(items.count == 1 ? "" : "s")"
    }
}
