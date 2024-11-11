import { useRouter } from "next/navigation";
import { MenuItem } from "~/lib/menu-item";

export type MenuTileProps = {
  item: MenuItem;
};

export function MenuTile({ item }: MenuTileProps) {
  const router = useRouter();
  return (
    <div
      className="m-4 cursor-pointer"
      onClick={() => {
        router.push(`/${item.id}`);
      }}
    >
      <img src={`http://localhost:8080/menu/${item.id}/image`}></img>
      <div className="text-2xl">{item.title}</div>
      <div className="line-clamp-2 text-sm">{item.description}</div>
    </div>
  );
}
