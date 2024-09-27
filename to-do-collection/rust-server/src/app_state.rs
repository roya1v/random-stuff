use std::sync::Arc;

use crate::core::auth_store::AuthStore;
use crate::core::todo_store::ToDoStore;

pub struct AppState {
    pub todo_store: Arc<ToDoStore>,
    pub auth_store: Box<AuthStore>,
}
