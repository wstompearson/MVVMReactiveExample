//
//  CommentObject.swift
//  MVVMReactiveExample
//
//  Created by Tom Pearson on 27/12/2018.
//  Copyright © 2018 Tom Pearson. All rights reserved.
//

import RealmSwift

final class CommentObject: Object, RealmStoreable {
    typealias AssociatedModel = Comment

    @objc dynamic var postId: Int = -1
    @objc dynamic var id: Int = -1
    @objc dynamic var name: String = ""
    @objc dynamic var email: String = ""
    @objc dynamic var body: String = ""

    override static func primaryKey() -> String? {
        return "id"
    }
}

extension CommentObject {
    convenience init(model: Comment) {
        self.init()
        self.postId = model.postId
        self.id = model.id
        self.name = model.name
        self.email = model.email
        self.body = model.body
    }
}

extension Comment {
    init(object: CommentObject) {
        self.init(postId: object.postId, id: object.id, name: object.name, email: object.email, body: object.body)
    }
}
