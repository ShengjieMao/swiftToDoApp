//
//  ToDoClass.swift
//  TodoApp
//
//  Created by Shengjie Mao on 11/20/23.
//

import Foundation
import RealmSwift

class ToDoClass: Object {
    @Persisted(primaryKey: true) var todo: String = ""
}
