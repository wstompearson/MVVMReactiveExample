//
//  QueryBuilderTests.swift
//  MVVMReactiveExampleTests
//
//  Created by Tom Pearson on 23/12/2018.
//  Copyright © 2018 Tom Pearson. All rights reserved.
//

import XCTest
@testable import MVVMReactiveExample

class QueryBuilderTests: XCTestCase {

    var qb: QueryBuilder!

    override func setUp() {
        qb = QueryBuilder(url: URL(string: "https://test.com")!, queryDataType: Post.queryStringPath)
    }

    func testPostsURL() {
        let postsURL = qb.build()

        XCTAssertEqual(postsURL, URL(string: "https://test.com/posts")!)
    }

    func testLimitQueryURL() {
        let urlWithLimit = qb
            .addQueryItem(.limit(10))
            .build()

        XCTAssertEqual(urlWithLimit, URL(string: "https://test.com/posts?_limit=10"))
    }

    func testSliceQueryURL() {
        let slicedURL = qb
            .addQueryItem(.from(startIndex: 10))
            .addQueryItem(.to(endIndex: 20))
            .build()

        XCTAssertEqual(slicedURL, URL(string: "https://test.com/posts?_start=10&_end=20"))
    }

    func testIdFilterQueryURL() {
        let filteredURL = qb
            .addQueryItem(.idFilter(1))
            .build()

        XCTAssertEqual(filteredURL, URL(string: "https://test.com/posts?id=1"))
    }
}
