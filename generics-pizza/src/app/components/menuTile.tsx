"use client";
import { Button } from "@/components/ui/button";
import {
  Dialog,
  DialogContent,
  DialogHeader,
  DialogTitle,
  DialogTrigger,
} from "@/components/ui/dialog";
import { useQuery } from "@tanstack/react-query";
import { MenuItem } from "../api";

export interface MenuItemProps {
  item: MenuItem;
}

export function MenuTile({ item }: MenuItemProps) {
  const { isPending, error, data } = useQuery({
    queryKey: ["repoImage" + item.id],
    queryFn: () =>
      fetch("http://localhost:8080/menu/" + item.id + "/image")
        .then((res) => res.blob())
        .then((blob) => URL.createObjectURL(blob)),
  });

  if (isPending) return "Loading...";

  if (error) return "An error has occurred: " + error.message;
  return (
    <Dialog>
      <DialogTrigger asChild>
        <div className="flex-1 p-4 rounded-lg shadow-lg m-2 flex flex-col">
          <img src={data}></img>
          <h1 className="text-xl">{item.title}</h1>
          <h2 className="text-s grow">{item.description}</h2>
          <div className="flex flex-row-reverse">
            <Button>Select</Button>
          </div>
        </div>
      </DialogTrigger>
      <DialogContent className="sm:max-w-[425px]">
        <DialogHeader>
          <DialogTitle>{item.title}</DialogTitle>
          <img src={data}></img>
          <h2 className="text-s">{item.description}</h2>
          <Button>Add to cart</Button>
        </DialogHeader>
      </DialogContent>
    </Dialog>
  );
}
