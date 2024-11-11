"use client";
import { useRouter } from "next/navigation";
import { useState, useEffect } from "react";
import { MenuItem } from "~/lib/menu-item";

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
        console.log(params.itemId);
      });
      params.then((params) => {
        setItem(
          body.filter((item) => {
            return item.id === params.itemId;
          })[0],
        );
      });
    });
  }, []);
  return (
    <>
      <div className="text-3xl">{item?.title}</div>
      <div className="">{item?.description}</div>
    </>
  );
}
