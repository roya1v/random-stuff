

pub struct Calculator {
    buffer: String,
    display_callback: Option<Box<dyn Fn(&str) -> ()>>
}

 impl Calculator {
    pub fn new() -> Self {
        Self {display_callback: None, buffer: "".to_string()}
    }


    pub fn set_display(&mut self, callback: Box<dyn Fn(&str) -> ()>) {
        self.display_callback = Some(callback);
    }

    pub fn input(&mut self, value: char) {
        self.buffer.push(value);
        self.display_callback.as_ref().unwrap()(self.buffer.as_str())
    }
}