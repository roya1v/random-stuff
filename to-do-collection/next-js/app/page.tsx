"use client";
import { Button } from "@/components/ui/button";
import { Checkbox } from "@/components/ui/checkbox";
import { Input } from "@/components/ui/input";
import { useEffect, useState } from "react";

interface ToDoItem {
  id: number | undefined;
  content: string;
  is_done: boolean;
}

export default function Home() {
  const [items, setItems] = useState(Array<ToDoItem>());
  const [newItem, setNewItem] = useState("");
  useEffect(() => {
    let ignore = false;
    fetch("http://localhost:3000/todos")
      .then((resp) => resp.json() as Promise<Array<ToDoItem>>)
      .then((items) => {
        console.log(items);
        if (!ignore) {
          setItems(items);
        }
      });
    return () => {
      ignore = true;
    };
  }, []);

  const updateItem = (updatedItem: ToDoItem, newChecked: boolean) => {
    updatedItem.is_done = newChecked;
    setItems(
      items.map((item) =>
        item.id === updatedItem.id ? { ...item, is_done: newChecked } : item
      )
    );
    fetch("http://localhost:3000/todos", {
      method: "PUT",
      body: JSON.stringify(updatedItem),
      headers: { "Content-Type": "application/json" },
    });
  };

  const createNewItem = (content: string) => {
    let item: ToDoItem = {
      content: content,
      id: undefined,
      is_done: false,
    };
    fetch("http://localhost:3000/todos", {
      method: "POST",
      body: JSON.stringify(item),
      headers: { "Content-Type": "application/json" },
    });
  };

  return (
    <div className="h-full flex flex-col justify-center items-center">
      <div className="text-2xl">To Do App</div>
      <ul className="w-96">
        {items.map((item) => (
          <li
            key={item.id}
            className="flex rounded bg-slate-200 p-2 m-2  items-center justify-between"
          >
            <div className="">{item.content}</div>
            <Checkbox
              checked={item.is_done}
              onCheckedChange={(checked) =>
                updateItem(item, checked as boolean)
              }
            />
          </li>
        ))}
      </ul>
      <form className="w-96 px-2 flex items-stretch h-10">
        <Input
          placeholder="New todo item..."
          onChange={(event) => setNewItem(event.target.value)}
        />
        <Button
          onClick={() => createNewItem(newItem)}
          variant="default"
          className="ml-2"
        >
          Create
        </Button>
      </form>
    </div>
  );
}
