import { create } from "zustand";
import { MenuItem } from "~/lib/menu-item";

export interface CartState {
  items: MenuItem[];
  addItem: (item: MenuItem) => void;
}

export const useCartStore = create<CartState>()((set) => ({
  items: [],
  addItem: (item) => set((state) => ({ items: [item, ...state.items] })),
}));
