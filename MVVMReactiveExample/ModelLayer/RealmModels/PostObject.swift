//
//  PostObject.swift
//  MVVMReactiveExample
//
//  Created by Tom Pearson on 27/12/2018.
//  Copyright © 2018 Tom Pearson. All rights reserved.
//

import RealmSwift

final class PostObject: Object, RealmStoreable {
    typealias AssociatedModel = Post
    
    @objc dynamic var userId: Int = -1
    @objc dynamic var id: Int = -1
    @objc dynamic var title: String = ""
    @objc dynamic var body: String = ""
    
    override static func primaryKey() -> String? {
        return "id"
    }
}

extension PostObject {
    convenience init(model: Post) {
        self.init()
        self.userId = model.userId
        self.id = model.id
        self.title = model.title
        self.body = model.body
    }
}

extension Post {
    init(object: PostObject) {
        self.init(userId: object.userId, id: object.id, title: object.title, body: object.body)
    }
}
