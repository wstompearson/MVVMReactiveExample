//
//  PostDetailViewModelTests.swift
//  MVVMReactiveExampleTests
//
//  Created by Tom Pearson on 26/12/2018.
//  Copyright © 2018 Tom Pearson. All rights reserved.
//

import XCTest
import RxBlocking
@testable import MVVMReactiveExample

private struct MockDetailsFetcher: AdditionalPostDetailsFetcher {
    func getUser(withId id: Int) -> User? {
        return User(name: "Joe Bloggs")
    }
    
    func getComments(forPostId id: Int) -> [Comment] {
        return [Comment(postId: 2, id: 2, name: "Comment name", email: "Comment email", body: "Comment body")]
    }
}

class PostDetailViewModelTests: XCTestCase {
    private var viewModel: PostDetailViewModel!
    
    override func setUp() {
        let post = Post(userId: 1, id: 1, title: "Post title", body: "Post body")
        viewModel = PostDetailViewModel(post: post, fetcher: MockDetailsFetcher())
    }

    func testTitleBinding() {
        let titleText = try! viewModel.title.toBlocking().first()
        XCTAssertEqual(titleText, "Post title")
    }
    
    func testBodyBinding() {
        let bodyText = try! viewModel.body.toBlocking().first()
        XCTAssertEqual(bodyText, "Post body")
    }
    
    func testAuthorBinding() {
        let authorText = try! viewModel.author.toBlocking().first()
        XCTAssertEqual(authorText, "Author: Joe Bloggs")
    }
    
    func testCommentBinding() {
        let numberOfCommentsText = try! viewModel.numberOfCommentsDescription.toBlocking().first()
        XCTAssertEqual(numberOfCommentsText, "1 comment")
    }
}
