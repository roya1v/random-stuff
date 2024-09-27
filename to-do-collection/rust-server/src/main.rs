mod core {
    pub mod auth_store;
    pub mod todo_store;
}

mod app_state;

mod routes {
    pub mod auth_route;
    pub mod todo_route;
}

use app_state::AppState;
use axum::Router;
use core::auth_store::AuthStore;
use routes::{auth_route, todo_route};
use sqlx::sqlite::SqliteConnectOptions;
use sqlx::ConnectOptions;
use std::sync::Arc;
use tokio::sync::Mutex;
use tower_http::{cors::CorsLayer, trace::TraceLayer};

use crate::core::todo_store::ToDoStore;

#[tokio::main]
async fn main() {
    tracing_subscriber::fmt()
        .with_max_level(tracing::Level::DEBUG)
        .init();
    // run it with hyper on localhost:3000
    axum::Server::bind(&"0.0.0.0:3000".parse().unwrap())
        .serve(make_router().await.into_make_service())
        .await
        .unwrap();
}

async fn make_router() -> Router {
    let pool = Arc::new(Mutex::new(
        SqliteConnectOptions::new()
            .filename("todos.db")
            .connect()
            .await
            .unwrap(),
    ));
    let todo_store = ToDoStore::new(pool.clone()).await.unwrap();
    let auth_store = AuthStore::new(pool).await.unwrap();
    let state = Arc::new(AppState {
        todo_store: Mutex::new(todo_store),
        auth_store: Mutex::new(auth_store),
    });
    Router::new()
        .merge(todo_route::make_router(state.clone()))
        .merge(auth_route::make_router(state))
        .layer(CorsLayer::permissive())
        .layer(TraceLayer::new_for_http())
}
