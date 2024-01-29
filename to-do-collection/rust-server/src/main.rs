mod core {
    pub mod todo_store;
}

mod routes { 
    pub mod todo_route;
}
use routes::todo_route::make_router as make_todos_router;

#[tokio::main]
async fn main() {
        // run it with hyper on localhost:3000
        axum::Server::bind(&"0.0.0.0:3000".parse().unwrap())
            .serve(make_todos_router().into_make_service())
            .await
            .unwrap();
}