from textual.app import App, ComposeResult
from textual.widgets import Footer, Label, ListItem, ListView, Button
from textual.reactive import reactive
from textual import events


class TodoApp(App):

    BINDINGS = [("a", "add_item", "Add new item")]

    def compose(self) -> ComposeResult:
        yield ListView()
        yield Footer()

    def action_add_item(self) -> None:
        self.query_one(ListView).mount(ListItem(Label("item")))


if __name__ == "__main__":
    app = TodoApp()
    app.run()
