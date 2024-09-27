use std::sync::Arc;

use axum::{extract::State, response::IntoResponse, routing::post, Router};

use crate::app_state::AppState;

pub fn make_router(state: Arc<AppState>) -> Router {
    Router::new()
        .route("/auth/register", post(create_user))
        .with_state(state)
}

async fn create_user(State(state): State<Arc<AppState>>) -> impl IntoResponse {
    todo!()
}
