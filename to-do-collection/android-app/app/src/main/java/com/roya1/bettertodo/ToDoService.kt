package com.roya1.bettertodo

import io.ktor.client.HttpClient
import io.ktor.client.call.body
import io.ktor.client.engine.android.Android
import io.ktor.client.plugins.contentnegotiation.ContentNegotiation
import io.ktor.client.request.get
import kotlinx.serialization.SerialName
import kotlinx.serialization.Serializable
import io.ktor.serialization.kotlinx.json.*

class ToDoService {

    suspend fun fetchAll(): List<ToDoItem> {
        val client = HttpClient(Android) {
            install(ContentNegotiation) {
                json()
            }
        }
        return client.get("http://10.0.2.2:3000/todos").body()
    }
}

@Serializable
data class ToDoItem(val id: Int, val content: String, @SerialName("is_done") val isDone: Boolean)