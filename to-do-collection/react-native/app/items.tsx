import { Appbar, List } from "react-native-paper";

export default function Items() {
  const items: string[] = ["Hello, world!", "Item number 2"];
  return (
    <>
      <Appbar.Header>
        <Appbar.Content title="Items" />
        <Appbar.Action icon="plus" onPress={() => {}} />
      </Appbar.Header>
      {items.map((item) => (
        <List.Item title={item}></List.Item>
      ))}
    </>
  );
}
