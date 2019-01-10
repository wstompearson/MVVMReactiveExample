//
//  AdditionalPostDetailsFetcher.swift
//  MVVMReactiveExample
//
//  Created by Tom Pearson on 26/12/2018.
//  Copyright © 2018 Tom Pearson. All rights reserved.
//

protocol AdditionalPostDetailsFetcher {
    func getUser(withId id: Int) -> User?
    func getComments(forPostId id: Int) -> [Comment]
}
