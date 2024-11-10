"use client";
import { useEffect, useState } from "react";

type MenuItem = {
  id: string;
  title: string;
  description: string;
};

export default function HomePage() {
  const [items, setItems] = useState<null | MenuItem[]>();
  useEffect(() => {
    fetch("http://localhost:8080/menu").then(async (resp) => {
      const body = await resp.json();
      setItems(body);
    });
  }, []);
  return (
    <main className="flex flex-col bg-white">
      {items?.map((item) => {
        return (
          <div key={item.id}>
            <div className="text-2xl">{item.title}</div>
            <div className="">{item.description}</div>
          </div>
        );
      })}
    </main>
  );
}
