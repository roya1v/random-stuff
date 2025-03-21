use std::collections::VecDeque;

pub struct Calculator {
    buffer: String,
    expression: Vec<Expression>,
    display_callback: Option<Box<dyn Fn(&str) -> ()>>,
}

pub enum Expression {
    Operand(i32),
    Operator(Box<dyn Fn(i32, i32) -> i32>),
}

impl Calculator {
    pub fn new() -> Self {
        Self {
            display_callback: None,
            buffer: "".to_string(),
            expression: vec![],
        }
    }

    pub fn set_display(&mut self, callback: Box<dyn Fn(&str) -> ()>) {
        self.display_callback = Some(callback);
    }

    pub fn input(&mut self, value: char) {
        match value {
            '0' | '1' | '2' | '3' | '4' | '5' | '6' | '7' | '8' | '9' => {
                self.buffer.push(value);
                self.display_callback.as_ref().unwrap()(self.buffer.as_str())
            }
            '+' | '-' | '*' | '/' => {
                self.expression.push(Self::parse_operator(value));
                self.expression
                    .push(Expression::Operand(self.buffer.parse::<i32>().unwrap()));
                self.buffer = "".to_string();
            }
            '=' => {
                self.expression
                    .push(Expression::Operand(self.buffer.parse::<i32>().unwrap()));
                self.buffer = format!("{}", self.evaluate());
            },
            'C' => {
                self.buffer = "".to_string();
                self.expression.clear();
            }
            _ => panic!("Unexpected value {}", value),
        }
        self.display_callback.as_ref().unwrap()(self.buffer.as_str())
    }

    fn evaluate(&mut self) -> i32 {
        self.display_callback.as_ref().unwrap()("wtf");
        let mut stack: VecDeque<i32> = VecDeque::new();
        for thing in self.expression.iter().rev() {
            match thing {
                Expression::Operand(value) => stack.push_back(value.clone()),
                Expression::Operator(operation) => {
                    let b = stack.pop_back().unwrap();
                    let a = stack.pop_back().unwrap();

                    stack.push_back(operation(b, a));
                }
            }
        }
        stack.pop_back().unwrap()
    }

    fn parse_operator(value: char) -> Expression {
        match value {
            '+' => Expression::Operator(Box::new(|x, y| x + y)),
            '-' => Expression::Operator(Box::new(|x, y| x - y)),
            '*' => Expression::Operator(Box::new(|x, y| x * y)),
            '/' => Expression::Operator(Box::new(|x, y| x / y)),
            _ => panic!("{} is not a valid operator", value),
        }
    }
}
