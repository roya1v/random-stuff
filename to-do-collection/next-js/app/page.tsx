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
            <Checkbox checked={item.is_done}/>
          </li>
        ))}
      </ul>
      <form className="w-96 px-2 flex items-stretch h-10">
        <Input placeholder="New todo item..." />
        <Button variant="default" className="ml-2">
          Create
        </Button>
      </form>
    </div>
  );
}
