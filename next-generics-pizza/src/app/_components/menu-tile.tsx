import Link from "next/link";
import { MenuItem } from "~/lib/menu-item";

export type MenuTileProps = {
  item: MenuItem;
};

export function MenuTile({ item }: MenuTileProps) {
  return (
    <Link className="m-4 cursor-pointer" href={`/${item.id}`}>
      <img src={`http://localhost:8080/menu/${item.id}/image`}></img>
      <div className="text-2xl">{item.title}</div>
      <div className="line-clamp-2 text-sm">{item.description}</div>
    </Link>
  );
}
