from pydantic import BaseModel

class ToDoItem(BaseModel):
    id: int| None
    content: str
    is_done: bool

class ToDoItemCreate(BaseModel):
    content: str
    is_done: bool