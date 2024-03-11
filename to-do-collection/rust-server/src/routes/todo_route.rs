use axum::{
    extract::Path,
    routing::{delete, get, post, put},
    Json, Router,
};
use tower_http::{cors::CorsLayer, trace::TraceLayer};

use crate::core::todo_store::{ToDoItem, ToDoStore};

pub fn make_router() -> Router {
    Router::new()
        .route("/", get(|| async { "Hello, World!" }))
        .route("/todos", get(get_all_todos))
        .route("/todos", post(new_todo))
        .route("/todos", put(update_todo))
        .route("/todos/:todo_id/delete", delete(delete_todo))
        .layer(CorsLayer::permissive())
        .layer(TraceLayer::new_for_http())
}

async fn get_all_todos() -> Json<Vec<ToDoItem>> {
    let store = ToDoStore::new("todos.db").await.unwrap();
    let todos = store.get_all().await.unwrap();
    Json(todos)
}

async fn new_todo(Json(new_todo): Json<ToDoItem>) -> Json<ToDoItem> {
    let store = ToDoStore::new("todos.db").await.unwrap();
    let created_todo = store.new_todo(new_todo).await.unwrap();

    Json(created_todo)
}

async fn update_todo(Json(updated_todo): Json<ToDoItem>) -> Json<ToDoItem> {
    let store = ToDoStore::new("todos.db").await.unwrap();
    let new_todo = store.update_todo(updated_todo).await.unwrap();
    Json(new_todo)
}

async fn delete_todo(Path(todo_id): Path<i32>) {
    let store = ToDoStore::new("todos.db").await.unwrap();
    store.delete_todo(todo_id).await;
}
