from fastapi import Depends, FastAPI
from sqlalchemy.orm import Session

from . import crud, models, schemas
from .database import SessionLocal, engine

models.Base.metadata.create_all(bind=engine)
app = FastAPI()

# Dependency
def get_db():
    db = SessionLocal()
    try:
        yield db
    finally:
        db.close()

@app.get("/todos")
def get_all_todos(db: Session = Depends(get_db)) -> list[schemas.ToDoItem]:
    items = crud.get_items(db)
    return items

@app.post("/todos")
def create_todo(item: schemas.ToDoItemCreate, db: Session = Depends(get_db)):
    return crud.create_item(db, item)

@app.put("/todos")
def update_todo(item: schemas.ToDoItem):
    return {"Hello": "World"}

@app.delete("/todos/{todo_id}/delete")
def delete_todo(todo_id: int):
    return {"Hello": "World"}