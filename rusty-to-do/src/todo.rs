use serde::{Serialize, Deserialize};

pub struct ToDoManager {
    conn: rusqlite::Connection
}

#[derive(Serialize, Deserialize, Debug)]
pub struct ToDo {
    pub value: String,
    pub is_done: bool
}

impl ToDoManager {
    pub fn new(path: String) -> Self {
        let conn = rusqlite::Connection::open(path.as_str()).unwrap();
        conn.execute("CREATE TABLE IF NOT EXISTS todos (id INTEGER PRIMARY KEY, text TEXT, is_done BOOL);", ()).unwrap();
        ToDoManager { conn }
    }

    pub fn get_all(&self) -> Option<Vec<ToDo>> {
        let mut stmt = self.conn.prepare("SELECT * FROM todos").unwrap();
        let todo_iter = stmt.query_map([], |row| {
            Ok(ToDo { value: row.get(1).unwrap(), is_done: row.get(2).unwrap()})
        }).unwrap();
        let mut result: Vec<ToDo> = vec![];

        for todo in todo_iter {
            result.push(todo.unwrap())
        }
        Some(result)
    }

    pub fn add(&self, to_do: ToDo) {
        
        self.conn.execute(
        "INSERT INTO todos (text, is_done) VALUES(?1, ?2);",
         (&to_do.value, &to_do.is_done)).unwrap();
    }
}