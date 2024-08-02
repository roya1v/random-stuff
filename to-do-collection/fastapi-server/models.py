from sqlalchemy import Boolean, Column, Integer, String

from .database import Base

class ToDoItem(Base):
    __tablename__ = "todo_items"

    id = Column(Integer, primary_key=True)
    content = Column(String, index=False)
    is_done = Column(Boolean, index=False)