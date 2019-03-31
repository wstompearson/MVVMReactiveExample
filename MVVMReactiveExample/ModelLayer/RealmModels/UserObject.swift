//
//  UserObject.swift
//  MVVMReactiveExample
//
//  Created by Tom Pearson on 27/12/2018.
//  Copyright © 2018 Tom Pearson. All rights reserved.
//

import RealmSwift

final class UserObject: Object, RealmStoreable {
    typealias AssociatedModel = User

    @objc dynamic var id: Int = -1
    @objc dynamic var name: String = ""
    @objc dynamic var username: String = ""
    @objc dynamic var email: String = ""
    @objc dynamic var phone: String = ""
    @objc dynamic var website: String = ""

    @objc dynamic var street: String = ""
    @objc dynamic var suite: String = ""
    @objc dynamic var city: String = ""
    @objc dynamic var zipcode: String = ""

    @objc dynamic var lat: String = ""
    @objc dynamic var lng: String = ""

    @objc dynamic var companyName: String = ""
    @objc dynamic var companyCatchPhrase: String = ""
    @objc dynamic var companyBs: String = ""

    override static func primaryKey() -> String? {
        return "id"
    }
}

extension UserObject {
    convenience init(model: User) {
        self.init()
        self.id = model.id
        self.name = model.name
        self.username = model.username
        self.email = model.email
        self.phone = model.phone
        self.website = model.website

        self.street = model.address.street
        self.suite = model.address.suite
        self.city = model.address.city
        self.lat = model.address.geo.lat
        self.lng = model.address.geo.lng

        self.companyName = model.company.name
        self.companyCatchPhrase = model.company.catchPhrase
        self.companyBs = model.company.bs
    }
}

extension User {
    init(object: UserObject) {
        self.id = object.id
        self.name = object.name
        self.username = object.username
        self.email = object.email
        self.phone = object.phone
        self.website = object.website

        self.address = Address(street: object.street, suite: object.suite, city: object.city, zipcode: object.zipcode, geo: Geo(lat: object.lat, lng: object.lng))

        self.company = Company(name: object.companyName, catchPhrase: object.companyCatchPhrase, bs: object.companyBs)
    }
}
