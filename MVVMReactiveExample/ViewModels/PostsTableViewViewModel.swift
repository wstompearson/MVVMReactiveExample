//
//  PostsTableViewViewModel.swift
//  MVVMReactiveExample
//
//  Created by Tom Pearson on 24/12/2018.
//  Copyright © 2018 Tom Pearson. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class PostsTableViewViewModel {
    private let posts: BehaviorRelay<[Post]>
    private let filteredPosts = BehaviorRelay<[Post]>(value: [])
    var searchValue = BehaviorRelay<String>(value: "")

    private let disposeBag = DisposeBag()

    init(posts: BehaviorRelay<[Post]> = Store.shared.posts) {
        self.posts = posts

        let postsFromSearch: Observable<[Post]> = searchValue
            .asObservable()
            .map { value in
            guard !value.isEmpty else {
                return posts.value
            }
            return posts.value.filter { $0.title.localizedCaseInsensitiveContains(value) }
        }

        Observable.of(posts.asObservable(), postsFromSearch)
            .merge()
            .subscribe(onNext: { [weak self] posts in
                self?.filteredPosts.accept(posts)
            })
            .disposed(by: disposeBag)
    }

    var navigationTitle: Driver<String> {
        return filteredPosts.asDriver().map { posts in
            return "\(posts.count) post".makePluralIfNecessary(posts)
        }
    }

    var postTitles: Driver<[String]> {
        return filteredPosts.asDriver().map { posts in
            return posts.map {$0.title}
        }
    }

    func didSelectRowAt(index: Int, delegate: PostsViewControllerDelegate?) {
        delegate?.didSelect(posts.value[index])
    }
}
