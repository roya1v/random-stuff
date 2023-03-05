use std::env;
fn main() {
    let mngr = ToDoManager::new("./rusty.db".to_string());
    let args: Vec<String> = env::args().collect();
    let command = args.get(1);
    match command {
        None => {
            let to_do_s = mngr.get_all().unwrap();
            println!("{}", to_do_s.len());
            for to_do in to_do_s {
                println!("{}", to_do.value)
            }
        },
        Some(command) => match command.as_str() {
            "add" => mngr.add(ToDo { value: args.get(2).unwrap().as_str().to_string() }),
            _ => println!("Unknown command!")
        }
    }
}

struct ToDoManager {
    path: String
}

struct ToDo {
    value: String
}

impl  ToDoManager {
    fn new(path: String) -> Self {
        ToDoManager { path: path }
    }

    fn get_all(&self) -> Option<Vec<ToDo>> {
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

    fn add(&self, to_do: ToDo) {
        let conn = rusqlite::Connection::open(self.path.as_str()).unwrap();
        conn.execute("CREATE TABLE IF NOT EXISTS todos (id INTEGER PRIMARY KEY, text TEXT);", ()).unwrap();
        conn.execute(
        "INSERT INTO todos (text) VALUES(?1);",
         (&to_do.value,)).unwrap();
    }
}