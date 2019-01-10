//
//  User.swift
//  MVVMReactiveExample
//
//  Created by Tom Pearson on 26/12/2018.
//  Copyright © 2018 Tom Pearson. All rights reserved.
//

struct User: Decodable {
    let id: Int
    let name, username, email, phone, website: String
    let address: Address
    let company: Company
}

struct Address: Decodable {
    let street, suite, city, zipcode: String
    let geo: Geo
}

struct Geo: Decodable {
    let lat, lng: String
}

struct Company: Decodable {
    let name, catchPhrase, bs: String
}
