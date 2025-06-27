import "react-native-reanimated";

import { useState } from "react";
import { BottomNavigation } from "react-native-paper";
import Items from "./items";
import Settings from "./settings";

export default function RootLayout() {
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
    <BottomNavigation
      navigationState={{ index, routes }}
      onIndexChange={setIndex}
      renderScene={renderScene}
    />
  );
}
