//
//  FetchableModel.swift
//  MVVMReactiveExample
//
//  Created by Tom Pearson on 30/12/2018.
//  Copyright © 2018 Tom Pearson. All rights reserved.
//

protocol FetchableModel: Decodable {
    associatedtype StoredType: RealmStoreable
    
    static var queryStringPath: String { get }
    init(object: StoredType)
}

extension FetchableModel {
    static func reverseTransform(_ model: Self) -> StoredType {
        return StoredType.init(model: model as! StoredType.AssociatedModel)
    }
}

extension Post: FetchableModel {
    typealias StoredType = PostObject
    
    static let queryStringPath: String = "posts"
}

extension Comment: FetchableModel {
    typealias StoredType = CommentObject
    
    static let queryStringPath: String = "comments"
}

extension User: FetchableModel {
    typealias StoredType = UserObject
    
    static let queryStringPath: String = "users"
}
