use std::sync::Arc;

use axum::{
    extract::{Path, State},
    routing::{delete, get, post, put},
    Json, Router,
};
use tokio::sync::Mutex;
use tower_http::{cors::CorsLayer, trace::TraceLayer};

use crate::core::todo_store::{ToDoItem, ToDoStore};

pub fn make_router(store: ToDoStore) -> Router {
    let state = Arc::new(Mutex::new(store));
    Router::new().with_state(state)
}
