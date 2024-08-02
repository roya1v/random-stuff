from sqlalchemy.orm import Session

from . import models, schemas

def get_items(db: Session):
    return db.query(models.ToDoItem).all()

def create_item(db: Session, item: schemas.ToDoItemCreate):
    db_item = models.ToDoItem(content=item.content, is_done=item.is_done)
    db.add(db_item)
    db.commit()
    db.refresh(db_item)
    return db_item