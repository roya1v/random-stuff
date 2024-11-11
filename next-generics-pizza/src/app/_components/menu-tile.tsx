import { MenuItem } from "~/lib/menu-item";

export type MenuTileProps = {
  item: MenuItem;
};

export function MenuTile({ item }: MenuTileProps) {
  return (
    <div>
      <img src={`http://localhost:8080/menu/${item.id}/image`}></img>
      <div className="text-2xl">{item.title}</div>
      <div className="text-sm">{item.description}</div>
    </div>
  );
}
