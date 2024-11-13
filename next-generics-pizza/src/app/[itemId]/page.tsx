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
    <div className="flex flex-row items-center p-4">
      <div className="basis-1/2">
        <img
          src={`http://localhost:8080/menu/${item?.id}/image`}
          className="object-contain"
        ></img>
      </div>

      <div className="">
        <div className="text-5xl">{item?.title}</div>
        <div className="">{item?.description}</div>
        <button
          className="rounded-lg bg-black px-4 py-2 text-white transition hover:scale-110"
          onClick={() => onClick(item!)}
        >
          Add to cart
        </button>
      </div>
    </div>
  );
}
