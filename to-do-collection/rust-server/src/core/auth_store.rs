use std::sync::Arc;

use serde::{Deserialize, Serialize};
use sqlx::{query, sqlite::SqliteConnectOptions, ConnectOptions, Error, Row, SqliteConnection};
use tokio::sync::Mutex;

#[derive(Serialize, Deserialize)]
pub struct User {
    id: Option<i32>,
    username: String,
    password_hash: String,
}

pub struct AuthStore {
    pool: Arc<Mutex<SqliteConnection>>,
}

impl AuthStore {
    pub async fn new(pool: Arc<Mutex<SqliteConnection>>) -> Result<Self, sqlx::Error> {
        Ok(AuthStore { pool })
    }

    pub async fn new_user(&mut self, username: String, password: String) -> Result<User, Error> {
        // let _ = query!(
        //     "INSERT INTO todos (content, is_done) VALUES(?, ?)",
        //     todo.content,
        //     false
        // )
        // .execute(&mut self.pool)
        // .await;

        // Ok(todo)
        todo!()
    }

    pub async fn auth_user(&mut self, username: String, basicToken: String) -> Result<User, Error> {
        todo!()
    }
}
