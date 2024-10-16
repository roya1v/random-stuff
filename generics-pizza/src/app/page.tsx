"use client";
import { QueryClient, QueryClientProvider } from "@tanstack/react-query";

import React from "react";
import { useQuery } from "@tanstack/react-query";
import { MenuItem } from "./api";
import { MenuTile } from "./components/menuTile";

export default function Home() {
  const [queryClient] = React.useState(() => new QueryClient());
  return (
    <QueryClientProvider client={queryClient}>
      <div className="min-h-screen">
        <header className="sticky top-0 flex h-16 items-center gap-4 border-b bg-background px-4 md:px-6">
          <h1 className="text-xl"> Generic's pizza </h1>
        </header>
        <Menu />
      </div>
    </QueryClientProvider>
  );
}

function Menu() {
  async function fetchItems(): Promise<MenuItem[]> {
    let response = await fetch("http://localhost:8080/menu");

    return await response.json();
  }

  const { isPending, error, data } = useQuery({
    queryKey: ["repoData"],
    queryFn: fetchItems,
  });

  if (isPending) return "Loading...";

  if (error) return "An error has occurred: " + error.message;

  return (
    <div className="flex">
      {data.map((item) => {
        return <MenuTile item={item} />;
      })}
    </div>
  );
}
