use core::panic;
use std::cell::{Ref, RefCell};
use std::rc::Rc;
use std::{fmt::Error, io, vec};

use libadwaita::gtk::builders::LabelBuilder;
use libadwaita::prelude::*;

use libadwaita::{ActionRow, Application, ApplicationWindow, HeaderBar};
use libadwaita::gtk::{Box, Button, Label, ListBox, Orientation, SelectionMode};
use logic::Calculator;

mod calculator;
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
        calculator.set_display(std::boxed::Box::new( move |new_label| {
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

    let mut test = calculator.clone();
    one_button.connect_clicked(move |_| {
        test.borrow_mut().test();
    });
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