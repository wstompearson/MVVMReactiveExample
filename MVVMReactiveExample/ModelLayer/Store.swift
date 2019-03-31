//
//  Store.swift
//  MVVMReactiveExample
//
//  Created by Tom Pearson on 25/12/2018.
//  Copyright © 2018 Tom Pearson. All rights reserved.
//

import RxSwift
import RxCocoa
import RealmSwift

class Store {
    private(set) var posts = BehaviorRelay<[Post]>(value: [])
    private(set) var users = BehaviorRelay<[User]>(value: [])
    private(set) var comments = BehaviorRelay<[Comment]>(value: [])

    private var localStore: LocalStore!
    private let disposeBag = DisposeBag()

    static let shared = Store()

    private init() {}

    func initialise(localStore: LocalStore = RealmLocalStore(), errorHandler: @escaping (Error) -> Void) {
        self.localStore = localStore

        Requester<Post>(fetchable: Post.self)
            .get(relay: posts, disposeBag: disposeBag, localStore: localStore, errorHandler: errorHandler)

        Requester<User>(fetchable: User.self)
            .get(relay: users, disposeBag: disposeBag, localStore: localStore, errorHandler: errorHandler)

        Requester<Comment>(fetchable: Comment.self)
            .get(relay: comments, disposeBag: disposeBag, localStore: localStore, errorHandler: errorHandler)

        localStore.listen(relay: posts)
        localStore.listen(relay: users)
        localStore.listen(relay: comments)
    }
}

extension Store: AdditionalPostDetailsFetcher {
    func getUser(withId id: Int) -> User? {
        return users.value.first(where: {$0.id == id})
    }

    func getComments(forPostId id: Int) -> [Comment] {
        return comments.value.filter { $0.postId == id }
    }
}
