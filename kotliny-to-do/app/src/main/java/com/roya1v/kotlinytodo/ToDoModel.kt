package com.roya1v.kotlinytodo

import io.realm.kotlin.types.RealmObject
import io.realm.kotlin.types.annotations.PrimaryKey
import org.mongodb.kbson.ObjectId

class ToDoModel(): RealmObject {
    @PrimaryKey
    var id: ObjectId = ObjectId()
    var isComplete: Boolean = false
    var title: String = ""
}