import express from 'express';

const app = express();
const port = 8000;


app.listen(port, () => {
  console.log(`Server is running on port ${port}`);
});

app.get('/todos', (req, res) => {
  res.send([
    {id: 1, content: "Test",  is_done: false}
  ]);
});

app.post('/todos', (req, res) => {
    res.send({
        id: 1,
        content: "Test",
        is_done: false
    });
});

app.put('/todos', (req, res) => {
    res.send({
        id: 1,
        content: "Test",
        is_done: false
    });
});

app.delete('/todos/:todoId/delete', (req, res) => {
    res.send({
        id: 1,
        content: "Test",
        is_done: false
    });
});