import express from "express";
import { MongoClient, ObjectId } from "mongodb";

const app = express();
const port = 8000;

const mongoUrl = process.env.MONGO_URL!;
const client = new MongoClient(mongoUrl);
const database = client.db("todos_db");
const collection = database.collection<ToDoItem>("todos");

interface ToDoItem {
  _id: ObjectId | null;
  content: String;
  is_done: Boolean;
}

app.use(express.json());

app.listen(port, () => {
  console.log(`Server is running on port ${port}`);
});

app.get("/api/available", async (req, res) => {
  res.json(["v1"]);
});

app.get("/api/v1/todos", async (req, res) => {
  const items = await collection.find({}).toArray();
  res.json(items);
});

app.post("/todos", async (req, res) => {
  const item: ToDoItem = {
    _id: null,
    content: req.body.content,
    is_done: req.body.is_done,
  };
  const newItem = await collection.insertOne(item);
  res.json({
    _id: newItem.insertedId,
    content: req.body.content,
    is_done: req.body.is_done,
  });
});

app.put("/todos", async (req, res) => {
  const item: ToDoItem = {
    _id: req.body._id,
    content: req.body.content,
    is_done: req.body.is_done,
  };
  const result = await collection.updateOne({ _id: item._id }, { $set: item });
  console.log(result);
  res.status(200).json(item);
});

app.delete("/todos/:todoId/delete", async (req, res) => {
  const id = req.params.todoId;

  await collection.deleteOne({ _id: new ObjectId(id) });
  res.status(200).send(`Successfully deleted item with id ${id}`);
});
