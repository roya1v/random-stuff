mod core {
    pub mod todo_store;
}

mod routes {
    pub mod todo_route;
}
use crate::core::todo_store::ToDoStore;

use routes::todo_route::make_router as make_todos_router;

#[tokio::main]
async fn main() {

    tracing_subscriber::fmt()
        .with_max_level(tracing::Level::DEBUG)
        .init();
    let store = ToDoStore::new("todos.db").await.unwrap();
    // run it with hyper on localhost:3000
    axum::Server::bind(&"0.0.0.0:3000".parse().unwrap())
        .serve(make_todos_router(store).into_make_service())
        .await
        .unwrap();
}
