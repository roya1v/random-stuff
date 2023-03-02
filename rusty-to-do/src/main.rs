use std::env;
fn main() {
    let args: Vec<String> = env::args().collect();
    let command = args.get(1);
    match command {
        None => show_all(),
        Some(command) => match command.as_str() {
            "add" => add_todo(args[2].as_str()),
            _ => println!("Unknown command!")
        }
    }
}

fn show_all() {
    let connection = sqlite::open("rusty.db").unwrap();
    let query = "SELECT * FROM todos";
    println!("TODOs:");
    connection
    .iterate(query, |pairs| {
        for &(_, value) in pairs.iter() {
            println!("- {}", value.unwrap());
        }
        true
    })
    .unwrap();
}

fn add_todo(text: &str) {
    let connection = sqlite::open("rusty.db").unwrap();
    let query = format!("
    CREATE TABLE IF NOT EXISTS todos (text TEXT);
    INSERT INTO todos VALUES ('{text}');
    ");
    connection.execute(query).unwrap();
}
