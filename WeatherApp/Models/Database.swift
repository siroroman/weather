//
//  Database.swift
//  WeatherApp
//
//  Created by Roman Siro on 19.06.18.
//  Copyright © 2018 Roman Siro. All rights reserved.
//

import Foundation
import RealmSwift

class Database {

    static let shared = Database()

    private let realm = try! Realm()

    private init() {}

    func add<T: Object>(object: T) {
        try! realm.write {
            realm.add(object, update: true)
        }
    }

    func delete<T: Object>(object: T) {
        try! realm.write {
            realm.delete(object)
        }
    }

    func deleteAll<T: Object>(of type: T.Type) {
        let objects = realm.objects(type)
        try! realm.write {
            realm.delete(objects)
        }
    }

    func fetch<T: Object>(of type: T.Type) -> Results<T> {
        return realm.objects(type)
    }
    
}
