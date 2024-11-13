"use client";
import { useState, useEffect } from "react";
import { MenuItem } from "~/lib/menu-item";
import { useCartStore } from "../_cartStore";

export default function ItemPage({
  params,
}: {
  params: Promise<{ itemId: string }>;
}) {
  const [item, setItem] = useState<null | MenuItem>();
  useEffect(() => {
    fetch("http://localhost:8080/menu/").then(async (resp) => {
      const body: MenuItem[] = await resp.json();
      params.then((params) => {
        setItem(
          body.filter((item) => {
            return item.id === params.itemId;
          })[0],
        );
      });
    });
  }, []);
  const onClick = useCartStore((state) => state.addItem);
  return (
    <>
      <div className="text-3xl">{item?.title}</div>
      <img src={`http://localhost:8080/menu/${item?.id}/image`}></img>
      <div className="">{item?.description}</div>
      <button onClick={() => onClick(item!)}>Add to cart</button>
    </>
  );
}
