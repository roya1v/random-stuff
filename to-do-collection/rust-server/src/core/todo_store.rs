use serde::{Serialize, Deserialize};
use sqlx::{SqliteConnection, sqlite::SqliteConnectOptions, Error, query, Row, ConnectOptions};

#[derive(Serialize, Deserialize)]
pub struct ToDoItem {
    id: Option<i32>,
    content: String,
    is_done: bool,
}

pub struct ToDoStore {
    pool: SqliteConnection,
}

impl ToDoStore {
    pub async fn new(filename: &str) -> Result<Self, sqlx::Error> {
        let pool = SqliteConnectOptions::new()
            .filename(filename)
            .connect()
            .await?;

        Ok(ToDoStore { pool })
    }

    pub async fn get_all(mut self) -> Result<Vec<ToDoItem>, Error> {
        let result = query("SELECT * FROM todos")
            .fetch_all(&mut self.pool)
            .await?;
        let todos = result
            .iter()
            .map(|row| ToDoItem {
                id: row.get("id"),
                content: row.get("content"),
                is_done: row.get("is_done"),
            })
            .collect();

        Ok(todos)
    }

    pub async fn new_todo(mut self, todo: ToDoItem) -> Result<ToDoItem, Error> {
        let _ = query!(
            "INSERT INTO todos (content, is_done) VALUES(?, ?)",
            todo.content,
            false
        )
        .execute(&mut self.pool)
        .await;

        Ok(todo)
    }

    pub async fn update_todo(mut self, todo: ToDoItem) -> Result<ToDoItem, Error> {
        if todo.id.is_none() {
            todo!("Add error")
        }
        let _ = query!("UPDATE todos SET content = ?, is_done = ? WHERE id = ?", todo.content, todo.is_done, todo.id)
        .execute(&mut self.pool)
        .await;
    
        Ok(todo)
    }
}
