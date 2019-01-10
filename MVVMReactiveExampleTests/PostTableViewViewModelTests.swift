//
//  PostTableViewViewModelTests.swift
//  MVVMReactiveExampleTests
//
//  Created by Tom Pearson on 27/12/2018.
//  Copyright © 2018 Tom Pearson. All rights reserved.
//

import XCTest
import RxCocoa
import RxBlocking
@testable import MVVMReactiveExample

private class MockPostsViewControllerDelegate: PostsViewControllerDelegate {
    var receivedPosts: [Post] = []
    
    func didSelect(_ post: Post) {
        receivedPosts.append(post)
    }
}

class PostTableViewViewModelTests: XCTestCase {
    var viewModel: PostsTableViewViewModel!
    var posts: [Post] = []

    override func setUp() {
        let bundle = Bundle(for: type(of: self))
        let url = bundle.url(forResource: "TestPosts", withExtension: "json")!
        let data = try! Data(contentsOf: url)
        
        self.posts = try! JSONDecoder().decode([Post].self, from: data)
        viewModel = PostsTableViewViewModel(posts: BehaviorRelay<[Post]>(value: posts))
    }

    func testNavigationTitle() {
        let navigationTitle = try! viewModel.navigationTitle.toBlocking().first()
        XCTAssertEqual(navigationTitle, "5 posts")
    }
    
    func testPostTitles() {
        let titles = try! viewModel.postTitles.toBlocking().first()!
        XCTAssertEqual(titles.count, posts.count)
        
        XCTAssertEqual(titles.first, "sunt aut facere repellat provident occaecati excepturi optio reprehenderit")
        XCTAssertEqual(titles.last, "nesciunt quas odio")
    }
    
    func testSelectedPost() {
        let delegate = MockPostsViewControllerDelegate()
        
        viewModel.didSelectRowAt(index: 0, delegate: delegate)
        XCTAssertEqual(delegate.receivedPosts.count, 1)
        XCTAssertEqual(delegate.receivedPosts[0].title, "sunt aut facere repellat provident occaecati excepturi optio reprehenderit")
        
        viewModel.didSelectRowAt(index: 1, delegate: delegate)
        XCTAssertEqual(delegate.receivedPosts.count, 2)
        XCTAssertEqual(delegate.receivedPosts[1].title, "qui est esse")
    }
    
    func testSearch() {
        viewModel.searchValue.accept("sunt")
        
        let titles = try! viewModel.postTitles.toBlocking().first()
        XCTAssertEqual(titles?.count, 1)
        XCTAssertEqual(titles?.first, "sunt aut facere repellat provident occaecati excepturi optio reprehenderit")
        
        viewModel.searchValue.accept("")
        let newTitles = try! viewModel.postTitles.toBlocking().first()
        XCTAssertEqual(newTitles?.count, posts.count)
    }
}
