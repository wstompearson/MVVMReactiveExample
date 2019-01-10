//
//  Database.swift
//  MVVMReactiveExample
//
//  Created by Tom Pearson on 27/12/2018.
//  Copyright © 2018 Tom Pearson. All rights reserved.
//

import RealmSwift

final class Database {
    private let realm: Realm
    
    init(realm: Realm = try! Realm()) {
        self.realm = realm
    }
    
    func createOrUpdate<T: FetchableModel>(_ model: T) {
        let object = T.reverseTransform(model)
        try! realm.write {
            realm.add(object, update: true)
        }
    }
    
    func fetch<RealmObject: RealmStoreable>(storedType: RealmObject.Type, with predicate: NSPredicate? = nil, sortDescriptors: [SortDescriptor] = []) -> [RealmObject.AssociatedModel] {
        var results = realm.objects(storedType)
        if let predicate = predicate {
            results = results.filter(predicate)
        }
        if sortDescriptors.count > 0 {
            results = results.sorted(by: sortDescriptors)
        }
        return RealmObject.transform(results)
    }
    
    func delete<RealmObject: Object>(type: RealmObject.Type, with primaryKey: String) {
        let object = realm.object(ofType: type, forPrimaryKey: primaryKey)
        if let object = object {
            try! realm.write {
                realm.delete(object)
            }
        }
    }
}
