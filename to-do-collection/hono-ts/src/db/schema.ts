import { boolean, integer, pgTable, varchar } from "drizzle-orm/pg-core";

export const todosTable = pgTable("todos", {
  id: integer().primaryKey().generatedAlwaysAsIdentity(),
  content: varchar({ length: 255 }).notNull(),
  is_done: boolean().notNull().default(false),
});
