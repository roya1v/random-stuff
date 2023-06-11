use std::sync::Arc;

use axum::{Router, routing::{get, post}, Json, extract::{self, State}};

mod todo;
use todo::{ToDo, ToDoManager};
use tokio::sync::Mutex;

struct AppState {
    mngr: ToDoManager   
}

#[tokio::main]
async fn main() {
    let shared_state = Arc::new(Mutex::new(AppState { mngr: ToDoManager::new("todo.db".to_string()) }));

    let app = Router::new()
    .route("/", get(list_all))
    .route("/", post(new))
    .with_state(shared_state);

    // run it with hyper on localhost:3000
    axum::Server::bind(&"0.0.0.0:3000".parse().unwrap())
        .serve(app.into_make_service())
        .await
        .unwrap();
}

async fn list_all(State(state): State<Arc<Mutex<AppState>>>) -> Json<Vec<ToDo>> {
    
    Json(state.lock().await.mngr.get_all().unwrap())
}

async fn new(State(state): State<Arc<Mutex<AppState>>>, extract::Json(payload): extract::Json<ToDo>) {
    state.lock().await.mngr.add(payload)
}
