import * as schema from "@/db/schema";
import { drizzle, useLiveQuery } from "drizzle-orm/expo-sqlite";
import { useDrizzleStudio } from "expo-drizzle-studio-plugin";
import { useRouter } from "expo-router";
import { useSQLiteContext } from "expo-sqlite";
import { Appbar, Button, List } from "react-native-paper";

function ItemsList() {
  const db = useSQLiteContext();
  const drizzleDb = drizzle(db, { schema });
  const { data } = useLiveQuery(drizzleDb.select().from(schema.todoItems));
  useDrizzleStudio(db);
  const router = useRouter();
  return (
    <>
      <Appbar.Header>
        <Appbar.Content title="Items" />
        <Appbar.Action
          icon="plus"
          onPress={() => {
            router.navigate("/newItem");
          }}
        />
      </Appbar.Header>
      {data.map((item) => (
        <List.Item key={item.id} title={item.description}></List.Item>
      ))}
      <Button
        mode="elevated"
        onPress={async () => {
          await drizzleDb
            .insert(schema.todoItems)
            .values({ description: "New item" });
          console.log("Tapped!");
        }}
      >
        Add new item
      </Button>
    </>
  );
}

export default function Items() {
  const db = useSQLiteContext();
  const drizzleDb = drizzle(db, { schema });
  const { data } = useLiveQuery(drizzleDb.select().from(schema.todoItems));
  useDrizzleStudio(db);
  const router = useRouter();
  return (
    <>
      <Appbar.Header>
        <Appbar.Content title="Items" />
        <Appbar.Action
          icon="plus"
          onPress={() => {
            router.navigate("/newItem");
          }}
        />
      </Appbar.Header>
      {data.map((item) => (
        <List.Item key={item.id} title={item.description}></List.Item>
      ))}
      <Button
        mode="elevated"
        onPress={async () => {
          await drizzleDb
            .insert(schema.todoItems)
            .values({ description: "New item" });
          console.log("Tapped!");
        }}
      >
        Add new item
      </Button>
    </>
  );
}
