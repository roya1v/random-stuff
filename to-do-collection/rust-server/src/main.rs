mod core {
    pub mod auth_store;
    pub mod todo_store;
}

mod app_state;

mod routes {
    pub mod auth_route;
    pub mod todo_route;
}

use std::sync::Arc;

use axum::Router;
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
    let store = ToDoStore::new("todos.db").await.unwrap();
    Router::new()
        .merge(routes::todo_route::make_router(store))
        .layer(CorsLayer::permissive())
        .layer(TraceLayer::new_for_http())
}
