
pub struct Calculator {
    display_callback: Option<Box<dyn Fn(&str) -> ()>>
}

 impl Calculator {
    pub fn new() -> Self {
        Self {display_callback: None}
    }


    pub fn set_display(&mut self, callback: Box<dyn Fn(&str) -> ()>) {
        self.display_callback = Some(callback);
    }

    pub fn test(&mut self) {
        self.display_callback.as_ref().unwrap()("Hello, World!")
    }
}