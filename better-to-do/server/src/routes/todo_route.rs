use axum::{
    routing::{get, post, put},
     Json, Router,
};

use serde_json::{json, Value};

use crate::core::todo_store::{ToDoStore, ToDoItem};

pub fn make_router() -> Router {
    Router::new()
        .route("/", get(|| async { "Hello, World!" }))
        .route("/todos", get(get_all_todos))
        .route("/todos", post(new_todo))
        .route("/todos", put(update_todo))
}

async fn get_all_todos() -> Json<Value> {
    let store = ToDoStore::new("todos.db").await.unwrap();
    let todos = store.get_all().await.unwrap();
    let json = json!(todos);
    Json(json!(json))
}

async fn new_todo(Json(new_todo): Json<ToDoItem>) -> Json<Value> {
    let store = ToDoStore::new("todos.db").await.unwrap();
    let created_todo = store.new_todo(new_todo).await.unwrap();

    Json(json!(created_todo))
}

async fn update_todo(Json(updated_todo): Json<ToDoItem>) -> Json<Value> {
    let store = ToDoStore::new("todos.db").await.unwrap();
    let new_todo = store.update_todo(updated_todo).await.unwrap();
    Json(json!(new_todo))
}
