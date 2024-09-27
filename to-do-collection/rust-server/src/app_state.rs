use tokio::sync::Mutex;

use crate::core::auth_store::AuthStore;
use crate::core::todo_store::ToDoStore;

pub struct AppState {
    pub todo_store: Mutex<ToDoStore>,
    pub auth_store: Mutex<AuthStore>,
}
