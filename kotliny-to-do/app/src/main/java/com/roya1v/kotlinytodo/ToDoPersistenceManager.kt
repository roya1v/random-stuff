package com.roya1v.kotlinytodo

import io.realm.kotlin.Realm
import io.realm.kotlin.RealmConfiguration
import io.realm.kotlin.ext.query

class ToDoPersistenceManager {

    private val realm = Realm.open(RealmConfiguration.create(schema = setOf(ToDoModel::class)))

    fun save(toDo: ToDo) {
        realm.writeBlocking {
            copyToRealm(ToDoModel().apply {
                title = toDo.title
                isComplete = false
            })
        }
    }

    fun getAllToDos(): List<ToDo> {
        val items = realm.query<ToDoModel>().find()
        return items.map { ToDo(it.title) }
    }
}