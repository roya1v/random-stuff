"use client";
import { useEffect, useState } from "react";
import { MenuItem } from "~/lib/menu-item";
import { MenuTile } from "./_components/menu-tile";

export default function HomePage() {
  const [items, setItems] = useState<null | MenuItem[]>();
  useEffect(() => {
    fetch("http://localhost:8080/menu").then(async (resp) => {
      const body = await resp.json();
      setItems(body);
    });
  }, []);
  return (
    <main className="grid grid-cols-5">
      {items?.map((item) => {
        return <MenuTile key={item.id} item={item} />;
      })}
    </main>
  );
}
