-- Add up migration script here
CREATE TABLE todos (
    id INTEGER NOT NULL PRIMARY KEY,
    content TEXT NOT NULL,
    is_done INTEGER NOT NULL
);