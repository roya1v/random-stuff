use std::sync::Arc;

use serde::{Deserialize, Serialize};
use sqlx::{query, sqlite::SqliteConnectOptions, ConnectOptions, Error, Row, SqliteConnection};
use tokio::sync::Mutex;

#[derive(Serialize, Deserialize)]
pub struct ToDoItem {
    id: Option<i32>,
    content: String,
    is_done: bool,
    user_id: Option<i32>,
}

pub struct ToDoStore {
    pool: Arc<Mutex<SqliteConnection>>,
}

impl ToDoStore {
    pub async fn new(pool: Arc<Mutex<SqliteConnection>>) -> Result<Self, sqlx::Error> {
        Ok(ToDoStore { pool })
    }

    pub async fn get_all(&mut self) -> Result<Vec<ToDoItem>, Error> {
        let mut pool = self.pool.lock().await;
        let result = query("SELECT id, content, is_done FROM todos")
            .fetch_all(&mut *pool)
            .await?;
        let todos = result
            .iter()
            .map(|row| ToDoItem {
                id: row.get("id"),
                content: row.get("content"),
                is_done: row.get("is_done"),
                user_id: None,
            })
            .collect();

        Ok(todos)
    }

    pub async fn new_todo(&mut self, todo: ToDoItem) -> Result<ToDoItem, Error> {
        let mut pool = self.pool.lock().await;
        let _ = query!(
            "INSERT INTO todos (content, is_done) VALUES(?, ?)",
            todo.content,
            false
        )
        .execute(&mut *pool)
        .await;

        Ok(todo)
    }

    pub async fn update_todo(&mut self, todo: ToDoItem) -> Result<ToDoItem, Error> {
        if todo.id.is_none() {
            todo!("Add error")
        }
        let mut pool = self.pool.lock().await;
        let _ = query!(
            "UPDATE todos SET content = ?, is_done = ? WHERE id = ?",
            todo.content,
            todo.is_done,
            todo.id
        )
        .execute(&mut *pool)
        .await;

        Ok(todo)
    }

    pub async fn delete_todo(&mut self, todo_id: i32) -> Option<Error> {
        let mut pool = self.pool.lock().await;
        let _ = query!("DELETE FROM todos WHERE id = ?", todo_id)
            .execute(&mut *pool)
            .await;
        None
    }
}
