use std::sync::Arc;

use axum::{
    extract::{Path, State},
    http::{header::AUTHORIZATION, HeaderMap, StatusCode},
    routing::{delete, get, post, put},
    Error, Json, Router,
};
use tokio::sync::Mutex;

use crate::core::todo_store::{ToDoItem, ToDoStore};

pub fn make_router(store: ToDoStore) -> Router {
    let state = Arc::new(Mutex::new(store));
    Router::new()
        .route("/", get(|| async { "Hello, World!" }))
        .route("/todos", get(get_all_todos))
        .route("/todos/user/:user_id", get(get_all_private_todos))
        .route("/todos", post(new_todo))
        .route("/todos", put(update_todo))
        .route("/todos/:todo_id/delete", delete(delete_todo))
        .with_state(state)
}

async fn get_all_todos(State(state): State<Arc<Mutex<ToDoStore>>>) -> Json<Vec<ToDoItem>> {
    let mut store = state.lock().await;
    let todos = store.get_all().await.unwrap();
    Json(todos)
}

async fn get_all_private_todos(
    State(state): State<Arc<Mutex<ToDoStore>>>,
    Path(user_id): Path<u32>,
    headers: HeaderMap,
) -> Result<Json<Vec<ToDoItem>>, StatusCode> {
    let token = headers.get(AUTHORIZATION);
    if let Some(token) = token {
        let mut store = state.lock().await;
        let todos = store.get_all().await.unwrap();
        Ok(Json(todos))
    } else {
        Err(StatusCode::FORBIDDEN)
    }
}

async fn new_todo(
    State(state): State<Arc<Mutex<ToDoStore>>>,
    Json(new_todo): Json<ToDoItem>,
) -> Json<ToDoItem> {
    let mut store = state.lock().await;
    let created_todo = store.new_todo(new_todo).await.unwrap();

    Json(created_todo)
}

async fn update_todo(
    State(state): State<Arc<Mutex<ToDoStore>>>,
    Json(updated_todo): Json<ToDoItem>,
) -> Json<ToDoItem> {
    let mut store = state.lock().await;
    let new_todo = store.update_todo(updated_todo).await.unwrap();
    Json(new_todo)
}

async fn delete_todo(State(state): State<Arc<Mutex<ToDoStore>>>, Path(todo_id): Path<i32>) {
    let mut store = state.lock().await;
    store.delete_todo(todo_id).await;
}
