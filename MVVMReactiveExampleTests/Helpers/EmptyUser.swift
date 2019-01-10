//
//  EmptyUser.swift
//  MVVMReactiveExampleTests
//
//  Created by Tom Pearson on 27/12/2018.
//  Copyright © 2018 Tom Pearson. All rights reserved.
//

@testable import MVVMReactiveExample

extension User {
    init(name: String) {
        self.init(id: 0, name: name, username: "", email: "", phone: "", website: "", address: Address(street: "", suite: "", city: "", zipcode: "", geo: Geo(lat: "", lng: "")), company: Company(name: "", catchPhrase: "", bs: ""))
    }
}
