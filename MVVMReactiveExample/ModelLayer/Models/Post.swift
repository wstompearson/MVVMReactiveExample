//
//  Post.swift
//  MVVMReactiveExample
//
//  Created by Tom Pearson on 26/12/2018.
//  Copyright © 2018 Tom Pearson. All rights reserved.
//

import Foundation

struct Post: Decodable {
    let userId, id: Int
    let title, body: String
}
