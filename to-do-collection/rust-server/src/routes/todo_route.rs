use std::sync::Arc;

use axum::{
    extract::{Path, State},
    http::{header::AUTHORIZATION, HeaderMap, StatusCode},
    routing::{delete, get, post, put},
    Json, Router,
};

use crate::{app_state::AppState, core::todo_store::ToDoItem};

pub fn make_router(state: Arc<AppState>) -> Router {
    Router::new()
        .route("/", get(|| async { "Hello, World!" }))
        .route("/todos", get(get_all_todos))
        .route("/todos/user/:user_id", get(get_all_private_todos))
        .route("/todos", post(new_todo))
        .route("/todos", put(update_todo))
        .route("/todos/:todo_id/delete", delete(delete_todo))
        .with_state(state)
}

async fn get_all_todos(State(state): State<Arc<AppState>>) -> Json<Vec<ToDoItem>> {
    let mut store = state.todo_store.lock().await;
    let todos = store.get_all().await.unwrap();
    Json(todos)
}

async fn get_all_private_todos(
    State(state): State<Arc<AppState>>,
    Path(username): Path<String>,
    headers: HeaderMap,
) -> Result<Json<Vec<ToDoItem>>, StatusCode> {
    if let Some(token) = headers.get(AUTHORIZATION) {
        let mut auth = state.auth_store.lock().await;
        let result = auth
            .auth_user(username, token.to_str().unwrap().to_string())
            .await;
        if let Ok(user) = result {
            let mut store = state.todo_store.lock().await;
            let todos = store.get_all().await.unwrap();
            return Ok(Json(todos));
        }
    }
    Err(StatusCode::FORBIDDEN)
}

async fn new_todo(
    State(state): State<Arc<AppState>>,
    Json(new_todo): Json<ToDoItem>,
) -> Json<ToDoItem> {
    let mut store = state.todo_store.lock().await;
    let created_todo = store.new_todo(new_todo).await.unwrap();

    Json(created_todo)
}

async fn update_todo(
    State(state): State<Arc<AppState>>,
    Json(updated_todo): Json<ToDoItem>,
) -> Json<ToDoItem> {
    let mut store = state.todo_store.lock().await;
    let new_todo = store.update_todo(updated_todo).await.unwrap();
    Json(new_todo)
}

async fn delete_todo(State(state): State<Arc<AppState>>, Path(todo_id): Path<i32>) {
    let mut store = state.todo_store.lock().await;
    store.delete_todo(todo_id).await;
}
