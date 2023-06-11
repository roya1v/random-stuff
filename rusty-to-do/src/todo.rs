use serde::{Serialize, Deserialize};

pub struct ToDoManager {
    path: String
}

#[derive(Serialize, Deserialize, Debug)]
pub struct ToDo {
    pub value: String
}

impl ToDoManager {
    pub fn new(path: String) -> Self {
        ToDoManager { path: path }
    }

    pub fn get_all(&self) -> Option<Vec<ToDo>> {
        let conn = rusqlite::Connection::open(self.path.as_str()).unwrap();
        let mut stmt = conn.prepare("SELECT * FROM todos").unwrap();
        let todo_iter = stmt.query_map([], |row| {
            Ok(ToDo { value: row.get(1).unwrap()})
        }).unwrap();
        let mut result: Vec<ToDo> = vec![];

        for todo in todo_iter {
            result.push(todo.unwrap())
        }
        Some(result)
    }

    pub fn add(&self, to_do: ToDo) {
        let conn = rusqlite::Connection::open(self.path.as_str()).unwrap();
        conn.execute("CREATE TABLE IF NOT EXISTS todos (id INTEGER PRIMARY KEY, text TEXT);", ()).unwrap();
        conn.execute(
        "INSERT INTO todos (text) VALUES(?1);",
         (&to_do.value,)).unwrap();
    }
}