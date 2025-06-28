import { integer, sqliteTable, text } from "drizzle-orm/sqlite-core";

export const todoItems = sqliteTable("todos", {
  id: integer("id").primaryKey({ autoIncrement: true }),
  description: text("description").notNull(),
});

export type TodoItem = typeof todoItems.$inferSelect;
