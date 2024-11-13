"use client";
import { useCartStore } from "../_cartStore";

export default function Cart() {
  const cart = useCartStore((state) => state.items);
  return (
    <div>
      {cart.map((item) => {
        return <div key={item.id}>{item.title}</div>;
      })}
    </div>
  );
}
