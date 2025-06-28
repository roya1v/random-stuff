import "react-native-reanimated";

import { useState } from "react";
import { BottomNavigation } from "react-native-paper";
import Items from "./items";
import Settings from "./settings";

import migrations from "@/drizzle/migrations";
import { drizzle } from "drizzle-orm/expo-sqlite";
import { useMigrations } from "drizzle-orm/expo-sqlite/migrator";
import { SQLiteProvider, openDatabaseSync } from "expo-sqlite";
import { Suspense } from "react";
import { ActivityIndicator } from "react-native";

export const DATABASE_NAME = "todos";

export default function RootLayout() {
  const expoDb = openDatabaseSync(DATABASE_NAME);
  const db = drizzle(expoDb);
  const { success, error } = useMigrations(db, migrations);

  const [index, setIndex] = useState(0);
  const [routes] = useState([
    { key: "items", title: "Items", focusedIcon: "list-box" },
    { key: "settings", title: "Settings", focusedIcon: "cog" },
  ]);

  const renderScene = BottomNavigation.SceneMap({
    items: Items,
    settings: Settings,
  });

  return (
    <Suspense fallback={<ActivityIndicator size="large" />}>
      <SQLiteProvider
        databaseName={DATABASE_NAME}
        options={{ enableChangeListener: true }}
        useSuspense
      >
        <BottomNavigation
          navigationState={{ index, routes }}
          onIndexChange={setIndex}
          renderScene={renderScene}
        />
      </SQLiteProvider>
    </Suspense>
  );
}
