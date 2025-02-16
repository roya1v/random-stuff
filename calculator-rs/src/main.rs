use std::{fmt::Error, io, vec};

use libadwaita::gtk::builders::LabelBuilder;
use libadwaita::prelude::*;

use libadwaita::{ActionRow, Application, ApplicationWindow, HeaderBar};
use libadwaita::gtk::{Box, Button, Label, ListBox, Orientation, SelectionMode};

fn main() {
    let application = Application::builder()
        .application_id("com.example.FirstAdwaitaApp")
        .build();

    application.connect_activate(|app| {
        let content = Box::new(Orientation::Vertical, 0);



        content.append(&HeaderBar::new());
        let label = Label::builder().label("test").build();
        content.append(&label);
        setup_keypad(&content);

        let window = ApplicationWindow::builder()
            .application(app)
            .title("Calculator")
            .default_width(350)
            .content(&content)
            .build();
        window.present();
    });

    application.run();
}

fn setup_keypad(content: &Box) {
    let cancel_button = get_button("C");
    let idk_button = get_button("idk");
    let percent_button = get_button("%");
    let divide_button = get_button("/");

    let row = Box::new(Orientation::Horizontal, 0);
    row.append(&cancel_button);
    row.append(&idk_button);
    row.append(&percent_button);
    row.append(&divide_button);

    content.append(&row);

    let seven_button = get_button("7");
    let eight_button = get_button("8");
    let nine_button = get_button("9");
    let multiply_button = get_button("*");

    let row = Box::new(Orientation::Horizontal, 0);
    row.append(&seven_button);
    row.append(&eight_button);
    row.append(&nine_button);
    row.append(&multiply_button);

    content.append(&row);

    let four_button = get_button("4");
    let five_button = get_button("5");
    let six_button = get_button("6");
    let minus_button = get_button("-");

    let row = Box::new(Orientation::Horizontal, 0);
    row.append(&four_button);
    row.append(&five_button);
    row.append(&six_button);
    row.append(&minus_button);

    content.append(&row);

    let one_button = get_button("1");
    let two_button = get_button("2");
    let three_button = get_button("3");
    let plus_button = get_button("+");

    let row = Box::new(Orientation::Horizontal, 0);
    row.append(&one_button);
    row.append(&two_button);
    row.append(&three_button);
    row.append(&plus_button);

    content.append(&row);

    let idk_button = get_button("idk");
    let zero_button = get_button("0");
    let comma_button = get_button(",");
    let equals_button = get_button("=");

    let row = Box::new(Orientation::Horizontal, 0);
    row.append(&idk_button);
    row.append(&zero_button);
    row.append(&comma_button);
    row.append(&equals_button);

    content.append(&row);
}

fn get_button(label: &str) -> Button {
     Button::builder()
        .label(label)
        .margin_top(12)
        .margin_bottom(12)
        .margin_start(12)
        .margin_end(12)
        .build()
}

// fn main2() {
//     loop {
//         let mut expression = String::new();
//         let stdin = io::stdin(); // We get `Stdin` here.
//         stdin.read_line(&mut expression).unwrap();
//         let result = evaluate_polish_notion(&expression.trim()).unwrap();
//         println !("={}", result); 
//     }
// }

// enum Expression {
//     Operand(i32),
//     Operator(Box<dyn Fn(i32, i32) -> i32>)
// }

// fn evaluate_polish_notion(expression: &str) -> Result<i32, Error> {
//     let mut expressions: Vec<Expression> = vec![];
//     let mut buffer: Vec<char> = vec![];
//     for char in expression.chars() {
//         if let Some(expression) = parse(char) {
//             let operand = buffer.clone().into_iter().collect::<String>().parse::<i32>().unwrap();
//             expressions.push(Expression::Operand(operand));
//             buffer.clear();
//             expressions.push(expression);
//         } else {
//             buffer.push(char);
//         }
//     }
//     if !buffer.is_empty() {
//         let operand = buffer.clone().into_iter().collect::<String>().parse::<i32>().unwrap();
//         expressions.push(Expression::Operand(operand));
//     }

//     let mut x = Option::<i32>::None;
//     let mut operator = Option::<Box<dyn Fn(i32, i32) -> i32>>::None;

//     for expression in expressions.iter() {
        
//         match expression {
//             Expression::Operand(y) => {
//                 if let Some(x1) = x   {
//                     if let Some(operator2) = operator {
//                         let test = operator2(*y, x1);
//                         x = Some(test);
//                         operator = None;
//                     }
//                 } else {
//                     x = Some(*y)
//                 }
//             },
//             Expression::Operator(operator2) => operator = Some(Box::new(operator2)),
//         }
//     }
    
//     Ok(x.unwrap())
// }

// fn parse(character: char) -> Option<Expression> {
//     match character {
//         '+' => Some(Expression::Operator(Box::new(|x, y| {x + y}))),
//         '-' => Some(Expression::Operator(Box::new(|x, y| {x - y}))),
//         '*' => Some(Expression::Operator(Box::new(|x, y| {x * y}))),
//         '/' => Some(Expression::Operator(Box::new(|x, y| {x / y}))),
//         _ => None
//     }
// }