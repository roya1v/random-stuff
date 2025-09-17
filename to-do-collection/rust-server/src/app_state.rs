use tokio::sync::Mutex;

use crate::core::todo_store::ToDoStore;

pub struct AppState {
    pub todo_store: Mutex<ToDoStore>,
}
