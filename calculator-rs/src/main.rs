use std::cell::RefCell;
use std::rc::Rc;

use libadwaita::prelude::*;

use libadwaita::gtk::{Box, Button, Label, Orientation};
use libadwaita::{Application, ApplicationWindow, HeaderBar};
use logic::Calculator;

mod logic;

fn main() {
    let application = Application::builder()
        .application_id("com.example.FirstAdwaitaApp")
        .build();

    application.connect_activate(|app| {
        let content = Box::new(Orientation::Vertical, 0);

        let mut calculator = Calculator::new();

        content.append(&HeaderBar::new());
        let label = Label::builder().label("test").build();
        content.append(&label);

        let test = Rc::new(label);

        test.set_label("hello");

        let test2 = test.clone();
        calculator.set_display(std::boxed::Box::new(move |new_label| {
            test2.set_label(&new_label);
        }));

        setup_keypad(&content, Rc::new(RefCell::new(calculator)));

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

fn setup_keypad(content: &Box, calculator: Rc<RefCell<Calculator>>) {
    let cancel_button = get_button(calculator.clone(), 'C', "C");
    let idk_button = get_button(calculator.clone(), '*', "idk");
    let percent_button = get_button(calculator.clone(), '%', "%");
    let divide_button = get_button(calculator.clone(), '/', "/");

    let row = Box::new(Orientation::Horizontal, 0);
    row.append(&cancel_button);
    row.append(&idk_button);
    row.append(&percent_button);
    row.append(&divide_button);

    content.append(&row);

    let seven_button = get_button(calculator.clone(), '7', "7");
    let eight_button = get_button(calculator.clone(), '8', "8");
    let nine_button = get_button(calculator.clone(), '9', "9");
    let multiply_button = get_button(calculator.clone(), '*', "*");

    let row = Box::new(Orientation::Horizontal, 0);
    row.append(&seven_button);
    row.append(&eight_button);
    row.append(&nine_button);
    row.append(&multiply_button);

    content.append(&row);

    let four_button = get_button(calculator.clone(), '4', "4");
    let five_button = get_button(calculator.clone(), '5', "5");
    let six_button = get_button(calculator.clone(), '6', "6");
    let minus_button = get_button(calculator.clone(), '-', "-");

    let row = Box::new(Orientation::Horizontal, 0);
    row.append(&four_button);
    row.append(&five_button);
    row.append(&six_button);
    row.append(&minus_button);

    content.append(&row);

    let one_button = get_button(calculator.clone(), '1', "1");
    let two_button = get_button(calculator.clone(), '2', "2");
    let three_button = get_button(calculator.clone(), '3', "3");
    let plus_button = get_button(calculator.clone(), '+', "+");

    let row = Box::new(Orientation::Horizontal, 0);
    row.append(&one_button);
    row.append(&two_button);
    row.append(&three_button);
    row.append(&plus_button);

    content.append(&row);

    let idk_button = get_button(calculator.clone(), '*', "idk");
    let zero_button = get_button(calculator.clone(), '0', "0");
    let comma_button = get_button(calculator.clone(), ',', ",");
    let equals_button = get_button(calculator.clone(), '=', "=");

    let row = Box::new(Orientation::Horizontal, 0);
    row.append(&idk_button);
    row.append(&zero_button);
    row.append(&comma_button);
    row.append(&equals_button);

    content.append(&row);
}

fn get_button(calculator: Rc<RefCell<Calculator>>, value: char, label: &str) -> Button {
    let button = Button::builder()
        .label(label)
        .margin_top(12)
        .margin_bottom(12)
        .margin_start(12)
        .margin_end(12)
        .build();

    button.connect_clicked(move |_| {
        calculator.clone().borrow_mut().input(value);
    });

    button
}
