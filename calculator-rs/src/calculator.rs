use std::{ fmt::Error, io};

fn test() {
    loop {
        let mut expression = String::new();
        let stdin = io::stdin(); // We get `Stdin` here.
        stdin.read_line(&mut expression).unwrap();
        let result = evaluate_polish_notion(&expression.trim()).unwrap();
        println !("={}", result); 
    }
}

pub enum Expression {
    Operand(i32),
    Operator(Box<dyn Fn(i32, i32) -> i32>)
}

fn evaluate_polish_notion(expression: &str) -> Result<i32, Error> {
    let mut expressions: Vec<Expression> = vec![];
    let mut buffer: Vec<char> = vec![];
    for char in expression.chars() {
        if let Some(expression) = parse(char) {
            let operand = buffer.clone().into_iter().collect::<String>().parse::<i32>().unwrap();
            expressions.push(Expression::Operand(operand));
            buffer.clear();
            expressions.push(expression);
        } else {
            buffer.push(char);
        }
    }
    if !buffer.is_empty() {
        let operand = buffer.clone().into_iter().collect::<String>().parse::<i32>().unwrap();
        expressions.push(Expression::Operand(operand));
    }

    let mut x = Option::<i32>::None;
    let mut operator = Option::<Box<dyn Fn(i32, i32) -> i32>>::None;

    for expression in expressions.iter() {
        
        match expression {
            Expression::Operand(y) => {
                if let Some(x1) = x   {
                    if let Some(operator2) = operator {
                        let test = operator2(*y, x1);
                        x = Some(test);
                        operator = None;
                    }
                } else {
                    x = Some(*y)
                }
            },
            Expression::Operator(operator2) => operator = Some(Box::new(operator2)),
        }
    }
    
    Ok(x.unwrap())
}

fn parse(character: char) -> Option<Expression> {
    match character {
        '+' => Some(Expression::Operator(Box::new(|x, y| {x + y}))),
        '-' => Some(Expression::Operator(Box::new(|x, y| {x - y}))),
        '*' => Some(Expression::Operator(Box::new(|x, y| {x * y}))),
        '/' => Some(Expression::Operator(Box::new(|x, y| {x / y}))),
        _ => None
    }
}