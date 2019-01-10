//
//  Comment.swift
//  MVVMReactiveExample
//
//  Created by Tom Pearson on 26/12/2018.
//  Copyright © 2018 Tom Pearson. All rights reserved.
//

struct Comment: Decodable {
    let postId, id: Int
    let name, email, body: String
}
