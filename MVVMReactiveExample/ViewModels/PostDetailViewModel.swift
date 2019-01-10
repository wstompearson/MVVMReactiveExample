//
//  PostDetailViewModel.swift
//  MVVMReactiveExample
//
//  Created by Tom Pearson on 24/12/2018.
//  Copyright © 2018 Tom Pearson. All rights reserved.
//

import RxSwift
import RxCocoa

class PostDetailViewModel {
    private let post: Driver<Post>
    private let user: Driver<User>
    private let comments: Driver<[Comment]>
    
    var title: Driver<String> {
        return post.map { post in
            return post.title
        }
    }
    
    var body: Driver<String> {
        return post.map { post in
            return post.body
        }
    }
    
    var author: Driver<String> {
        return user.map { user in
            return "Author: \(user.name)"
        }
    }
    
    var numberOfCommentsDescription: Driver<String> {
        return comments.map { comments in
            return "\(comments.count) comment".makePluralIfNecessary(comments)
        }
    }
    
    init(post: Post, fetcher: AdditionalPostDetailsFetcher = Store.shared) {
        self.post = Driver.just(post)
        if let user = fetcher.getUser(withId: post.userId) {
            self.user = Driver.just(user)
        } else {
            self.user = Driver.empty()
        }
        self.comments = Driver.just(fetcher.getComments(forPostId: post.id))
    }
}
