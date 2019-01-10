//
//  DataFetchingError.swift
//  MVVMReactiveExample
//
//  Created by Tom Pearson on 30/12/2018.
//  Copyright © 2018 Tom Pearson. All rights reserved.
//

import Foundation

enum DataFetchingError: Error, LocalizedError {
    case noData
    
    var errorDescription: String? {
        return "No network access"
    }
}
