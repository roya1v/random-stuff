import { MenuItem } from "~/lib/menu-item";
import { MenuTile } from "./_components/menu-tile";

export default async function HomePage() {
  const resp = await fetch("http://localhost:8080/menu");
  const items: MenuItem[] = await resp.json();
  return (
    <main className="grid grid-cols-5">
      {items?.map((item) => {
        return <MenuTile key={item.id} item={item} />;
      })}
    </main>
  );
}
