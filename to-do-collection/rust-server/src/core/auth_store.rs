use serde::{Deserialize, Serialize};
use sqlx::{query, sqlite::SqliteConnectOptions, ConnectOptions, Error, Row, SqliteConnection};

#[derive(Serialize, Deserialize)]
pub struct User {
    id: Option<i32>,
    username: String,
    password_hash: String,
}

pub struct AuthStore {
    pool: SqliteConnection,
}

impl AuthStore {
    pub async fn new(filename: &str) -> Result<Self, sqlx::Error> {
        let pool = SqliteConnectOptions::new()
            .filename(filename)
            .connect()
            .await?;

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
